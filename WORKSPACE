# The WORKSPACE file tells Bazel that this directory is a "workspace", which is like a project root.
# The content of this file specifies all the external dependencies Bazel needs to perform a build.

####################################
# ESModule imports (and TypeScript imports) can be absolute starting with the workspace name.
# The name of the workspace should match the npm package where we publish, so that these
# imports also make sense when referencing the published package.
workspace(name = "fabians_workplace")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

RULES_NODEJS_VERSION="0.16.2"
NODEJS_VERSION="10.13.0"
YARN_VERSION="1.12.1"
ANGULAR_VERSION="7.1.0"

# git commit on https://github.com/Toxicable/rules-ts-dont-use-this of the corresponding rules_typescript release
# with our modification to tsconfig to make all ts compiles use `target = "esnext"`
# 46c72600975a9254e7ea721e016ea7ef3795ce85 = 0.10.1
# 567a58fb23c3006a7ec2ab6486097d8d2b5db284 = 0.15.3
# c2664442c8c84ab159b3909edb629f2cabffc9b6 = 0.17.0
# 632d4e0c1e360b9d2ac4cb746a72e037583f29c6 = 0.21.0
# e1332c8a23c286ccc9de844b77c2a5ad350a0cbd = 0.22.0

# RULES_TS_VERSION="0.21.0"
RULES_TS_FORK_HASH="632d4e0c1e360b9d2ac4cb746a72e037583f29c6"

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.5.0",  # change this to use a different release
)

####################################
# The Bazel buildtools repo contains tools like the BUILD file formatter, buildifier
http_archive(
    name = "com_github_bazelbuild_buildtools",
    # Note, this commit matches the version of buildifier in angular/ngcontainer
    url = "https://github.com/bazelbuild/buildtools/archive/b3b620e8bcff18ed3378cd3f35ebeb7016d71f71.zip",
    strip_prefix = "buildtools-b3b620e8bcff18ed3378cd3f35ebeb7016d71f71",
    sha256 = "dad19224258ed67cbdbae9b7befb785c3b966e5a33b04b3ce58ddb7824b97d73",
)


####################################
# Fetch and install the NodeJS rules
http_archive(
    name = "build_bazel_rules_nodejs",
    url = "https://github.com/bazelbuild/rules_nodejs/archive/" + RULES_NODEJS_VERSION + ".zip",
    strip_prefix = "rules_nodejs-" + RULES_NODEJS_VERSION,
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories", "yarn_install")

node_repositories(
  preserve_symlinks = False,
  node_version = NODEJS_VERSION,
  yarn_version = YARN_VERSION,
  node_repositories = {
    NODEJS_VERSION + "-darwin_amd64": ("node-v" + NODEJS_VERSION + "-darwin-x64.tar.gz", "node-v" + NODEJS_VERSION + "-darwin-x64", "815a5d18516934a3963ace9f0574f7d41f0c0ce9186a19be3d89e039e57598c5"),
    NODEJS_VERSION + "-linux_amd64": ("node-v" + NODEJS_VERSION + "-linux-x64.tar.xz", "node-v" + NODEJS_VERSION + "-linux-x64", "0dc6dba645550b66f8f00541a428c29da7c3cde32fb7eda2eb626a9db3bbf08d"),
  },
  yarn_repositories = {
    YARN_VERSION: ("yarn-v" + YARN_VERSION + ".tar.gz", "yarn-v" + YARN_VERSION, "09bea8f4ec41e9079fa03093d3b2db7ac5c5331852236d63815f8df42b3ba88d"),
  },
  node_urls = ["https://nodejs.org/dist/v{version}/{filename}"],
  yarn_urls = ["https://github.com/yarnpkg/yarn/releases/download/v{version}/{filename}"],
  package_json = ["//:package.json"]
)

yarn_install(
  name = "npm",
  package_json = "//:package.json",
  yarn_lock = "//:yarn.lock",
  data = ["//:postinstall.sh"]
)

####################################
# Fetch and install the Sass rules
git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    tag = "1.15.1",
)

# Some of the TypeScript is written in Go.
# Bazel doesn't support transitive WORKSPACE deps, so we must repeat them here.
http_archive(
    name = "io_bazel_rules_go",
    url = "https://github.com/bazelbuild/rules_go/releases/download/0.11.0/rules_go-0.11.0.tar.gz",
    sha256 = "f70c35a8c779bb92f7521ecb5a1c6604e9c3edd431e50b6376d7497abc8ad3c1",
)

# Used by the ts_web_test_suite rule to provision browsers
http_archive(
    name = "io_bazel_rules_webtesting",
    url = "https://github.com/bazelbuild/rules_webtesting/archive/v0.2.0.zip",
    strip_prefix = "rules_webtesting-0.2.0",
    sha256 = "cecc12f07e95740750a40d38e8b14b76fefa1551bef9332cb432d564d693723c",
)

####################################
# Fetch and install the TypeScript rules
# http_archive(
#     name = "build_bazel_rules_typescript",
#     url = "https://github.com/bazelbuild/rules_typescript/archive/" + RULES_TS_VERSION + ".zip",
#     strip_prefix = "rules_typescript-" + RULES_TS_VERSION,
# )
# use our hosted version
http_archive(
    name = "build_bazel_rules_typescript",
    strip_prefix = "rules-ts-dont-use-this-" + RULES_TS_FORK_HASH,
    urls = ["https://github.com/Toxicable/rules-ts-dont-use-this/archive/" + RULES_TS_FORK_HASH + ".tar.gz"],
)

# The @angular repo contains rule for building Angular applications
http_archive(
    name = "angular",
    url = "https://github.com/angular/angular/archive/" + ANGULAR_VERSION + ".zip",
    strip_prefix = "angular-" + ANGULAR_VERSION,
)

local_repository(
    name = "rxjs",
    path = "node_modules/rxjs/src",
)

####################################
# Fetch and install the Python rules
git_repository(
    name = "io_bazel_rules_python",
    remote = "https://github.com/bazelbuild/rules_python.git",
    commit = "8b5d0683a7d878b28fffe464779c8a53659fc645",
)

# Fetch required transitive dependencies. This is an optional step because you
# can always fetch the required NodeJS transitive dependency on your own.
load("@io_bazel_rules_sass//:package.bzl", "rules_sass_dependencies")
rules_sass_dependencies()

# Setup repositories which are needed for the Sass rules.
load("@io_bazel_rules_sass//:defs.bzl", "sass_repositories")
sass_repositories()


load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")
go_rules_dependencies()
go_register_toolchains()


load("@io_bazel_rules_webtesting//web:repositories.bzl", "browser_repositories", "web_test_repositories")
web_test_repositories()
browser_repositories(
    chromium = True,
    firefox = True,
)

load("@build_bazel_rules_typescript//:defs.bzl", "ts_setup_workspace")
ts_setup_workspace()

load("@angular//packages/bazel:package.bzl", "rules_angular_dependencies")
rules_angular_dependencies()

http_archive(
    name = "io_bazel_rules_docker",
    strip_prefix = "rules_docker-0.4.0",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/v0.4.0.tar.gz"],
)
load("@io_bazel_rules_docker//nodejs:image.bzl", _nodejs_image_repos = "repositories")

_nodejs_image_repos()
load("@io_bazel_rules_docker//container:container.bzl", "container_pull")
