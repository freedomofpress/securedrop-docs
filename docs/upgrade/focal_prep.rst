Ubuntu 20.04 LTS (Focal) migration - Preparatory steps
======================================================
On April 30, 2021, Ubuntu 16.04 LTS (Xenial) will reach End of Life. After this
date, no new security updates to the base operating system will be provided.
It is therefore of critical importance for the security of all SecureDrop
instances to upgrade to Ubuntu 20.04 LTS (Focal) before **April 30**.

.. important::

   For security reasons, the *Source Interface* will automatically be
   disabled on SecureDrop servers running Ubuntu 16.04 after April 30, 2021.

Support for Ubuntu 20.04 LTS (which will receive security updates until
April 30, 2025) will be included in SecureDrop 1.8.0, scheduled to
be released on March 2, 2021. Please do **not** attempt to upgrade to Ubuntu 20.04
before then. The migration to Ubuntu 20.04 will require a reinstall from a
backup.

We recommend that you plan a two day maintenance window
**between March 9 and April 30** to back up your instance, perform the migration,
and test your instance once it is migrated.

.. note::

   If you are running hardware that is not currently listed in our
   :ref:`hardware recommendations <Specific Hardware Recommendations>`, we
   recommend that you also plan a hardware refresh as part of this migration.
   This has the following benefits:

   - It ensures that all system components will continue to receive security
     updates.
   - It reduces the risk of hardware compatibility issues with future
     releases of SecureDrop.
   - It will allow you to keep your current installation online during much of
     the two-day maintenance window.

If you have a support agreement with Freedom of the Press Foundation,
please coordinate your maintenance window with us, so we can ensure that our team
can provide support in a timely manner. In any event, please do not hesitate to
:ref:`contact us <contact_us>` for assistance.

Before the two-day maintenance window, we recommend completing the preparatory
steps below.

Preparation Procedure
---------------------
To prepare for the upgrade:

#. :ref:`Check your SecureDrop version (servers) <check_server_versions>`
#. :ref:`Check your SecureDrop version (workstations) <check_workstation_versions>`
#. :ref:`Verify SSH access <verify_ssh_access>`
#. :ref:`Back up your Application Server <back_up_app>`
#. :ref:`Migrate to v3 onion services (if applicable) <migrate_to_v3>`

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
8. Repeat this process for all *Admin Workstations* and *Journalist Workstations*.

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

.. _migrate_to_v3:

Migrate to v3 onion services
----------------------------
If you are still running v2 :ref:`onion services <glossary_onion_service>`,  you
must migrate to v3 to keep your instance running. Because this is a complex
configuration change in its own right, we strongly recommend completing it well
before the Ubuntu 20.04 migration. See our :doc:`v3 upgrade guide <../v3_services>`
for details.

.. _back_up_app:

Back up your *Application Server*
---------------------------------
1. (Recommended) In coordination with your journalist team, delete any
   previously-downloaded submissions and sources via the *Journalist Interface*.

   .. note::

      Deleting old submissions is a good security practice. It also helps to
      control the size of backups, which are transferred to the *Admin Workstation*
      over the Tor network.

2. Run the following commands in a terminal on your *Admin Workstation*:

  .. code:: sh

    cd ~/Persistent/securedrop
    ./securedrop-admin backup

  Once the command is completed, you will find the backup files in the
  ``~/Persistent/securedrop/install_files/ansible-base`` directory.

3. (Recommended) Copy the backup files to an encrypted volume on a separate
   USB stick.

For more information on the backup process, see :doc:`Backup, Restore, Migrate<../backup_and_restore>`.

.. _contact_us:

Contact us
----------

If you have questions or comments regarding the coming upgrade to Ubuntu 20.04 LTS
or the preparatory procedure outlined above, please don't hesitate to reach out:

 - via our `Support Portal <https://support.freedom.press>`_, if you are a member (membership is approved on a case-by-case basis);
 - via securedrop@freedom.press (`GPG public key <https://media.securedrop.org/media/documents/fpf-email.asc>`_) for sensitive security issues (please use judiciously);
 - via our `community forums <https://forum.securedrop.org>`_.
