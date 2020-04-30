# VGIF

[![Test](https://github.com/i544c/vgif/workflows/Test/badge.svg?branch=master)](https://github.com/i544c/vgif/actions?query=branch%3Amaster+)

![](https://camo.githubusercontent.com/efa7e5e9ce15b54a651829ccbce141ea252110de/68747470733a2f2f643276396b357534763934756c772e636c6f756466726f6e742e6e65742f6173736574732f696d616765732f343931373732332f6f726967696e616c2f31343865643835312d653136662d346333612d623631652d3139376331323430376338613f31353837333035383835)

VTuberのAnimated GIFを共有するウェブアプリケーション。

## Requirement
- Ruby ~> 2.6.6
- Node.js ~> 10.15.2
- PostgreSQL ~> 12.2
- GoogleChrome >= 3.141.59 (For E2E test)

- Docker >= 19.03.8-ce
- docker-compose >= 1.25.5

## Development
With Docker, it's easy to develop.
```
docker-compose up -d
docker-compose exec rails rails db:setup
```

After this, you can access http://localhost:3000 and start development.
