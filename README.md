Build docker image:
`docker image build -t docker-hugo:latest .`

Serve hugo website (in current dir):
`docker container run --rm -it -v $(pwd):/home/devuser --publish 1313:1313 docker-hugo:latest server --bind 0.0.0.0`

Build hugo website for local preview (on port 8000):
`docker container run --rm -it -v $(pwd):/home/devuser docker-hugo:latest --baseUrl=http://localhost:8000`

Build hugo website for live hosting (website url already defined in config.toml):
`docker container run --rm -it -v $(pwd):/home/devuser docker-hugo:latest`

Get into a shell inside the container:
`docker container run --rm -it -v $(pwd):/home/devuser --entrypoint='' docker-hugo:latest /bin/bash`

