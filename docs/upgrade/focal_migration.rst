Ubuntu 20.04 LTS (Focal) Migration Guide
========================================

On April 30, 2021, Ubuntu 16.04 LTS (Xenial), the operating system for the
SecureDrop servers, will reach End of Life. In order to continue using SecureDrop, 
instances must migrate to Ubuntu 20.04 LTS (Focal) **before** April 30, 2021.

This migration will require on-premises access to the servers, and a complete
reinstallation of Ubuntu and SecureDrop. In-place upgrades and 
remote upgrades via SSH are not currently supported.

.. important::

   For security reasons, the *Source Interface* will automatically be
   disabled on SecureDrop servers still running Ubuntu 16.04 after 
   April 30, 2021.

We recommend that you plan a two day maintenance window
**between March 9 and April 30** to perform and test the migration.

At a high level, the migration process consists of:

- Taking a backup of the current instance
- Installing Ubuntu 20.04 LTS and SecureDrop from scratch
- Applying the backup

Instances that already have :doc:`v3 onion services <v3_services>` enabled 
and follow our migration guide will be able to 
preserve their existing *Source* and *Journalist Interface* onion URLs.

.. note::
   Coordinate with journalists and sources during this migration. Your
   instance will be offline while you perform these steps.

   Coordinate with the team maintaining your Landing Page. You may wish to
   publish a notice about a planned maintenance window. Depending on
   :ref:`your migration scenario <choose_migration_path>`, you may also
   need to coordinate the publication of your new *Source Interface* onion 
   URL so that sources can reach you.


Preparation
~~~~~~~~~~~
Before migrating, complete the following steps:

#. :ref:`Consider a hardware upgrade <consider_hardware_upgrade>`
#. :ref:`Choose your migration path <choose_migration_path>` and plan your
   maintenance window
#. :ref:`Check your SecureDrop version (servers) <check_server_versions>`
#. :ref:`Check your SecureDrop version (workstations) <check_workstation_versions>`
#. :ref:`Verify SSH access <verify_ssh_access>`


.. _consider_hardware_upgrade:

Consider a hardware upgrade
---------------------------

If you are running hardware that is not currently listed in our
:ref:`hardware recommendations <Specific Hardware Recommendations>`, we
recommend that you also plan a hardware refresh as part of this migration,
particularly if your hardware is reaching end-of-life.
This has the following benefits:

   - It ensures that all system components will continue to receive security
     updates.
   - It reduces the risk of hardware compatibility issues with future
     releases of SecureDrop.
   - It will allow you to keep your current installation online during much of
     the two-day maintenance window.
   - If your hardware is due for replacement anyway, combining the OS upgrade 
     and the hardware upgrade will save you time. 

If you have a support agreement with Freedom of the Press Foundation,
please coordinate your maintenance window with us, so we can ensure that our team
can provide support in a timely manner. In any event, please do not hesitate to
:ref:`contact us <contact_us>` for assistance.


.. _check_server_versions:

Check your SecureDrop version (servers)
---------------------------------------
To check your SecureDrop server version, load the .onion address of your
*Source Interface* in Tor Browser. The version number will be in the footer.
It should currently be |version|.

If you have :ref:`SSH access <verify_ssh_access>` to the servers, you can also
check the application version from your *Admin Workstation* by running
this command in a terminal:

.. code:: sh

 ssh app apt-cache policy securedrop-app-code

SecureDrop servers are updated automatically with the latest release version.
If your servers are running an old version, this indicates a major configuration
problem, and you may need to reinstall SecureDrop. In that case, please
:ref:`contact us <contact_us>` for assistance.

.. _check_workstation_versions:

Check your SecureDrop version (workstations)
--------------------------------------------
1. (Recommended) Back up your *Admin Workstation* using the process described here:
   :doc:`Back up the Workstations <../backup_workstations>`.
2. Boot your *Admin Workstation* and wait for the Tails welcome screen to appear.
3. Unlock the persistent volume and configure an administrator password, then
   start Tails.
4. Connect to the Internet and follow all graphical prompts to complete pending
   updates.
5. Compare the version shown on the About screen (**Applications ▸ Tails ▸ About Tails**)
   with the version indicated on the `Tails website <https://tails.boum.org/index.en.html>`_.
   If the installed Tail version is outdated, follow our :doc:`guide to updating Tails USBs <../update_tails_usbs>`.
6. Run the command ``git status`` in the ``~/Persistent/securedrop`` directory.
   The output should include the following text:

   .. code-block:: none

      HEAD detached at <version>

   where ``<version>`` is  the version of the workstation code that is installed.
   If the *Admin Workstation* is at |version|, it is up-to-date.
7. If your SecureDrop code is outdated, follow our :doc:`upgrade guide <1.6.0_to_1.7.0>`
   to perform a manual update. If that fails, please :ref:`contact us <contact_us>`
   for assistance.
8. (Recommended) Repeat this process for all *Admin Workstations* and *Journalist
   Workstations*.

.. note::

   If your *Admin Workstation* is in an unrecoverable state, you can
   follow our instructions to :doc:`rebuild an Admin Workstation <../rebuild_admin>`.

.. _verify_ssh_access:

Verify SSH access
------------------
Start up your *Admin Workstation* (with persistent storage unlocked) and run the
following commands in a terminal:

.. code:: sh

  ssh app hostname     # command output should be 'app'
  ssh mon hostname     # command output should be 'mon'

If you are having trouble accessing the servers via SSH, try the following:

- create a new Tor network circuit by disconnecting and reconnecting your
  Internet link, and repeat the check
- run the ``./securedrop-admin tailsconfig`` command and repeat the check
- verify that the *Source* and *Journalist Interfaces* are available via their
  desktop shortcuts
- verify that the *Application* and *Monitor Servers* are up
- :ref:`contact us <contact_us>` for assistance.

.. _choose_migration_path:

Choose Migration Path
---------------------

If your instance is already using v3 onion services, choose our
:ref:`Standard Migration <migration_standard>` procedure.

Instances that have not yet enabled v3 
:ref:`onion services <glossary_onion_service>` and are nearing the
April migration deadline have two options: 

- :doc:`Upgrade to v3 onion services <../v3_services>` before performing 
  the standard migration, or 
- Take a backup of the current system, perform a fresh installation 
  (which will be created with v3 onion services), and follow a 
  modified restore path to restore only source and journalist 
  data (:ref:`Alternate Migration <migration_alternate>` procedure).

The second option is simpler, but potentially more disruptive to sources
and journalists, since you will be abruptly switching from one set of
onion URLs to another.


Migration
~~~~~~~~~

.. _migration_standard:

Standard Migration Procedure
----------------------------
(For SecureDrop instances already using v3 onion services)

#. :doc:`Take a backup of the current instance <../backup_and_restore>`.
   Before doing so, in coordination with your journalist team, delete 
   old submissions and sources via the *Journalist Interface*.
   Deleting old submissions is a good security practice, and helps to
   control the size and improve the speed of backups.
#. Follow our guide for downloading and verifying the 
   :ref:`Ubuntu 20.04 LTS (Focal) <servers>` installation media.       
#. Follow the instructions on 
   hardware migration for instances using v3 Onion Services. 
   This document will guide you through
   performing a clean installation of Ubuntu on your servers, 
   a clean installation of SecureDrop, and finally, 
   a restoration of your backup file onto the new installation, 
   restoring your previous Tor and ssh credentials.

   While you may not be performing a true hardware migration (i.e.,
   you may be reusing existing hardware), in this case the steps
   are equivalent.  

.. _migration_alternate:

Alternate Migration Procedure  
-----------------------------
(For SecureDrop instances not yet using v3 onion services)

#. :doc:`Take a backup of the current instance <../backup_and_restore>`. 
   Before doing so, in coordination with your journalist team, delete old 
   submissions and sources via the *Journalist Interface*.
   deleting old submissions is a good security practice, and helps to
   control the size and improve the speed of backups.
   over the Tor network.
#. :doc:`Install Ubuntu 20.04 (Focal Fossa) <../servers>` on the servers.
#. :doc:`Install SecureDrop from scratch <../install>`. 
#. Follow the guidelines to 
   restore data without restoring Tor configuration.
#. :ref:`Publish your new Source Interface URL  
   <../v3_services#publish-your-new-source-interface-url>` on your Landing Page
#. :ref:`Update Journalist Workstation USBs <../v3_services#update-tails-v3>` 
   with new Tor credentials


.. _contact_us:

Contact us
----------

If you have questions or comments regarding the coming upgrade to Ubuntu 20.04 LTS
or the preparatory procedure outlined above, please don't hesitate to reach out:

 - via our `Support Portal <https://support.freedom.press>`_, if you are a member (membership is approved on a case-by-case basis);
 - via securedrop@freedom.press (`GPG public key <https://media.securedrop.org/media/documents/fpf-email.asc>`_) for sensitive security issues (please use judiciously);
 - via our `community forums <https://forum.securedrop.org>`_.
