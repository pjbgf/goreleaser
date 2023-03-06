# goreleaser

Expands the upstream [goreleaser/goreleaser] image to also include 
[Syft], so that it can be used to auto generate SBOM for releases.

## Development

The make targets are:

* `test` - test building container image to all target platforms.
* `build` - builds the image for the current platform and loads it into the
  local docker daemon.
* `push` - build the image for all target platforms and pushes it to the
  container registry. By default, the image will include a layer with SBOM
  and attestation information.

The image repository and tag can be configured by setting the environment
variables `REPO` and `TAG` respectively:

```sh
make REPO=ghcr.io/<REPOSITORY>/goreleaser TAG=latest push
```

[goreleaser/goreleaser]: https://hub.docker.com/r/goreleaser/goreleaser/
[Syft]: https://github.com/anchore/syft

## Release

The release process is automated using [GoReleaser]. The configuration is
located in the [.goreleaser.yml](.goreleaser.yml) file.

To release a new version, simply create a new tag and push it to the
repository. The release process will be triggered automatically.

The release process will:
- Build the image for all target platforms.
- Generate a manifest image which includes all target platforms.
- Push the image to the container registry.
  - The image will contain a layer with [build attestation] information.
- Create a new release on GitHub with:
    - Checksums for source tarball and SBOM.
    - Cosign's signature.
    - Cosign's ephemeral certificate.
    - Tarball of the source code.
    - SBOM file in SPDX format for the source code.
    - SBOM file in SPDX format for all layers of the container image.

[GoReleaser]: https://goreleaser.com/
[build attestation]: https://docs.docker.com/build/attestations/

## Extracting SBOM/Attestation information from image

- Extract SBOM from the image:
```sh
docker buildx imagetools inspect <repository>/<image>:<tag> --format "{{ json .SBOM }}"
```

- Extract Attestation from the image:
```sh
docker buildx imagetools inspect <repository>/<image>:<tag> --format "{{ json .Provenance }}"
```

## Outstanding

- The container image is currently not being signed when using Drone.
