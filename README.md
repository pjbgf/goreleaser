# goreleaser

Expands the upstream [goreleaser/goreleaser] image to also include the
[Syft], so that it can be used to auto generate SBOM for releases.

## Development

The make targets are:

* `test` - test building container image to all target platforms.
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

## Release

The release process is automated using [GoReleaser]. The configuration is
located in the `.goreleaser.yml` file.

To release a new version, simply create a new tag and push it to the
repository. The release process will be triggered automatically.

The release process will:
- Build the image for all target platforms.
- Generate a manifest image including all target platforms.
- Sign the manifest image using cosign.
- Push the image to the container registry.
- Create a new release on GitHub with:
    - Checksums for source tarball and SBOM.
    - Cosign signature.
    - Cosign ephemeral certificate.
    - Tarball of the source code.
    - SBOM file in SPDX format.

[GoReleaser]: https://goreleaser.com/
