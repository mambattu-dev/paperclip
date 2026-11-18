# The upstream image bakes /app for uid 1000; we run as srv (997:984) so data
# under ./paperclip/data stays host-readable. Embedded Postgres writes library
# aliases next to its binaries at startup, so hand just those dirs over.
# ponytail: narrow chown; rebuild upstream with --build-arg USER_UID=997 USER_GID=984
# instead if more /app writes turn up.
ARG BASE
FROM ${BASE}
USER root
RUN chown -R 997:984 /app/node_modules/.pnpm/@embedded-postgres+linux-x64@*/node_modules/@embedded-postgres/linux-x64/native
