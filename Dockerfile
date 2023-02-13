ARG GORELEASER_VERSION=v1.15.1

# https://github.com/goreleaser/goreleaser/blob/main/Dockerfile
FROM goreleaser/goreleaser:${GORELEASER_VERSION}

ARG SYFT_VERSION=v0.71.0

# The script version, and target download are pinned to the same version.
# Note that the script does checksum verification of the downloaded binary.
RUN curl -sSfL "https://raw.githubusercontent.com/anchore/syft/${SYFT_VERSION}/install.sh" | sh -s -- -b /usr/local/bin "${SYFT_VERSION}"
