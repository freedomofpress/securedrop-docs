Ubuntu 24.04 (Noble) migration
==============================

SecureDrops need to be upgraded to the newer Ubuntu 24.04 (Noble)
operating system. This process is far simpler than past upgrades
as it has been fully automated.

Administrators have two options, on the following timeline:

* **semiautomated, through April 15, 2025:** Administrators can manually trigger the upgrade and observe the process.
* **fully automated, after April 15, 2025:** The SecureDrop team will push updates through mid- to late-April that automatically trigger the upgrade process, in phases, across all SecureDrop instances.

The fully automated upgrade is the simplest option, as it requires no action on your part.

We recommend the semiautomated upgrade for larger instances or if you have a non-standard setup as
the upgrade will happen whenever you choose it, so you will already be available in case something goes
wrong during the process.

Preparation
-----------

Since the end of 2024, all SecureDrops have been checking for any potential issues that need to be resolved
before the upgrade can happen.

If you are receiving notifications about these issues, they must be resolved before the upgrade can take place.

Please see our :doc:`preparation guide <noble_migration_prep>` for more details.


What to know
------------

SecureDrops are currently running the Ubuntu 20.04 (Focal) operating system that
will stop receiving security updates in May 2025. All SecureDrops must be upgraded
by then to ensure you continue receiving security patches.

In the past, Administrators needed to perform a full reinstall of SecureDrop to move over
to the new version; this is no longer necessary. The SecureDrop team has implemented and tested
a method that allows for in-place upgrades in an automated fashion. A backup is automatically taken
before the upgrade begins.

It is our goal that this process requires as little Administrator work as possible.

The upgrade can take up to 30 minutes; your SecureDrop will be inaccessible for that duration. It will
take place shortly after your selected automated restart time, which you can adjust if desired.

If you have any questions, please reach out to Support.

Semiautomated upgrade
----------------------

We recommend setting aside at least an hour for this process.

* Log into your *Admin Workstation* and open a terminal window.
* Run ``cd Persistent/securedrop``.
* Ensure your workstation is on the latest version by running ``./securedrop-admin check_for_updates``.
  If it says "INFO: Update needed", run ``./securedrop-admin update``.
* :doc:`Take a backup <backup_and_restore>` by running ``./securedrop-admin backup``.
* Run ``./securedrop-admin noble_migration``.
* Wait. Every few minutes there may be progress updates, however some of the steps may take
  10-15 minutes to complete.

  * You will likely see messages like ``fatal: [app] UNREACHABLE! ... Data could not be sent to remote host ...``
    followed by the line: ``...ignoring``. These are expected as the servers will reboot multiple times during the upgrade.

The process will upgrade your application server first and then the monitor server.

Once it finishes, you should verify you can submit tips via the Source Interface and can log into the
Journalist Interface and download submissions.

When running the migration script, ``./securedrop-admin noble_migration``, it's important to ensure that it completes successfully.
The final line of the command output should read: ``INFO: Upgrade to Ubuntu Noble complete!``

If it fails, it is safe to run multiple times. If it continues failing, see :ref:`the debugging advice below<debugging>`.

Verifying success
^^^^^^^^^^^^^^^^^

You can verify that the upgrade completed successfully on the *Application Server* by running:

``ssh app cat /etc/securedrop-noble-migration-state.json``

If the output starts with ``{"finished":Done,``, then it was successful. Any value other than ``Done``
means the upgrade hasn't finished or errored out.

Repeat it for the *Monitor Server* too:

``ssh mon cat /etc/securedrop-noble-migration-state.json``

Fully automated upgrade
-----------------------

If you have not performed the semiautomated upgrade by March 21, 2025, the SecureDrop team
will push an update that begins an automated upgrade. This is the same code as the semiautomated
process, just initiated differently.

Servers will be upgraded in batches at a pace set by the SecureDrop team.

Because of some technical limitations, when the upgrade of the *Application Server* takes place, you will
receive a significant amount of OSSEC email alerts because of the changes being made. These are okay
to ignore (if you use the semiautomated upgrade, these alerts are suppressed).

.. _debugging:

Technical details and debugging
-------------------------------

If something goes wrong, logs can be seen by logging into the servers and
running ``sudo journalctl -u securedrop-noble-migration-upgrade``. If the error isn't clear,
:ref:`please contact us<Getting Support>`.

When upgrading the app server, a backup is taken first and stored at ``/var/lib/securedrop-backup``.
If necessary, this backup can be used to do a fresh install.

.. warning:: The backup contains encrypted source communications and should only be stored
   on the app server or an Admin Workstation. It should be deleted once no longer necessary.

If you are further interested in technical details, we `published a blog post <https://securedrop.org/news/technical-details-for-the-noble-migration/>`__ explaining
how the upgrade process works.
