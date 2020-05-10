#!/bin/sh
echo "@nuxeo:registry=https://packages.nuxeo.com/repository/npm-public" >> ~/.npmrc
npx @nuxeo/nuxeo-web-ui-ftest@3.0.0-SNAPSHOT --url=http://localhost/nuxeo --report --screenshots --headless --tags='not @ignore'
