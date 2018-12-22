load("@io_bazel_rules_docker//nodejs:image.bzl", "nodejs_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_push", "container_image")

def docker_image(name, entry_point, data, repository, ports = ["80"], **kwargs):
    container_name = name + ".container"


    nodejs_image(
        name = name,
        entry_point = entry_point,
        node_modules = "//:empty_node_modules",
        data = data,
        **kwargs
    )

    container_image(
        name = container_name,
        base =  name,
        ports = ports,
    )

    container_push(
        name = name + ".push",
        image = container_name,
        format = "Docker",
        registry = "",
        repository = repository,
        stamp = True,
        tag = "{BUILD_SCM_VERSION}",
    )

    container_push(
        name = name + ".latest.push",
        image = container_name,
        format = "Docker",
        registry = "",
        repository = repository,
        stamp = True,
        tag = "latest",
    )
