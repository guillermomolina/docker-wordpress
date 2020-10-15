# docker-wordpress
A container with wordpress based on archlinux with apache

## Usage

- Start the container manually

```bash
# docker run -p 8080:80 guillermomolina/wordpress:latest
```

- Start with docker-compose

```bash
# cd docker-wordpress
# docker-compose up
```

- Start with docker swarm

```bash
# cd docker-wordpress
# docker stack deploy -c ./docker-stack.yml wordpress
```
