### groups

group "default" {
  targets = ["redis-cluster"]
}

### targets

target "redis-cluster" {
  platforms = ["linux/amd64", "linux/arm64"]
  dockerfile = "./Dockerfile"
  context = "./redis-cluster"
  tags = [
    "docker.io/makeomatic/redis-stack-cluster:latest",
    "docker.io/makeomatic/redis-stack-cluster:6"
  ]
  contexts = {
    "redis/redis-stack-server": "docker-image://redis/redis-stack-server:6.2.6-v7"
  }
}
