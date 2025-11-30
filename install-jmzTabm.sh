#!/bin/bash

VERSION="1.0.6"
CLI_URL="https://repo1.maven.org/maven2/de/isas/mztab/jmztabm-cli/${VERSION}/jmztabm-cli-${VERSION}.jar"
wget -q "${CLI_URL}" -O jmztabm-cli-${VERSION}.jar
mv jmztabm-cli-${VERSION}.jar jmztabm-cli.jar
