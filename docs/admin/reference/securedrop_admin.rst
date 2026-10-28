.. _securedrop-admin utility:

The ``securedrop-admin`` Utility
================================

.. _Using securedrop-admin:

Using ``securedrop-admin``
--------------------------

The ``securedrop-admin`` command-line utility is used on an :ref:`Admin Workstation<glossary_admin_workstation>` to perform common server administration tasks, including:

* configuring and installing SecureDrop
* backing up and restoring the Servers (see :doc:`/admin/maintenance/server_maintenance/backup_servers`)
* retrieving server logs for troubleshooting (see :doc:`/admin/maintenance/server_maintenance/server_logs`)
* updating your SecureDrop Servers' configuration post-install.

You can list all available ``securedrop-admin`` actions using the command ``securedrop-admin --help``

.. note:: If your team has multiple Administrators, each with their own Admin Workstation, you must take steps to manually synchronize any configuration changes made via ``securedrop-admin`` with each other. See `Managing Configuration Updates with Multiple Administrators`_

Updating the server configuration
---------------------------------

.. _update-system-configuration:

There are two primary reasons why you may want to update the system configuration:

- to change SecureDrop server configuration options. **Example:** You want to change the time of day at which the servers are automatically rebooted (default: 4:00 AM).
- to restore a valid configuration state on your servers. **Example:** Another admin has directly modified the iptables rules during troubleshooting, and you want to reinstate the correct rules.

In both cases, follow these steps:

#.  Determine the current version of ``securedrop-admin`` you have installed. On your Admin Workstation, run:

    .. code:: sh

      apt-cache policy securedrop-admin

    If the version is the same as the version number displayed in the footer of your Source Interface, you are running the applicable version of the SecureDrop Workstation code, and can proceed to the next step. 

    If the versions differ, **it is not safe to proceed**. Follow the upgrade instructions associated with the `release notes for the most recent release of SecureDrop <https://securedrop.org/news/release-announcement/>`__.

#. Run ``securedrop-admin sdconfig``. This will display the current configuration, one line at a time, and allow you to change it. At this point, any changes you make are only saved on this Admin Workstation, to the following file:

   ``~/.config/securedrop-admin/site-specific``

#. Run ``securedrop-admin install``. This will apply the configuration to your Application and Monitor Server, and enforce the canonical state of the server configuration.

.. include:: ../../includes/rerun-install-is-safe.txt

Onion Services files
~~~~~~~~~~~~~~~~~~~~

Following the initial run of ``securedrop-admin install`` during installation of the SecureDrop Servers, addresses and credentials for each Onion Service hosted on your Application Server are stored in the following files under ``~/.config/securedrop-admin``:

- ``app-sourcev3-ths`` contains the onion address of the Source Interface.
- ``app-journalist.auth_private`` contains the onion address and private key providing access to the Admin Interface.
- ``app-ssh.auth_private`` contains the onion address and private key providing SSH access to the Application Server.
- ``mon-ssh.auth_private`` contains the onion address and private key providing SSH access to the Monitor Server.
- ``tor_v3_keys.json`` contains the keypairs required for access to the Admin Interface and SSH access to the servers - it is required for future runs of ``securedrop-admin install``.

.. warning:: The three ``.auth_private`` files and the ``tor_v3_keys.json`` file contain secret keys that should not be shared with third parties, or copied from the Admin Workstation for any purpose other than tasks such as performing backups or onboarding new users.

The dynamic inventory file automatically reads the onion addresses from the ``app-ssh.auth_private`` and ``mon-ssh.auth_private`` files and use them to connect to the servers over SSH when ``securedrop-admin`` is run. 

For manual SSH access when :ref:`SSH-over-Tor is enabled<ssh_over_tor>`, ``securedrop-admin localconfig`` configures the SSH shortcuts ``app`` and ``mon`` in ``sd-admin``'s ``~/.ssh/config`` file with the Onion Service addresses and keys.

Updating localization for the Source Interface and the Admin Interface
-------------------------------------------------------------------------------

The Source Interface and Admin Interface are translated in the following languages:

https://github.com/freedomofpress/securedrop/blob/develop/securedrop/i18n.rst

At any time during and after initial setup, you can choose from a list of supported languages to display using the codes shown in parentheses.

.. note:: With a Source Interface displayed in French (for example), Sources are likely to expect a Journalist fluent in French to be available to read their messages and submissions and follow up in that language.

To add or remove locales from your instance, you'll need to :ref:`update your system configuration <update-system-configuration>` as outlined above.

When you reach the prompt starting with "Space separated list of additional locales to support", you will see a list of languages currently supported. Refer to the list above to see which languages correspond to which language codes. For example:

.. code-block:: text
   :class: no-copybutton

   Space separated list of additional locales to support (ru nl pt_BR fr_FR tr it_IT zh_Hant sv hi ar en_US de_DE es_ES nb_NO): nl fr_FR es_ES

You'll need to list all languages you now want to support, adding or removing languages as needed. Locale changes will be applied after the next reboot.

.. _multiple_admins:

Managing configuration updates with multiple Administrators
-----------------------------------------------------------

Organizations with multiple Administrators should set up a way to synchronize any changes one Administrator makes to the server configuration, as by default those changes are stored only on their individual Admin Workstation.

Configuration changes will be flagged by OSSEC and will generate alerts, but if other Administrators don't regularly review OSSEC alerts they may miss important changes, such as an update to the Submission Public Key. If they subsequently run ``securedrop-admin install`` from their Admin Workstation, they will revert the server configuration to an older version.

The simplest approach to keeping workstations in sync is to inform other Administrators of changes as you make them, for example via a secure Signal group chat. Any such communications should happen over a platform that provides E2EE, as you may need to share sensitive information.

Configuration information is stored on the Admin Workstation under ``~/.config/securedrop-admin``:

- ``~/.config/securedrop-admin/site-specific`` contains settings written by ``securedrop-admin sdconfig`` - if it is changed other Administrators should be notified.
- The Submission Public Key and OSSEC Alert Public Key should be present under ``~/.config/securedrop-admin``. If these keys are rotated, the public keys should be updated on other Admin Workstations.
- Onion Service information is stored in several files: ::

    ~/.config/securedrop-admin/app-ssh.auth_private
    ~/.config/securedrop-admin/mon-ssh.auth_private
    ~/.config/securedrop-admin/app-journalist.auth_private
    ~/.config/securedrop-admin/app-sourcev3-ths
    ~/.config/securedrop-admin/tor_v3_keys.json

- If Onion Service addresses are changed, the files listed above should be shared securely with other Administrators - preferably in person using an encrypted USB flash drive, as they can be used to access the servers directly via SSH over Tor.
