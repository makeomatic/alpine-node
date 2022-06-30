
variable "NODE_VERSION" {

}

variable "BASE" {
  default = "docker.io/makeomatic/node"
}

### helper functions

function "join_tags" {
  params = [ver]
  result = [ver[0], "${ver[0]}.${ver[1]}", "${ver[0]}.${ver[1]}.${ver[2]}"]
}

function "extract_tags" {
  params = [version]
  result = join_tags(regex("^([0-9]+)\\.([0-9]+)\\.([0-9]+)$", version))
}

function "ver_tags" {
  params = [base, version, suffix]
  result = formatlist(notequal(suffix, "") ? "${base}:%s-${suffix}" : "${base}:%s", extract_tags(version))
}

### groups

group "default" {
  targets = [
    "base-containers",
    "alpine-rdkafka",
    "debian-rdkafka",
    "ssh",
    "chrome-containers",
    "vips-containers",
  ]
}

group "base-containers" {
  targets = [
    "alpine", 
    "debian", 
    "alpine-tester"
  ]
}

group "alpine-rdkafka" {
  targets = [
    "alpine-rdkafka",
    "alpine-tester-rdkafka"
  ]
}

group "chrome-containers" {
  targets = [
    "chrome",
    "chrome-tester"
  ]
}

group "vips-containers" {
  targets = [
    "vips",
    "vips-tester",
    "vips-tester-chrome",
    "vips-tester-docker",
    "vips-ssh"
  ]
}

### targets

target "base" {
  dockerfile = "./node/Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
}

target "alpine" {
  inherits = ["base"]
  tags = ver_tags(BASE, NODE_VERSION, "")
  contexts = {
    node = "docker-image://node:${NODE_VERSION}-alpine"
  }
}

target "debian" {
  inherits = ["base"]
  tags = ver_tags(BASE, NODE_VERSION, "debian")
  contexts = {
    node = "docker-image://node:${NODE_VERSION}"
  }
}

# rdkafka

target "alpine-rdkafka" {
  inherits = ["base"]
  dockerfile = "./node/Dockerfile.rdkafka"
  tags = ver_tags(BASE, NODE_VERSION, "rdkafka")
  contexts = {
    "makeomatic/node" = "target:alpine"
  }
}

target "debian-rdkafka" {
  inherits = ["base"]
  dockerfile = "./node/Dockerfile.debian-rdkafka"
  tags = ver_tags(BASE, NODE_VERSION, "debian-rdkafka")
  contexts = {
    "makeomatic/node" = "target:debian"
  }
}

# tester

target "alpine-tester" {
  inherits = ["base"]
  dockerfile = "./node/Dockerfile.tester"
  tags = ver_tags(BASE, NODE_VERSION, "tester")
  contexts = {
    "makeomatic/node" = "target:alpine"
  }
}

target "alpine-tester-rdkafka" {
  inherits = ["base"]
  dockerfile = "./node/Dockerfile.tester-rdkafka"
  tags = ver_tags(BASE, NODE_VERSION, "tester-rdkafka")
  contexts = {
    "makeomatic/node" = "target:alpine-rdkafka"
  }
}

# chrome

target "chrome" {
  inherits = ["base"]
  dockerfile = "./node-chrome/Dockerfile"
  tags = ver_tags(BASE, NODE_VERSION, "chrome")
  contexts = {
    "makeomatic/node" = "target:alpine"
  }
}

target "chrome-tester" {
  inherits = ["chrome"]
  dockerfile = "./node-chrome/Dockerfile.tester"
  tags = ver_tags(BASE, NODE_VERSION, "chrome-tester")
  contexts = {
    "makeomatic/node" = "target:chrome"
  }
}

# ssh

target "ssh" {
  inherits = ["base"]
  dockerfile = "./node-ssh/Dockerfile"
  tags = ver_tags(BASE, NODE_VERSION, "ssh")
  contexts = {
    "makeomatic/node" = "target:alpine"
  }
}

# vips

target "vips" {
  inherits = ["base"]
  dockerfile = "./node-vips/Dockerfile"
  tags = ver_tags(BASE, NODE_VERSION, "vips")
  contexts = {
    "makeomatic/node" = "target:alpine"
  }
}

target "vips-tester" {
  inherits = ["base"]
  dockerfile = "./node-vips/Dockerfile.tester"
  tags = ver_tags(BASE, NODE_VERSION, "vips-tester")
  contexts = {
    "makeomatic/node" = "target:vips"
  }
}

target "vips-tester-chrome" {
  inherits = ["base"]
  dockerfile = "./node-vips/Dockerfile.tester-chrome"
  tags = ver_tags(BASE, NODE_VERSION, "vips-tester-chrome")
  contexts = {
    "makeomatic/node" = "target:vips"
  }
}

target "vips-tester-docker" {
  inherits = ["base"]
  dockerfile = "./node-vips/Dockerfile.tester-docker"
  tags = ver_tags(BASE, NODE_VERSION, "vips-tester-docker")
  contexts = {
    "makeomatic/node" = "target:vips"
  }
}

# vips-ssh

target "vips-ssh" {
  inherits = ["base"]
  dockerfile = "./node-vips-ssh/Dockerfile"
  tags = ver_tags(BASE, NODE_VERSION, "vips-ssh")
  contexts = {
    "makeomatic/node" = "target:vips"
  }
}