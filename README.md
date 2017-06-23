# Ada Libsecret Library

[![Build Status](https://img.shields.io/jenkins/s/http/jenkins.vacs.fr/Ada-Libsecret.svg)](http://jenkins.vacs.fr/job/Ada-Libsecret/)
[![Test Status](https://img.shields.io/jenkins/t/http/jenkins.vacs.fr/Ada-Libsecret.svg)](http://jenkins.vacs.fr/job/Ada-Libsecret/)
[![Download](https://img.shields.io/badge/download-1.8.0-brightgreen.svg)](http://download.vacs.fr/ada-util/ada-util-1.8.0.tar.gz)
[![License](http://img.shields.io/badge/license-APACHE2-blue.svg)](LICENSE)
![Commits](https://img.shields.io/github/commits-since/stcarrez/ada-util/1.8.0.svg)

The [libsecret](https://wiki.gnome.org/Projects/Libsecret) is a library for storing
and retrieving passwords and others secrets.  The library uses the
[Secret Service API](https://standards.freedesktop.org/secret-service/) provided
by Gnome Keyring or KDE Wallet.  This library provides an Ada binding
to the [Secret Service API](https://standards.freedesktop.org/secret-service/).

# Building

```
./configure
make
```

The unit tests are built and executed with:
```
   make test
```
