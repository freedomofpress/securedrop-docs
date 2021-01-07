SecureDrop V3 Onion Services
============================
Tor onion services provide anonymous inbound connections to websites and other
servers exclusively over the Tor network. SecureDrop uses onion services 
for the *Journalist* and *Source Interface* websites, as well as for 
adminstrative access to the servers in SSH-over-Tor mode. 

Currently, SecureDrop supports two versions of the onion services
protocol: the older version (v2), and the current version (v3), which provides 
stronger cryptography and includes redesigned protocols that guard against 
service information leaks on the Tor network. Because of these important 
improvements, the Tor project is
`deprecating support for v2 onion services <https://blog.torproject.org/v2-deprecation-timeline>`__. 

SecureDrop will begin phasing out support for v2 onion services in 
**February 2021**. All newsrooms should enable v3 onion services as soon as
possible, but may continue using v2 concurrently to allow all journalists and 
sources to transition smoothly.

.. warning::

   If you are still using 16-character v2 onion URLs in April 2021, your SecureDrop 
   servers will become unreachable, and you will have to reinstall SecureDrop 
   from scratch.

How to distinguish between v2 and v3 onion services
---------------------------------------------------

If your *Source Interface* address is 56 characters long, you are already using v3 onion services, as in the following example:

.. code-block:: none

  http://sdolvtfhatvsysc6l34d65ymdwxcujausv7k5jk4cy5ttzhjoi6fzvyd.onion/

If your *Source Interface* address is 16-characters long, you are still using 
v2 onion services, and need to transition to v3 in order to keep using 
SecureDrop, as in the following example:

.. code-block:: none

  http://secrdrop5wyphb5x.onion/

What an upgrade entails
-----------------------

Enabling v3 onion services will have the following effects:

- You will get a new, 56-character *Source Interface* onion address.
  If you follow our recommended steps, this will work alongside your existing
  v2 address. When you're ready to announce the change, you will need to update 
  your landing page and other resources that reference your *Source Interface* 
  address, such as your SecureDrop directory entry.
- *Journalist* and *Admin Workstations* will need to be updated by your 
  administrator so that they contain the new onion service addresses and
  credentials.
- If your instance uses HTTPS, you will need to provision a new certificate for
  the v3 *Source Interface* address - this will need to be done `after` the new
  address has been generated.

.. note:: If your instance currently uses
          HTTPS with an EV certificate, please contact us via the `SecureDrop
          support portal`_ or use `our GPG key`_ to send an encrypted email to 
          securedrop@freedom.press
          before you proceed with the migration. 
	  If your certificate provisioning process requires validation of the
          new v3 domain, you may not be able to complete the v3 migration 
          process
          without first disabling HTTPS for v2. 

.. _SecureDrop Support Portal: https://support-docs.securedrop.org/
.. _our GPG key: https://securedrop.org/sites/default/files/fpf-email.asc


How to upgrade
--------------

   #. :ref:`Prepare backups <prepare_backups_v3>`
   #. :ref:`Enable v3 onion services <enable_v3>` alongside v2, to avoid 
      disruption to journalists and sources 
   #. :ref:`(Optional) Enable HTTPS <enable_https_v3>`
   #. :ref:`Update Tails workstations <update_tails_v3>` with the new v3 onion addresses
   #. :ref:`Publish <publish_v3>` your new *Source Interface* URL      
   #. Once you are satisfied with these changes, :ref:`disable v2 onion services<disable_v2>`. 

Enabling v3 onion services is fairly quick (under an hour), though 
the initial backup and the followup steps will take longer. If you have 
questions about the upgrade process after reading these instructions, please 
contact Support.

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
  services, you should choose either ``yes`` to both to enable v2 and v3
  concurrently (recommended), or ``no`` to v2 and ``yes`` to v3 to migrate to 
  v3 only.

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
  instance as follows:

  - Use the Source desktop shortcut to connect to the *Source Interface* and
    verify that the new 56-character address is present in the Tor Browser
    address bar.
  - Use the Journalist desktop shortcut to connect to the *Journalist Interface*
    and verify that the new 56-character address is present in the Tor Browser
    address bar.
  - Use the commands ``ssh app`` and ``ssh mon`` in a terminal to verify
    SSH access to the *Application* and *Monitor Servers*.

- Finally, back up the instance and *Admin Workstation* USB.

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
