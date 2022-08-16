# Project Layout

The layout of the base images project is designed to maximize reuse across
common subsets while maintaining distribution and role specific adjustments
factored out to easily add or remove content from the images.

## KIWI build description layout

The layout of the build descriptions start at the `kiwi-desc` directory:

```
kiwi-desc/
├── centos9
│   ├── config.sh
│   ├── config.xml
│   └── platforms -> ../platforms
├── platforms
│   ├── cloud
│   └── vagrant
└── ubuntu2004
    ├── config.sh
    ├── config.xml
    ├── platforms -> ../platforms
    └── root
```

Note that the `platforms` subdirectory is symlinked from the distribution
directories to a common directory above. This is because these aspects tend
to be rather generic and highly reusable across distribution versions.

For example, within the `platforms/cloud` directory, there are "generic" and
distribution-specific XML snippets. These snippets are used together in the
distribution `config.xml` description to populate the profiles. At this time,
there is only a set of profiles for cloud images, but in the future, there
could be bare metal configurations, too.

Finally of note is the `root` directory. In distribution configurations that have
them, this is the top level directory of the filesystem tree overlay that will
be applied to the image rootfs before it runs `config.sh`.
