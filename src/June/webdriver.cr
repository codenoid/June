require "./errors.cr"

module June
  class WebDriver
    def initialize(@host = "localhost", @port = 4444, @path = "/wd/hub", @tls = false)
      @client = HTTP::Client.new(host, port, tls: tls)
    end

    def start
      capabilities = {
        browserName:          "firefox",
        platform:             "ANY",
        "moz:firefoxOptions": {"args" => ["-headless"]},
      }

      body = {
        "desiredCapabilities"  => capabilities,
        "requiredCapabilities" => capabilities,
      }

      response = post("/session", body)
      response["sessionId"].to_s.as(String) || nil
    end

    def check
      get("/sessions")
    end

    def url(id, url)
      post("/session/#{id}/url", {url: url})
    end

    def source(id)
      body = get("/session/#{id}/source")
      body["value"]
    end

    def close(id)
      delete("/session/#{id}")
    end

    def get(path)
      headers = HTTP::Headers{"Accept" => "application/json"}
      response = @client.get("#{@path}#{path}", headers)

      case response.status_code
      when 200
        JSON.parse(response.body)
      else
        failure(response)
      end
    end

    def post(path, body = false)
      if body
        headers = HTTP::Headers{"Content-Type" => "application/json; charset=UTF-8"}
        response = @client.post("#{@path}#{path}", headers, body.to_json)
      else
        response = @client.post("#{@path}#{path}")
      end

      case response.status_code
      when 200
        JSON.parse(response.body)
      else
        failure(response)
      end
    end

    def delete(path)
      response = @client.delete("#{@path}#{path}")

      raise Error.new(response.body) unless response.status_code == 200
      true
    end

    private def failure(response)
      JSON.parse("{}")
    end
  end
end
