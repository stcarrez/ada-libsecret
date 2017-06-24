# Ada Libsecret Library

[![Build Status](https://img.shields.io/jenkins/s/http/jenkins.vacs.fr/Ada-Libsecret.svg)](http://jenkins.vacs.fr/job/Ada-Libsecret/)
[![Test Status](https://img.shields.io/jenkins/t/http/jenkins.vacs.fr/Ada-Libsecret.svg)](http://jenkins.vacs.fr/job/Ada-Libsecret/)
[![License](http://img.shields.io/badge/license-APACHE2-blue.svg)](LICENSE)
![Commits](https://img.shields.io/github/commits-since/stcarrez/ada-libsecret/0.0.0.svg)

The [libsecret](https://wiki.gnome.org/Projects/Libsecret) is a library for storing
and retrieving passwords and others secrets.  The library uses the
[Secret Service API](https://standards.freedesktop.org/secret-service/) provided
by Gnome Keyring or KDE Wallet.  This library provides an Ada binding
to the [Secret Service API](https://standards.freedesktop.org/secret-service/).

# Pre-Requisites

On Ubuntu, you may have to install the following packages:

```
sudo apt-get install libsecret-1-dev libglib2.0-dev
```

You will also need the Ada compiler and the following libraries:

* Ada Util     (https://github.com/stcarrez/ada-util          1.9.0)

# Building

```
./configure
make
```

The unit tests are built and executed with:
```
   make test
```

And the samples are built using:

```
   gprbuild -p -Psamples
```

# Running the samples

The samples provide a simple *secret-tool* program that allows to create,
retrieve or delete a secret from the secret service API.
You can add a secret using:

```
   bin/secret-tool set my-secret
```

and retrieve it later with:

```
   bin/secret-tool get
```


