#!/bin/bash
# basic build script example
set -e -o pipefail
if [ "${OS}" == "ubuntu1404" ]; then
    # Find the files
    DEBS=$(find . -type f -iname '*.deb')
    for i in $DEBS
    do
        push_deb "$i"
    done

    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
    export JAVAC=${JAVA_HOME}/bin/javac
    export PATH=${JAVA_HOME}/bin/:${PATH}
    cd nsh-plugin/build/java/jvpp
    $MVN deploy \
        -gs "$GLOBAL_SETTINGS_FILE" -s "$SETTINGS_FILE"
    cd -

elif [ "${OS}" == "ubuntu1604" ]; then

    # Find the files
    DEBS=$(find . -type f -iname '*.deb')
    for i in $DEBS
    do
        push_deb "$i"
    done

elif [ "${OS}" == "centos7" ]; then
    # Find the files
    RPMS=$(find . -type f -iname '*.rpm')
    SRPMS=$(find . -type f -iname '*.srpm')
    SRCRPMS=$(find . -type f -name '*.src.rpm')
    for i in $RPMS $SRPMS $SRCRPMS
    do
        push_rpm "$i"
    done
fi