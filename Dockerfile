FROM docker.packages.nuxeo.com/nuxeo/nuxeo:11.x
COPY --chown=900 ./itests/marketplace/target/nuxeo-web-ui-marketplace-itests-3.0.0-SNAPSHOT.zip /tmp/packages/
RUN /install-local-packages.sh /tmp/packages