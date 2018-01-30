# June::Application
Status = {} of String => String
require "option_parser"
require "http"
require "json"
require "./June/webdriver.cr"

module June
  class Application
    def initialize
      @session = June::WebDriver.new
      at_exit { killall }

      browser : Int32 = 1
      port : Int32 = 2910

      OptionParser.parse! do |parser|
        parser.banner = "Usage: june --option [arguments]"
        parser.on("-b BROWSER", "--browser=BROWSER", "Total of Used Browser (Default 1)") { |v| browser = v.to_s.to_i > 1 ? v.to_s.to_i : 1 }
        parser.on("-p PORT", "--port=PORT", "Specifies the HTTP API port") { |v| port = v.to_s.to_i if v != port }
        parser.on("-h", "--help", "Show this help") { puts parser }
      end

      browser.times do |i|
        session_id = @session.start
        puts session_id
        Status[session_id] = "idle" if !session_id.nil?
      end
      server(port)
    end

    def idle
      Status.each { |k, v| return k if v == "idle" }
    end

    def server(port : Int32)
      server = HTTP::Server.new(port) do |context|
        if context.request.method == "POST"
          body = parse(context.request.body.not_nil!.gets_to_end)

          if body["url"].size > 5
            browser = idle
            if browser
              Status[browser] = "used"
              @session.url(browser, body["url"])
              result = @session.source(browser).to_s
              Status[browser] = "idle"
              context.response.print result
            else
              context.response.print "Service not available"
            end
          else
            context.response.content_type = "text/plain"
            context.response.print "Invalid url"
          end
        end
      end
      puts "Listening on http://0.0.0.0:#{port}"
      server.listen
    end

    def parse(body)
      params = {} of String => String
      body = body.split("&")
      body.each do |v|
        v = v.split("=")
        params[v[0]] = v[1]
      end
      params
    end

    def killall
      Status.each { |k, v| @session.close(k) }
    end
  end
end

June::Application.new
