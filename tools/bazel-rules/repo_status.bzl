
def repo_status(name, srcs = [], **kwargs):

    #ref https://github.com/bazelbuild/bazel/issues/4842
    #this will only rerun (only grab the git version) when the sources change
    native.genrule(
      name = name,
      output_to_bindir = True,
      outs = ["version_file.txt"],
      stamp = True,
      srcs = srcs,
      cmd = "cat bazel-out/volatile-status.txt > $@",
    )
