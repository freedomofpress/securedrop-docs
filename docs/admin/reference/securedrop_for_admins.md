# SecureDrop for Administrators

SecureDrop servers are managed by a [Administrator](#glossary_administrator).

For larger newsrooms, there may be a team of Administrators, but at least one person within the organization will need to serve as the administrator. In some situations, such as smaller news organizations where a Journalist has the technical capacity to administer systems, one person can serve as both Journalist and administrator. When possible, we advise having a dedicated staff member serving the role of SecureDrop administrator.

The Administratopr connects to the Application and Monitor Servers over [authenticated Onion Services](https://tb-manual.torproject.org/onion-services/), and manages them using [Ansible](https://www.ansible.com/).

If you are considering becoming a SecureDrop Administrator, below are some attributes that will be important to have:

- Experience with managing Linux-based systems from the command line.
- Proficiency with network hardware such as firewalls and switches (e.g. pfSense).
- Experience with Qubes OS.
- Experience with configuration management tools such as Ansible, Salt, Chef, or Puppet.
- Ability to use and configure secure communication tools such as GPG.

We consider the first two requirements and the last three preferred attributes.

This Admin Guide covers planning, installation, deployment, and ongoing maintenance of a SecureDrop installation.

(responsibilities)=

## Responsibilities of SecureDrop Administrators

The SecureDrop architecture contains multiple machines and hardened servers. While many of the installation and maintenance tasks have been automated, a skilled Linux admin is required to responsibly run the system.

As a SecureDrop Administrator, it is your responsibility to:

- [install SecureDrop](/admin/installation/installation_overview.md)
- [manage users](#manage_users)
- [manage the system configuration](#manage_config)
- [ensure that servers, firewall and workstations are kept up-to-date](#manage_updates)
- [monitor OSSEC alerts](#monitoring_ossec)
- [monitor the SecureDrop team's release and security-related communications](#monitoring_comms)
- apply available firmware updates to all SecureDrop hardware
- ensure that the SecureDrop environment is physically secure and monitored
- ensure that SecureDrop Workstations are kept up to date
- investigate and respond to security incidents
- schedule and perform required maintenance tasks, such as operating system upgrades
- ensure that Journalists adhere to the documented processes for checking SecureDrop, communicating with Sources, and reviewing submitted files
- verify the integrity of SecureDrop code
- avoid the installation of unsupported code or patches
- [decommission SecureDrop after it is no longer in use](/admin//maintenance/decommission.md)

## Responsibilities of the SecureDrop team

The SecureDrop team employed by Freedom of the Press Foundation (FPF) and the SecureDrop community maintain and develop the SecureDrop software, which is offered as open source software, free of charge, and at your own risk.

FPF offers [paid priority support services](/introduction/getting_support.md). We are happy to provide assistance with installing the system, with training of Administrators and Journalists, and with investigation of technical issues and incidents.

:::{note}
Each SecureDrop instance is hosted and operated independently. Freedom of the Press Foundation does not offer systems administration, hosting or "remote hands" services.
:::

When the SecureDrop team becomes aware of a security vulnerability in SecureDrop or its software dependencies, we assess the impact of the vulnerability in the context of existing security mitigations and [our threat model](/appendices/threat_model/threat_model.md). Based on this assessment, we prioritize technical work and external communications.

For high severity issues that require technical changes to SecureDrop, we will issue a point release as soon as possible. As part of issuing a release or advisory, we will post further details on the SecureDrop website and to the support portal.

In rare circumstances when a technical fix is extremely time sensitive, we may provide signed patches to impacted SecureDrop instances. Even in these cases, we ask that you never install code provided to you that is not signed using the current [SecureDrop release key](https://securedrop.org/securedrop-release-key.asc).

When in doubt how to resolve an issue, please avoid following technical instructions that have not been vetted by the SecureDrop team. If you encounter bugs, please [report them](https://github.com/freedomofpress/securedrop/issues/new/choose). For sensitive matters, you can contact us via the [SecureDrop Support Portal] or via our [contact form](https://securedrop.org/help/).

(manage_users)=

## Managing users

Adminstrators are responsible for managing user credentials and encouraging best practices. (See [Passphrase Best Practices](#passphrase_best_practices).) The Administrator will also have access to the Admin Interface, via her own username, passphrase, and two-factor authentication method (using a smartphone application or YubiKey).

See [User Management](#user-management) for more information on adding and managing users.

(manage_config)=

## Managing the system configuration

Administrators are responsible for configuring and maintaining the system. Several tools are available to support this:

- [The Admin Interface](#the-admin-interface) allows the Administrator to manage users and configure web interface features such as organizations logos and submission preferences
- [Server SSH access](#server-ssh-access) is also available, to allow Administrators to troubleshoot server issues and perform manual updates.
- [The securedrop-admin utility](#securedrop-admin-utility) is used via the `sd-admin` qube. to configure and install SecureDrop, to perform operations including server backups and restores, and to update the server configuration after installation.

(manage_updates)=

## Keeping the system updated

The Administrator is responsible for ensuring that updates are applied to SecureDrop. Where possible, updates are applied automatically, but some update operations require manual intervention.

### Updates: servers

The Administrator should be aware of all SecureDrop updates and take any required manual action if requested in the [SecureDrop Release Blog] ([RSS feed]). We also recommend registering with the [SecureDrop Support Portal] to stay apprised of upcoming releases.

Most often, the SecureDrop servers will automatically update via `apt`. However, occasionally you will need to take other manual steps. If you are in touch with us directly for [support](/introduction/getting_support.md), we will let you know in advance of major releases if manual intervention will be required.

### Updates: network firewall

Given all traffic first hits the network firewall as it faces the non-Tor public network, the Administrator should ensure that critical security patches are applied to the firewall.

Because of recent changes to the frequency and scope of security updates, we do not recommend the use of pfSense Community Edition (CE). pfSense Plus continues to receive necessary security updates on a regular basis, and is provided with the purchase of most Netgate firewalls. If you wish to use a custom firewall or alternate option, we recommend using an OPNSense-based solution.

If you're using one of the network firewalls recommended by FPF, you can subscribe to email updates from the [Netgate homepage] or follow the [Netgate blog] to be alerted when releases occur. If critical security updates need to be applied, you can do so through the firewall's pfSense WebGUI.

Refer to our [](#keeping-pfsense-up-to-date) documentation or the official [pfSense Upgrade Docs] for further details on how to update the suggested firewall.

No matter which vendor you go with, you should make it a priority to stay informed of potential updates to your network firewall.

### Updates: workstations

SecureDrop Workstation includes an updater application that runs automatically on startup, checks for Qubes and SecureDrop updates, and prompts the user to apply them if found. Given the sensitive nature of the system, it is critical that updates are applied when available. Administrators should ensure that users are aware of this requirement, and should periodically check to ensure that the system is up to date.

(monitoring_ossec)=

## Monitoring OSSEC alerts

SecureDrop uses OSSEC to monitor the servers for unusual activity caused by system configuration issues or security breaches. The Administrator should decrypt and read all OSSEC alerts. Report any suspicious events to FPF through the [SecureDrop Support Portal]. See the [OSSEC Guide](/admin/reference/ossec_alerts.md) for more information on common OSSEC alerts.

:::{warning}
Do not post logs or alerts to public forums without first carefully examining and redacting any sensitive information.
:::

(the-admin-interface)=

(monitoring_comms)=

## Monitoring SecureDrop-related communications

Release announcements and security advisories are posted to the [SecureDrop blog](https://securedrop.org/news), which is also available as an [RSS feed](https://securedrop.org/news/feed/). You can also follow us on our social media accounts ([Twitter](https://twitter.com/securedrop) and [Mastodon](https://securedrop.org/news/feed/)).

We strongly recommend [joining the SecureDrop support portal](/introduction/getting_support.md). As a member of the support portal, you will receive email notifications related to all major announcements, and you can open tickets in case of technical issues. Membership is free of charge.

[netgate blog]: https://www.netgate.com/blog/
[netgate homepage]: https://www.netgate.com/
[ossec]: https://www.ossec.net/
[pfsense upgrade docs]: https://docs.netgate.com/pfsense/en/latest/install/upgrade-guide.html
[rss feed]: https://securedrop.org/news/feed
[securedrop release blog]: https://securedrop.org/news
[securedrop support portal]: https://support-docs.securedrop.org/
