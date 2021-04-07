Ubuntu 20.04 LTS (Focal) Migration Guide
========================================

On April 30, 2021, Ubuntu 16.04 LTS (Xenial), the operating system for the
SecureDrop servers, will reach End of Life. In order to continue using SecureDrop,
instances must migrate to Ubuntu 20.04 LTS (Focal) **before** April 30, 2021.

.. important::

   For security reasons, the *Source Interface* will be automatically
   disabled on SecureDrop servers still running Ubuntu 16.04 after
   April 30, 2021.

This migration will require on-premises access to the servers, and a complete
reinstallation of Ubuntu and SecureDrop. In-place upgrades and
remote upgrades via SSH are not currently supported. We recommend that you
plan a two day maintenance window to perform and test the migration.

At a high level, the migration process consists of:

- Taking a backup of the current instance
- Installing Ubuntu 20.04 LTS and SecureDrop from scratch
- Applying the backup

Instances that already have :doc:`v3 onion services <../v3_services>` enabled
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

.. _focal_prep:

Preparation
~~~~~~~~~~~
Before migrating, complete the following steps:

#. :ref:`Consider a hardware upgrade <consider_hardware_upgrade>`
#. :ref:`Choose your migration path <choose_migration_path>` and plan your
   maintenance window
#. Coordinate with journalists to
   :ref:`delete old submissions from the server <prune_submissions>`
#. :ref:`Check your SecureDrop version (servers) <check_server_versions>`
#. :ref:`Check your SecureDrop version (workstations) <check_workstation_versions>`
#. :ref:`Verify SSH access <verify_ssh_access>`
#. :ref:`Download and verify the
   Ubuntu 20.04 LTS (Focal) installation media <download_focal>`


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
   If the installed Tails version is outdated, follow our
   :doc:`guide to updating Tails USBs <../update_tails_usbs>`.

   .. important::
      If your version of Tails is 4.14 or older, you will need to follow
      `these steps <https://tails.boum.org/news/version_4.15/index.en.html#issues>`__ 
      to correct an issue with automatic updates.

6. Run the command ``git status`` in the ``~/Persistent/securedrop`` directory.
   The output should include the following text:

   .. code-block:: none

      HEAD detached at <version>

   where ``<version>`` is  the version of the workstation code that is installed.
   If the *Admin Workstation* is at |version|, it is up-to-date.
7. If your SecureDrop code is outdated, follow the latest release guide
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
:ref:`Standard Migration Procedure <migration_standard>`.

Instances that have not yet enabled v3
:ref:`onion services <glossary_onion_service>` should choose the
:ref:`Alternate Migration Procedure <migration_alternate>`.


.. _prune_submissions:

Delete Old Submissions from the Server
--------------------------------------

In coordination with journalists, ensure that any old or unneeded
submissions have been deleted from the server. Pruning old submissions
will reduce the size and improve the speed of your server backup.
Journalists can delete unneeded submissions via the *Journalist Interface.*


.. _download_focal:

Download and Verify Ubuntu 20.04 LTS (Focal) Installation Media
----------------------------------------------------------------

Follow our instructions to
:ref:`download and verify Ubuntu Server 20.04 LTS <download_ubuntu>` and
install the .iso file onto a USB stick.

You have now completed all the preparatory steps. The rest of the
migration procedure will be completed during your maintenance window.

Migration
~~~~~~~~~

.. _migration_standard:

Standard Migration Procedure
----------------------------
Perform these steps if your instance is already using v3 onion services. Ensure
you have completed the :ref:`preparatory steps <focal_prep>`.

#. Ensure that your Landing Page
   :ref:`shows your v3 Source Interface URL <publish_v3>`.
   For instances using v2+v3 onion services concurrently, any v2 onion
   services will be removed as part of this migration.
#. Announce your maintenance window. As part of this procedure, your servers
   will become unreachable.
#. :doc:`Take a backup of the current instance <../backup_and_restore>`.

   Once you have taken a backup of the servers, power them off.

   .. warning::

      The next steps will overwrite existing data on the servers.

      Data from the *Monitor Server* will not be restored after the backup.
      If you require historical data from the *Monitor Server*, archive it
      separately before proceeding.

   .. note::

      If you are reusing the same hardware (servers), your old data will
      be overwritten by the new operating system installation, but traces
      of this data may still be recoverable.

      In most cases, this is not a concern, since you will be restoring data
      from your backup file as part of the migration process. However, if this
      is a concern, refer to our
      :doc:`decommissioning documentation <../decommission>`
      for instructions on securely erasing and destroying server data.

#. Follow the instructions on
   :ref:`hardware migration for instances using v2+v3 or v3 onion services <migrate_v3>`.
   As part of this process, you will be instructed to
   reinstall your servers, restore your backup, and configure access
   via your *Admin Workstation*.
#. Ensure that all *Journalist* and *Admin Workstations* can
   access the *Source* and *Journalist Interfaces*.
   By this point, for instances that were running v2+v3 onion services
   concurrently, all v2 onion services will have been disabled.
   If you have not yet updated the onion service
   configurations for all *Journalist* and *Admin Workstations*,
   you must :ref:`do so now <update_tails_v3>`.

   .. note::

      If you cannot update your Journalists' Tails USBs in person due
      to remote work policies,
      contact Support for suggestions on how to safely complete this step.

#. (Optional): If you'd like your instance to be listed in our SecureDrop
   directory, ensure your Landing Page meets our
   :doc:`security guidelines <../deployment/landing_page>`, and then
   submit a `directory listing request <https://securedrop.org/directory/submit>`_.

   Instances listed in the directory can receive an
   `onion name <https://securedrop.org/news/introducing-onion-names-securedrop>`__, an
   easy-to-type alias for their *Source Interface* in the form
   ``yourinstance.securedrop.tor.onion``.

.. _migration_alternate:

Alternate Migration Procedure
-----------------------------
Perform these steps if your SecureDrop instance is not yet using v3 onion services.
Ensure you have completed the :ref:`preparatory steps <focal_prep>`.

#. Announce your maintenance window. As part of this procedure, your servers
   will become unreachable.
#. :doc:`Take a backup of the current instance <../backup_and_restore>`.
   Once you have taken a backup of the servers, power them off.

   .. warning::

      The next steps will overwrite existing data on the servers.

      Data from the *Monitor Server* will not be restored after the backup.
      If you require historical data from the *Monitor Server*, archive it
      separately before proceeding.

   .. note::

      If you are reusing the same hardware (servers), your old data will
      be overwritten by the new operating system installation, but traces
      of this data may still be recoverable.

      In most cases, this is not a concern, since you will be restoring data
      from your backup file as part of the migration process. However, if this
      is a concern, refer to our
      :doc:`decommissioning documentation <../decommission>`
      for instructions on securely erasing and destroying server data.

#. Follow our documentation on
   :ref:`hardware migration using a v2-only backup <migrate_v2>`.

   As part of this process, you will be instructed to
   reinstall your servers, generating new v3 onion URLs, and restore
   source and journalist data from your backup.
#. :ref:`Publish your new Source Interface URL <publish_v3>` on your
   Landing Page. This is the new, 56-character .onion address at which
   sources will now reach you.
#. You will then need to
   :ref:`update Journalist and Admin Workstation USBs <update_tails_v3>`
   so that Journalists and other Admins can access your instance.
#. (Optional): If you'd like your instance to be listed in our SecureDrop
   directory, ensure your Landing Page meets our
   :doc:`security guidelines <../deployment/landing_page>`, and then
   submit a `directory listing request <https://securedrop.org/directory/submit>`_.

   Instances listed in the directory can receive an
   `onion name <https://securedrop.org/news/introducing-onion-names-securedrop/>`__, an
   easy-to-type alias for their *Source Interface* in the form
   ``yourinstance.securedrop.tor.onion``.


.. _contact_us:

Contact us
----------

If you have questions or comments regarding the pgrade to Ubuntu 20.04 LTS
or the preparatory procedure outlined above, please don't hesitate to reach out:

 - via our `Support Portal <https://support.freedom.press>`_, if you are a member (membership is approved on a case-by-case basis);
 - via securedrop@freedom.press (`GPG public key <https://media.securedrop.org/media/documents/fpf-email.asc>`_) for sensitive security issues (please use judiciously);
 - via our `community forums <https://forum.securedrop.org>`_.
