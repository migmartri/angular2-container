FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

RUN bitnami-pkg install node-6.5.0-0 --checksum 52cb7f26dff5661fadb0d3ca50ff4e267b746604a935b3299c3a9383104d0055

ENV PATH=/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH \
    NODE_PATH=/opt/bitnami/node/lib/node_modules

RUN npm install -g angular-cli@1.0.0-beta.14

COPY rootfs /

USER bitnami

RUN cd ~ && ng new sample --style=scss && \
  tar czf sample.tar.gz sample && \
  sudo rm -rf /tmp/npm* sample

WORKDIR /app
EXPOSE 4200 49152

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["ng", "serve", "-h", "0.0.0.0"]
