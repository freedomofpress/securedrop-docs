#############################
SecureDrop for Administrators
#############################

SecureDrop servers are managed by a :ref:`Administrator<glossary_administrator>`.

For larger newsrooms, there may be a team of Administrators, but at least one person within the organization will need to serve as the administrator. In some situations, such as smaller news organizations where a Journalist has the technical capacity to administer systems, one person can serve as both Journalist and administrator. When possible, we advise having a dedicated staff member serving the role of SecureDrop administrator.

The Administrator connects to the Application and Monitor Servers over `authenticated Onion Services <https://tb-manual.torproject.org/onion-services/>`__, and manages them using `Ansible <https://www.ansible.com/>`__.

If you are considering becoming a SecureDrop Administrator, below are some attributes that will be important to have:

* Experience with managing Linux-based systems from the command line.
* Proficiency with network hardware such as firewalls and switches (e.g. pfSense).
* Experience with Qubes OS.
* Experience with configuration management tools such as Ansible, Salt, Chef, or Puppet.
* Ability to use and configure secure communication tools such as GPG.

We consider the first two requirements and the last three preferred attributes.

This Admin Guide covers planning, installation, deployment, and ongoing maintenance of a SecureDrop installation.

.. _Responsibilities:

Responsibilities of SecureDrop Administrators
---------------------------------------------

The SecureDrop architecture contains multiple machines and hardened servers. While many of the installation and maintenance tasks have been automated, a skilled Linux admin is required to responsibly run the system.

As a SecureDrop Administrator, it is your responsibility to:

* :doc:`Install SecureDrop </admin/installation/index>`
* :ref:`Manage users <admin_interface_user_management>`
* :doc:`Manage the system configuration</admin/manual/index>`
* :ref:`Ensure that Servers, firewall and Workstations are kept up-to-date <manage_updates>`
* :doc:`Monitor OSSEC alerts </admin/maintenance/server/ossec_alerts>`
* :ref:`Monitor the SecureDrop team's release and security-related communications <monitoring_comms>`
* :ref:`Spply available firmware updates to all SecureDrop hardware<bios_updates>`
* Ensure that the :ref:`SecureDrop environment is physically secure and monitored<security_requirements>`
* Investigate and respond to security incidents
* Ensure that Journalists adhere to the :doc:`documented processes</journalist/journalist>` for checking SecureDrop, communicating with Sources, and reviewing submitted files
* Securing your own credentials for accessing your Admin Workstation, the Admin Interface, and the SecureDrop Servers
* Encourage users to :ref:`employ best practices<passphrase_best_practices>` for securing their own credentials
* Verify the integrity of SecureDrop code
* Avoid the installation of unsupported code or patches
* :doc:`Decommission SecureDrop after it is no longer in use </admin//maintenance/decommission>`

Responsibilities of the SecureDrop team
---------------------------------------

The SecureDrop team employed by Freedom of the Press Foundation (FPF) and the SecureDrop community maintain and develop the SecureDrop software, which is offered as open source software, free of charge, and at your own risk.

FPF offers :doc:`paid priority support services </introduction/getting_support>`. We are happy to provide assistance with installing the system, with training of Administrators and Journalists, and with investigation of technical issues and incidents.

.. note::

   Each SecureDrop instance is hosted and operated independently. Freedom of the Press Foundation does not offer systems administration, hosting or "remote hands" services.

When the SecureDrop team becomes aware of a security vulnerability in SecureDrop or its software dependencies, we assess the impact of the vulnerability in the context of existing security mitigations and :doc:`our threat model </appendices/threat_model/threat_model>`. Based on this assessment, we prioritize technical work and external communications.

For high severity issues that require technical changes to SecureDrop, we will issue a point release as soon as possible. As part of issuing a release or advisory, we will post further details on the SecureDrop website and to the support portal.

In rare circumstances when a technical fix is extremely time sensitive, we may provide signed patches to impacted SecureDrop instances. Even in these cases, we ask that you never install code provided to you that is not signed using the current `SecureDrop release key <https://securedrop.org/securedrop-release-key.asc>`__.

When in doubt how to resolve an issue, please avoid following technical instructions that have not been vetted by the SecureDrop team. If you encounter bugs, please `report them <https://github.com/freedomofpress/securedrop/issues/new/choose>`__. For sensitive matters, you can contact us via :ref:`Signal<support_via_Signal>` or via our `contact form <https://securedrop.org/help/>`__.

.. _monitoring_comms:

Monitoring SecureDrop-related communications
--------------------------------------------

Release announcements and security advisories are posted to the `SecureDrop blog <https://securedrop.org/news>`__, which is also available as an `RSS feed <https://securedrop.org/news/feed/>`__. You can also follow us on our social media accounts (`Twitter <https://twitter.com/securedrop>`__ and `Mastodon <https://securedrop.org/news/feed/>`__).

We strongly recommend :doc:`joining the SecureDrop support portal </introduction/getting_support>`. As a member of the support portal, you will receive email notifications related to all major announcements, and you can open tickets in case of technical issues. Membership is free of charge.