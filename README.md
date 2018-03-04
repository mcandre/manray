# manray: RBAC persistence for SmartOS global zones

# EXAMPLE

```console
$ svcadm disable -s manray-persist

$ passwd
New password: vagrant
Re-enter new password: vagrant

$ svcadm enable -s manray-persist
```

# ABOUT

manray enables modifiable, persistent UNIX user accounts and RBAC configuration for SmartOS global zones, by providing a pair of boot time services: `manray-load` and `manray-persist`, that assist administrators in loading and persisting custom account information.

At boot, `manray-load` copies select configuration files from a `/usbkey` wallet to `/etc`, so that a user `patrick` may login, invoke RBAC privileges with `pfexec`, and so on. Once the `manray-load` service launches, `manray-persist` becomes enabled.

While `manray-persist` is enabled, Patrick sees a read-only edition of `/etc` files. Administrators can disable `manray-persist`, which triggers writeable copies to be injected onto the system. Then, administrators can execute `passwd`, `usermod`, `groupadd`, and so on to modify UNIX user account and RBAC configuration. Finally, the administrator re-renables `manray-persist`, which backs up the configuration to `/usbkey`.

Warning: Changes to UNIX accounts and RBAC configuration will be lost at next boot unless `manray-persist` is re-enabled beforehand.

![Manray hands Patrick his Wallet](https://raw.githubusercontent.com/mcandre/manray/master/manray.png)

# INSTALL

```console
$ curl -kLO https://github.com/mcandre/manray/releases/download/v0.0.1/manray-0.0.1.tgz
$ tar xzvf manray-0.0.1.tgz -C /
$ svccfg import /opt/custom/smf/manray-load.xml
$ svccfg import /opt/custom/smf/manray-persist.xml
```

Warning: As SSL certificates are disregarded, the tarball should be verified against official release checksums with the `digest` utility.

# RUNTIME REQUIREMENTS

* SmartOS global zone

# BUILDTIME REQUIREMENTS

* make, e.g. [GNU make](https://www.gnu.org/software/make/)
* tar, md5sum from coreutils, e.g., [GNU coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* a build environment that preserves UNIX file permissions
* [shfmt](https://github.com/mvdan/sh) (e.g. `go get mvdan.cc/sh/cmd/shfmt`)
* [bashate](https://pypi.python.org/pypi/bashate/0.5.1)
* [shlint](https://rubygems.org/gems/shlint)
* [checkbashisms](https://sourceforge.net/projects/checkbaskisms/)
* [ShellCheck](https://hackage.haskell.org/package/ShellCheck)
* [stank](https://github.com/mcandre/stank) (e.g. `go get github.com/mcandre/stank/...`)

# CREDITS

* [vagrant-smartos-packager](https://github.com/vagrant-smartos/vagrant-smartos-packager) - provides a working example of how to setup a virtual machine for SmartOS global zones with persistent, modifiable UNIX accounts
