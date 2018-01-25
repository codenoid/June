def parse(body)
  params = {} of String => String
  body = body.split("&")
  body.each do |v|
    v = v.split("=")
    params[v[0]] = v[1]
  end
  return params
end

# :nodoc:
session = June::WebDriver.new
session.start

server = HTTP::Server.new(8080) do |context|
  if context.request.method == "POST"
    body = parse(context.request.body.not_nil!.gets_to_end)

    if body["url"].size > 5 # require http|s://, NTF
      session.url = body["url"]
      result = session.source.to_s # prevent firefox page
      context.response.print result
    else
      context.response.content_type = "text/plain"
      context.response.print "Invalid url"
    end
  end
end

server.listen
