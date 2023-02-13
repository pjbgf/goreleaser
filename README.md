# goreleaser

Expands the upstream [goreleaser/goreleaser] image to also include the
[Syft], so that it can be used to auto generate SBOM for releases.

## Development

The make targets are:

* `test` - build the image for all target platforms.
* `build` - builds the image for the current platform and loads it into the
  local docker daemon.
* `push` - build the image for all target platforms and pushes it to the
  container registry.

The image repository and tag can be configured by setting the environment
variables `REPO` and `TAG` respectively:

```sh
make REPO=ghcr.io/<REPOSITORY>/goreleaser TAG=latest push
```

[goreleaser/goreleaser]: https://hub.docker.com/r/goreleaser/goreleaser/
[Syft]: https://github.com/anchore/syft

---
## License

Copyright (c) 2020-2023 [SUSE, LLC](http://suse.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
