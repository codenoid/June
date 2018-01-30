# June

a READ-ONLY Selenium, with an HTTP API

## Installation

```
git clone https://github.com/codenoid/June.git
cd June
make
```

## Usage

1. Start a new June server

```
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