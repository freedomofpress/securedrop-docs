.. _securedrop-admin utility:

The ``securedrop-admin`` Utility
================================

.. _Using securedrop-admin:

Using ``securedrop-admin``
--------------------------
The ``securedrop-admin`` command-line utility is used from the *Admin Workstation*
to perform common server administration tasks, including:

* configuring and installing SecureDrop
* backing up and restoring the servers (see :doc:`../maintenance/backup_and_restore`)
* retrieving server logs for troubleshooting (see :doc:`../maintenance/logging`)
* updating the SecureDrop code and Tails configuration on the *Admin Workstation*
* updating your SecureDrop servers' configuration post-install.

To use ``securedrop-admin``:

#. Boot the *Admin Workstation* with persistence enabled and an admin password set
#. Open a terminal via **Apps ▸ System Tools ▸ Console**
#. Change directory to the SecureDrop installation directory: ``cd ~/Persistent/securedrop``

You can list all available ``securedrop-admin`` actions using the command
``./securedrop-admin --help``

.. note:: If your team has multiple admins, each with their own *Admin Workstation*, you
  must take steps to manually synchronize any configuration changes made via ``securedrop-admin``
  with each other. See `Managing Configuration Updates with Multiple Admins`_

Updating the Server Configuration
---------------------------------

.. _update-system-configuration:

There are two primary reasons why you may want to update the system configuration:

- to change SecureDrop server configuration options. **Example:** You want to change
  the time of day at which the servers are automatically rebooted (default: 4:00 AM).
- to restore a valid configuration state on your servers. **Example:** Another admin
  has directly modified the iptables rules during troubleshooting, and you want
  to reinstate the correct rules.

In both cases, follow these steps:

#. Boot the *Admin Workstation* and unlock its persistent volume.
#. Open a terminal and type ``cd ~/Persistent/securedrop``.
#. Run ``git status``. If the output includes ``HEAD detached at``
   followed by the version number displayed in the footer of your *Source Interface*,
   you are running the applicable version of the SecureDrop code on your
   workstation, and can proceed to the next step.
   If not, **it is not safe to proceed**. Follow the upgrade instructions
   associated with the `release notes for the most recent release of
   SecureDrop <https://securedrop.org/news/release-announcement/>`__. Apply all
   available updates, including for the Tails operating system.
#. Run ``./securedrop-admin sdconfig``. This will display the current
   configuration, one line at a time, and allow you to change it. At this point,
   any changes you make are only saved on this *Admin Workstation*, to the
   following file:

   ``~/Persistent/securedrop/install_files/ansible-base/group_vars/all/site-specific``
#. Run ``./securedrop-admin install``. This will apply the configuration to your
   *Application* and *Monitor Server*, and enforce the canonical state of the
   server configuration.

.. include:: ../../includes/rerun-install-is-safe.txt


Updating Localization for the *Source Interface* and the *Journalist Interface*
-------------------------------------------------------------------------------

The *Source Interface* and *Journalist Interface* are translated in the following
languages:

https://github.com/freedomofpress/securedrop/blob/develop/securedrop/i18n.rst

At any time during and after initial setup, you can choose from a list of
supported languages to display using the codes shown in parentheses.

.. note:: With a *Source Interface* displayed in French (for example), sources
          submitting documents are likely to expect a journalist fluent in
          French to be available to read the documents and follow up in that
          language.

To add or remove locales from your instance, you'll need to :ref:`update your
system configuration <update-system-configuration>` as outlined above.

When you reach the prompt starting with "Space separated list of additional
locales to support", you will see a list of languages currently supported.
Refer to the list above to see which languages correspond to which language
codes. For example: ::

    Space separated list of additional locales to support (ru nl pt_BR fr_FR tr it_IT zh_Hant sv hi ar en_US de_DE es_ES nb_NO): nl fr_FR es_ES

You'll need to list all languages you now want to support, adding or removing
languages as needed. Locale changes will be applied after the next reboot.

.. _multiple_admins:

Managing Configuration Updates with Multiple Admins
---------------------------------------------------

Organizations with multiple admins should set up a way to synchronize
any changes one admin makes to the server configuration, as by default those
changes are stored only on their individual *Admin Workstation*.

Configuration changes will be flagged by OSSEC and will generate alerts, but
if other admins don't regularly review OSSEC alerts they may miss important
changes, such as an update to the *Submission Public Key*. If they subsequently
run ``./securedrop-admin install`` from their *Admin Workstation*, they will
revert the server configuration to an older version.

The simplest approach to keeping workstations in sync is to inform other admins
of changes as you make them, for example via a secure Signal group chat. Any such
communications should happen over a platform that provides E2EE, as you may need to
share sensitive information.

Configuration information is stored in several files on the *Admin Workstation* under
``~/Persistent/securedrop/``:

* ``install_files/ansible-base/group_vars/all/site-specific`` contains settings written by
  ``./securedrop-admin sdconfig`` - if it is changed other admins should be notified.
* The *Submission Public Key* and *OSSEC Alert Public Key* should be present
  under ``install_files/ansible-base``. If these keys are rotated, the public keys
  should be updated on other *Admin Workstations*.
* Onion service information is stored in several files:

    .. code-block:: none

      install_files/ansible-base/app-ssh.auth_private
      install_files/ansible-base/mon-ssh.auth_private
      install_files/ansible-base/app-journalist.auth_private
      install_files/ansible-base/app-sourcev3-ths
      install_files/ansible-base/tor_v3_keys.json

  If onion service addresses are changed, the files listed above should be shared
  securely with other administrators - preferably in person using an encrypted transfer USB,
  as they can be used to access the servers directly via SSH over Tor.