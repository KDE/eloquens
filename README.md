<!--
    SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
    SPDX-License-Identifier: CC0-1.0
-->

# Eloquens

Generate the lorem ipsum text

![eloquens window](https://cdn.kde.org/screenshots/eloquens/eloquens.png)

## Build Flatpak

To build a flatpak bundle of Eloquens use the following instructions:

```bash
$ git clone https://invent.kde.org/sdk/eloquens.git
$ cd eloquens
$ flatpak-builder --repo=repo build-dir --force-clean org.kde.eloquens.json
$ flatpak build-bundle repo eloquens.flatpak org.kde.eloquens
```

Now you can either double-click the `eloquens.flatpak` file to open it with
some app store (discover, gnome-software, etc...) or run:

```bash
$ flatpak install eloquens.flatpak
```
