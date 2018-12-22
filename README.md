Example of source maps bring broken when changing from 0.21.0 -> 0.22.0

1. Open this repo in VSC
2. enabled auto attach (ctrl + p -> search "auto attach" -> enter)
3. `yarn && yarn go`
4. It'll crash the first time due to another issue with yarn_install (using yarn_install inside a sub process)
5. exit it with `ctrl + c` and run again VSC will auto attach and you'll be placed in a file with a path like: `/home/f.wiles/.cache/bazel/_bazel_f.wiles/80a5e956c9d02d1550a20ced5bc75f3d/execroot/soa/apps/`
6. Now bump to 0.22.0 in the WORKSPACE file by changing to the corresponding hash and repeat