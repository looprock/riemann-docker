# riemann-docker
Docker image for riemann based on the one at: https://github.com/patrickod/riemann-docker. This installed riemann 0.2.12 and riemann-dash

# Example usage:

docker build -t dland/riemann-all .

docker run -d --name riemann -p 5555:5555 -p 5555:5555/udp -p 5556:5556 -p 4567:4567 dland/riemann-all

next, point your browser at: http://localhost:4567/
