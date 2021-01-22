SecureDrop V3 Onion Services
============================

.. important::

   If you have not enabled v3 onion services before April 30, 2021,
   your SecureDrop servers will become unreachable. To minimize disruption
   to sources and journalists, you should begin the migration well
   before that deadline.

   Your SecureDrop's :ref:`Landing Page <glossary_landing_page>`
   must be updated with your new 56-character onion address so sources
   can continue to reach you.

SecureDrop supports the v3 :ref:`onion services <glossary_onion_service>`
protocol, which provides stronger cryptographic protections than v2 onion
services, and helps mitigate service information leaks on the Tor network.
Because of these important improvements, the Tor project is
`deprecating support for v2 onion services <https://blog.torproject.org/v2-deprecation-timeline>`__,
and SecureDrop is also phasing out support for the v2 protocol.

SecureDrop administrators should enable v3 onion services as soon as possible,
while initially keeping v2 onion services running as well. Then, administrators
should ensure that the new *Source Interface* URL is published on their instance's
:ref:`Landing Page <glossary_landing_page>`, journalists have received new
Tor credentials, and journalists and sources are aware of the change,
before :ref:`disabling v2 onion services <disable_v2>`.

V3 onion addresses are 56 characters long, as in the following example:

.. code-block:: none

  http://sdolvtfhatvsysc6l34d65ymdwxcujausv7k5jk4cy5ttzhjoi6fzvyd.onion/

V2 onion addresses are 16 characters long, as in the following example:

.. code-block:: none

  http://secrdrop5wyphb5x.onion/


How to Migrate from v2 to v3 Onion Services
-------------------------------------------

   #. :ref:`Prepare backups <prepare_backups_v3>`
   #. :ref:`Enable v3 onion services <enable_v3>` alongside v2, to avoid
      disruption to journalists and sources
   #. :ref:`(Optional) Enable HTTPS <enable_https_v3>`
   #. :ref:`Update Tails workstations <update_tails_v3>` with the new v3 onion addresses
   #. :ref:`Publish <publish_v3>` your new *Source Interface* URL
   #. Once you are satisfied with these changes, :ref:`disable v2 onion services<disable_v2>`.

.. note:: If your instance currently uses
          HTTPS with an EV certificate, please contact us via the `SecureDrop
          support portal`_ or use `our GPG key`_ to send an encrypted email to
          securedrop@freedom.press
          before you proceed with the migration.
	  If your certificate provisioning process requires validation of the
          new v3 domain, you may not be able to complete the v3 migration
          process
          without first disabling HTTPS for v2.

.. _SecureDrop Support portal: https://support-docs.securedrop.org/
.. _our GPG key: https://securedrop.org/sites/default/files/fpf-email.asc

.. _prepare_backups_v3:

Prepare backups
^^^^^^^^^^^^^^^

Before proceeding:

- :doc:`Back up the instance <backup_and_restore>`.
- :doc:`Back up the Admin Workstation <backup_workstations>`.

.. _enable_v3:

Enable v3 onion services
^^^^^^^^^^^^^^^^^^^^^^^^

- First, boot into the *Admin Workstation* with the persistent volume unlocked
  and an admin password set.
- Next, open a terminal via **Applications ▸ System Tools ▸ Terminal** and change
  the working directory to the Securedrop application directory:

  .. code:: sh

    cd ~/Persistent/securedrop

- Verify that SecureDrop version |version| is available or installed on
  your instance with the command:

  .. code:: sh

    ssh app apt-cache policy securedrop-app-code

  Version |version| should be listed as installed or as an installation candidate.
- Verify that the *Admin Workstation*'s SecureDrop code is on |version|,
  using the GUI updater or the command:

  .. code:: sh

    ./securedrop-admin update

- After updating to the latest SecureDrop version, use the following command to
  update ``securedrop-admin``'s dependencies:

  .. code:: sh

    ./securedrop-admin setup

- Next, enable v3 onion services using:

  .. code:: sh

    ./securedrop-admin sdconfig

  This command will step through the current instance configuration. None of the
  current settings should be changed. When prompted to enable v2 and v3
  services, you should choose ``yes`` to both.

.. important::

   There is no downgrade path from v3 to v2 using the ``securedrop-admin``
   tool. We strongly recommend enabling v2 + v3 concurrently
   to minimize the impact of the migration on sources and journalists.

- Once the configuration has been updated, run the installation playbook using
  the command:

  .. code:: sh

    ./securedrop-admin install

  This will enable v3 onion services on the *Application* and *Monitor Servers*,
  and may take some time to complete.

- When the installation playbook run is complete, update the *Admin Workstation*
  to use v3 onion services using the command:

  .. code:: sh

    ./securedrop-admin tailsconfig

- Next, verify connectivity between the *Admin Workstation* and the SecureDrop
  instance:

  - Use the Source desktop shortcut to connect to the *Source Interface* and
    verify that the new 56-character address is present in the Tor Browser
    address bar.
  - Use the Journalist desktop shortcut to connect to the *Journalist Interface*
    and verify that the new 56-character address is present in the Tor Browser
    address bar.
  - Use the commands ``ssh app`` and ``ssh mon`` in a terminal to verify
    SSH access to the *Application* and *Monitor Servers*.

- Finally, back up the instance and *Admin Workstation* USB again. Do not
  skip this step.

.. _enable_https_v3:

(Optional) Enable HTTPS
^^^^^^^^^^^^^^^^^^^^^^^

If your instance serves the *Source Interface* over HTTPS, and you plan to
continue using HTTPS with v3 onion services, you'll need to provision a
new certificate for the new v3 address.

You'll find the new *Source Interface* address in the file:

.. code-block:: none

  ~/Persistent/securedrop/install_files/ansible-base/app-sourcev3-ths

Follow the instructions in :doc:`HTTPS on the Source Interface <https_source_interface>`
to provision and install the new certificate.


.. _update_tails_v3:

Update Workstation USBs
^^^^^^^^^^^^^^^^^^^^^^^

If you followed our recommendations, your other *Admin* and
*Journalist Workstations* will still work over the old v2 protocol until that
is disabled. Even so, you should update all workstations to use v3 services as
soon as possible, for security reasons and to avoid future breakage.

Journalist Workstation:
~~~~~~~~~~~~~~~~~~~~~~~

 - In the *Admin Workstation* used to enable v3 onion services, copy the
   following files to an encrypted *Transfer Device*:

   .. code-block:: none

     ~/Persistent/securedrop/install_files/ansible-base/app-sourcev3-ths
     ~/Persistent/securedrop/install_files/ansible-base/app-journalist.auth_private

 - Then, boot into the *Journalist Workstation* to be updated, with the persistent
   volume unlocked and an admin password set.
 - Next, open a terminal via **Applications ▸ System Tools ▸ Terminal** and change
   the working directory to the Securedrop application directory:

   .. code:: sh

     cd ~/Persistent/securedrop


 - Ensure that the SecureDrop application code has been updated to the latest version,
   using either the GUI updater or the ``./securedrop-admin update`` command.

 - Insert the *Transfer Device*.
   Copy the ``app-sourcev3-ths`` and ``app-journalist.auth_private`` files from
   the *Transfer Device* to ``~/Persistent/securedrop/install_files/ansible-base``.

 - Open a terminal and run ``./securedrop-admin tailsconfig`` to update the
   SecureDrop desktop shortcuts.

 - Verify that the new 56-character addresses are in use by visiting the
   *Source* and *Journalist Interfaces* via the SecureDrop desktop shortcuts.

 - Securely wipe the files on the *Transfer Device*, by right-clicking them
   in the file manager and selecting **Wipe**.

Admin Workstation:
~~~~~~~~~~~~~~~~~~

 - In the *Admin Workstation* used to enable v3 onion services, copy the
   following files to an encrypted *Transfer Device*:

   .. code-block:: none

     ~/Persistent/securedrop/install_files/ansible-base/app-sourcev3-ths
     ~/Persistent/securedrop/install_files/ansible-base/app-journalist.auth_private
     ~/Persistent/securedrop/install_files/ansible-base/tor_v3_keys.json
     ~/Persistent/securedrop/install_files/ansible-base/group_vars/all/site-specific

   If your instance uses SSH over Tor, also copy the following files:

   .. code-block:: none

     ~/Persistent/securedrop/install_files/ansible-base/app-ssh.auth_private
     ~/Persistent/securedrop/install_files/ansible-base/mon-ssh.auth_private

 - Then, boot into the *Admin Workstation* to be updated, with the persistent
   volume unlocked and an admin password set.
 - Next, open a terminal via **Applications ▸ System Tools ▸ Terminal** and change
   the working directory to the Securedrop application directory:

   .. code:: sh

     cd ~/Persistent/securedrop

 - Ensure that the SecureDrop application code has been updated to the latest version,
   using either the GUI updater or the ``./securedrop-admin update`` command.

 - Insert the *Transfer Device*.
   Copy the ``app-sourcev3-ths``, ``*.auth_private``, and ``tor_v3_keys.json`` files from
   the *Transfer Device* to ``~/Persistent/securedrop/install_files/ansible-base``.

 - Copy the ``site-specific`` file from the *Transfer Device* to
   ``~/Persistent/securedrop/install_files/ansible-base/group_vars/all``.

 - Open a terminal and run ``./securedrop-admin tailsconfig`` to update the
   SecureDrop desktop shortcuts.

 - Verify that the new 56-character addresses are in use by visiting the *Source*
   and *Journalist Interfaces* via the SecureDrop desktop shortcuts.

 - Verify that ``~/.ssh/config`` contains the new 56-character addresses for the
   ``app`` and ``mon`` host entries, and that the *Application* and *Monitor
   Servers* are accessible via ``ssh app`` and ``ssh mon`` respectively.

 - Securely wipe the files on the *Transfer Device*, by right-clicking them
   in the file manager and selecting **Wipe**.

.. _publish_v3:

Publish your new *Source Interface* URL
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In order for sources to find and use the new v3 *Source Interface*, you'll
need to update your landing page. If your instance details are listed
anywhere else (for example, in the SecureDrop directory), you should update
those listings too.

You'll find the new *Source Interface* address in the file:

.. code-block:: none

  ~/Persistent/securedrop/install_files/ansible-base/app-sourcev3-ths

Please open a ticket with us on the `Support Portal`_ advising us of your
new *Source Interface* address as well, so that our Support team can
continue to provide you with outage alerts.

.. _Support Portal: https://support-docs.securedrop.org/

.. _disable_v2:

Disable v2 onion services
^^^^^^^^^^^^^^^^^^^^^^^^^
Once you've successfully enabled v3 onion services and updated your
workstations, you should disable v2 onion services altogether.

Coordinate with journalists to ensure that any ongoing
source conversations are not interrupted. Journalists
can use SecureDrop's reply feature to give active sources advance notice of
the address change.

When you're ready, follow the steps below to transition to v3 services only:

- First, boot into the *Admin Workstation* with the persistent volume unlocked
  and an admin password set.

- Open a terminal and change the working directory to the SecureDrop application
  directory with the command:

  .. code:: sh

    cd ~/Persistent/securedrop

- Next, update the application configuration using the command:

  .. code:: sh

    ./securedrop-admin sdconfig

  This command will step through the current instance configuration. When prompted,
  you should type ``no`` for v2 services and ``yes`` for v3 services to migrate to
  v3 only. No other settings should be modified.

- Once the configuration has been updated, run the installation playbook using
  the command:

  .. code:: sh

    ./securedrop-admin install

  This will disable v2 onion services on the *Application* and *Monitor Servers*.

- When the installation playbook run is complete, update the *Admin Workstation*
  to use v3 onion services only using the command:

  .. code:: sh

    ./securedrop-admin tailsconfig

- Next, verify connectivity between the *Admin Workstation* and the SecureDrop
  instance, checking the desktop shortcuts and SSH access.

- Then back up the instance and *Admin Workstation* USB.

- Finally, update your other *Admin Workstations*: from a terminal, run:

  .. code:: sh

    ./securedrop-admin sdconfig   # choose "no" for v2, "yes" for v3
    ./securedrop-admin tailsconfig


Human-readable onion URLs
-------------------------

Despite their important security benefits, v3 onion URLs are longer and more
unwieldy. See
`our blog post <https://securedrop.org/news/introducing-onion-names-securedrop/>`_
for information on how to get an onion name (a human-readable alias)
for your new *Source
Interface* URL, with the format ``<yourorganization>.securedrop.tor.onion``.

Onion names are the supported solution for organizations wishing to
customize their *Source Interface* URL, and are recommended over "vanity"
URLs (addresses that start with a few recognizable characters).


Getting Support
---------------

.. include:: includes/getting-support.txt
