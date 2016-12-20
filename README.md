# riemann-docker
Docker image for riemann based on the one at: https://github.com/patrickod/riemann-docker. This installed riemann 0.2.12 and riemann-health

# Example build:

docker build -t looprock/riemann-all .

# Usage

docker run -d --name riemann -p 5555:5555 -p 5555:5555/udp -p 5556:5556 looprock/riemann-server
docker run -d -p 4567:4567 looprock/riemann-dash
docker run --link riemann:riemann -d looprock/riemann-python-test

next, point your browser at: http://localhost:4567/
