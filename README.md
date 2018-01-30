# June

a READ-ONLY Selenium, with an HTTP API

## Requirements

1. Firefox Browser
2. [Geckodriver](https://github.com/mozilla/geckodriver/releases) move to `/usr/bin`
3. Java (tested on Java 8)
4. [Selenium](http://selenium-release.storage.googleapis.com/3.8/selenium-server-standalone-3.8.1.jar)

## Installation

```
git clone https://github.com/codenoid/June.git
cd June
sudo make
```

## Usage

1. Start a new June server

```
java -jar selenium-server-standalone-3.8.1.jar & # or start inside `screen`
june --browser 2 --port 3000
```

`--browser` for starting june with 2 active browser

`--port` define port for HTTP API

2. Do POST request (application/x-www-form-urlencoded) with params url

```
curl -d "url=https://shopee.co.id" -X POST http://localhost:3000/
```

## Development

- [x] Customizable
- [x] Multiple Browser
- [x] Balancing
- [ ] "Remove" Requirements
- [ ] Debug Mode
- [ ] Validation
- [ ] Test

## Contributing

1. Fork it ( https://github.com/codenoid/June/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [codenoid](https://github.com/codenoid) Rubi Jihantoro - creator, maintainer
- Thanks ! [ysbaddaden](https://github.com/ysbaddaden)