# Example overlay descriptions for building customized KIWI descriptions

This contains examples of overlay descriptions compatible with the base image descriptions.

The intent of this is to describe a method in which derivative images could be made by constructing
additional configuration snippets that can be combined with the base ones at image build time to
build customized images in a safe, consistent manner.

## Building a derivative image based on an overlay description

In addition to the standard requirements for building an image with KIWI, one additional tool is required: `xmlmerge`.
This tool comes from the `gwenhywfar-devel` package in Fedora and EPEL for CentOS Stream 9.

Once installed, then use the `kiwi-image-desc-merge` to generate the full derivative description
to build the image.

For example, with the `containerhost` overlay description for CentOS Stream 9 base images:

```shell
$ sudo dnf install kiwi-cli distribution-gpg-keys /usr/bin/xmlmerge
$ ./kiwi-image-desc-merge --image-name=centos9 --image-desc-name=containerhost --output-dir=$PWD/kiwi-desc-build
```

Once the description is built, the image can be built by going into the `kiwi-desc-build` folder and running
the `kiwi-build` tool in the same manner you would for the base images.

For example, to produce a libvirt Vagrant box of the `containerhost` image:

```shell
$ cd kiwi-desc-build
$ sudo ./kiwi-build --image-type=oem --image-profile=Vagrant-libvirt --image-name=centos9 --output-dir=$PWD/tmpoutput
```
