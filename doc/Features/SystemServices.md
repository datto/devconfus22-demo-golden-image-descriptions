# System Services

There are a number of basic system services configured by default.
The intent here is to provide a minimal set of common services that
consumers can build upon and rely on.

## Logging

System logging is provided exclusively by the systemd journal. The
persistent journal is configured, and no secondary system log service
is provided by default. If logs need to be shipped from an instance
to a centralized service, one will need to install a remote gateway
addon to the journal that matches the service in question.

The primary interfaces to access this are through the [`sd-journal(3)`](https://www.freedesktop.org/software/systemd/man/sd-journal.html) API
and [`journalctl(1)`](https://www.freedesktop.org/software/systemd/man/journalctl.html) commands.

## Networking

Networking is provided by [NetworkManager](https://networkmanager.dev). NetworkManager provides the
most flexibility by supporting cloud networking setup, basic and complex
networking configuration, and provides a stable API for manipulating
configuration programmatically.

There are also a lot of existing modules and mechanisms for automating
NetworkManager configuration through configuration management, if so desired.

The primary interfaces to manipulate this are through [the libnm API](https://networkmanager.dev/docs/libnm/latest/),
the [`nmcli(1)`](https://networkmanager.dev/docs/api/latest/nmcli.html) command, and system connection keyfiles ([`nm-settings-keyfile(5)`](https://networkmanager.dev/docs/api/latest/nm-settings-keyfile.html)).

## Time synchronization

Time synchronization is provided by [Chrony](https://chrony.tuxfamily.org/). Chrony is an
actively maintained, secure NTP client and server implementation. By default, Chrony is
used as an NTP client, but can be easily configured to do more.

The primary interfaces to manipulate this are through the [`chrony.conf(5)`](https://chrony.tuxfamily.org/doc/4.1/chrony.conf.html) configuration
file and [`chronyc(1)`](https://chrony.tuxfamily.org/doc/4.1/chronyc.html).

## Secure Shell (SSH)

Secure Shell service is provided by [OpenSSH](https://www.openssh.com/) and is configured to only offer login
via SSH key authentication using the public+private key pair configured at the time
the machine was provisioned.

The primary configuration interface is through [`ssh_config(5)`](https://www.mankier.com/5/ssh_config) primarily
through `/etc/ssh/ssh_config.d/*.conf` snippets for the client and [`sshd_config(5)`](https://www.mankier.com/5/sshd_config)
primarily through `/etc/ssh/sshd_config.d/*.conf` snippets for the server.
