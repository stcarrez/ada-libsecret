# Ada Libsecret Library

[![Build Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/ada-libsecret/badges/build.json)](https://porion.vacs.fr/porion/projects/view/ada-libsecret/summary)
[![Test Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/ada-libsecret/badges/tests.json)](https://porion.vacs.fr/porion/projects/view/ada-libsecret/xunits)
[![Coverage](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/ada-libsecret/badges/coverage.json)](https://porion.vacs.fr/porion/projects/view/ada-libsecret/summary)

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

# Building

```
alr with secretada
```

The unit tests are built and executed with:
```
make test
```

And the samples are built using:

```
gprbuild -p -Psamples
```

# Using the library

First, add a with clause for the *secret* GNAT project, in your GNAT project file add this line:

```
with "secret";
```

Then, store a secret with:

```
Service : Secret.Services.Service_Type;
List    : Secret.Attributes.Map;
Value   : Secret.Values.Secret_Type;

   Service.Initialize;
   List.Insert ("secret identification key", "secret identification value");
   Value := Secret.Values.Create ("the-secret-to-store");
   Service.Store (List, "The secret label (for the keyring manager)", Value);
```

And you will retrieve it with:

```
   Value := Service.Lookup (List);
   if not Value.Is_Null then
      Ada.Text_IO.Put_Line (Value.Get_Value);
   end if;
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

# Documentation and References

* [Secret Service API](https://specifications.freedesktop.org/secret-service/index.html)
* [Libsecret Library Reference Manual](https://gnome.pages.gitlab.gnome.org/libsecret/)
* [Ada wrapper for Secret Service](https://github.com/stcarrez/ada-libsecret/wiki/Secret)