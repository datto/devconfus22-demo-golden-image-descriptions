# Building Images

This repository contains descriptions for building platform base images with the [KIWI image builder](https://osinside.github.io/kiwi).

To build these images, you need the following:

* A system running CentOS Stream 9 or Fedora Linux 34 or higher
* KIWI version 9.24.44 or higher (provided as `kiwi-cli`)
* GnuPG 2 (provided as `gnupg2`)
* Required GPG public keys (provided in `distribution-gpg-keys` and `ubu-keyring` packages)

If you're running CentOS Stream 9, you will need to [install the Fedora EPEL repository](https://docs.fedoraproject.org/en-US/epel/#_el9).

Then, install KIWI and the required system dependencies:

```bash
$ sudo dnf install kiwi-cli kiwi-systemdeps-disk-images gnupg2 distribution-gpg-keys ubu-keyring
```

After that, make sure you're in the root directory of the Git checkout and run the image build:

```bash
$ sudo ./kiwi-build --image-type=<TYPE> --image-profile=<PROFILE> --image-name=<DISTRO> --output-dir $PWD/tmpoutput
```

The resulting image will be in `./tmpoutput`.
