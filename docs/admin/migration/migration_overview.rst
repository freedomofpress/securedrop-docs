Migration overview
==================

.. _migration_overview:

The previous version of SecureDrop was based three "workstations": 

- The Journalist Workstation, where Journalists downloaded new submissions or replied to Sources.
- The Secure Viewing Station (or SVS), where journalists decrypted and viewed submissions.
- The Admin Workstation, used by Administrators to administer the SecureDrop servers. 

Each of these workstations was actually an individual USB flash drive with the `Tails <https://tails.net>`__ operating system installed, used to boot a laptop for each role (in the case of the SVS, this was always a physically air-gapped laptop).

Development on the successor to this Tails-based version of SecureDrop, dubbed *SecureDrop Workstation*, began in 2017. This new version of SecureDrop sought to replace a handful of Tails USB drives and air-gapped laptops with a single Workstation based on `Qubes OS <https://qubes-os.org>`__. In the `pilot <https://securedrop.org/news/piloting-securedrop-workstation-qubes-os/>`__ and `open beta <https://securedrop.org/news/securedrop-workstation-1_0_0-released/>`__, a Tails-based Admin Workstation was still needed for administration tasks. 

.. TODO link to SDW 2.0.0 blogpost

As of late 2026, administrative tasks can be performed on a Qubes-based Admin Workstation. SecureDrop has transitioned completely to Qubes-based Workstations instead of the previous Tails-based USB flash drives.

.. TODO link to Tails docs. 

The Tails-based components are no longer needed, and the Tails version of SecureDrop will be completely depreciated by the end of 2027. 

This guide will help you migrate your Tails-based Admin and Journalist Workstations to the new Qubes-based Workstations.

Hardware overview
---------------------

Workstations
^^^^^^^^^^^^

.. include:: /admin/installation/installation_overview.rst
    :start-after: .. _install_overview_workstations:
    :end-before: .. _install_overview_servers:

Hardware requirements for new SecureDrop Workstations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Qubes OS has different hardware requirements compared to Tails. You may have to procure new Qubes-compatible laptops that meet SecureDrop's requirements in lieu of re-using the laptops you have been using with Tails. 

.. include:: /admin/installation/hardware.rst
    :start-after: .. _hardware_workstations_overview:
    :end-before: .. _hardware_workstations_overview_end:

Printers
^^^^^^^^

SecureDrop now supports printing directly from the workstation where Source messages and files are decrypted and viewed.

.. include:: /admin/installation/hardware.rst
    :start-after: .. _hardware_printers_overview:
    :end-before: .. _hardware_printers_overview_end:

Other hardware
^^^^^^^^^^^^^^

There is no need to upgrade or reinstall the SecureDrop Application and Monitor servers. Likewise for the Network Firewall. The software, configuration, and hardware requirements for these devices are unchanged.

However, if you have been using SecureDrop for awhile, you may take this opportunity to audit your current server and firewall hardware, and replace it if it has reached end-of-life. See our complete hardware recommendations list for :ref:`servers <hardware_recommendations_servers>` and :ref:`firewalls <hardware_recommendations_firewall>`.

Migration scenarios
-------------------

- If you are starting with only the Tail-based workstations:
    1. :doc:`Install Qubes OS and SecureDrop Workstation packages</admin/migration/migrate_install_qubes>` on the desired number of laptops
        - One laptop to create a combined Admin + Journalist Workstation
        - Two laptops to create separate Admin and Journalist Workstations

    2. Perform :doc:`Admin migration</admin/migration/admin_migration>` to create new Admin Workstation
    3. Perform :doc:`Journalist migration</admin/migration/journalist_migration>` to create new Journalist Workstation

- If you already have a Qubes Journalist Workstation (previously called a "SecureDrop Workstation") and simply want to install the administrative tools on it, turning it into a combined Admin + Journalist Workstation:
    #. Perform the :doc:`Journalist migration</admin/migration/journalist_migration>` steps on the Qubes current Journalist Workstation 

- If you already have a Qubes-based Journalist Workstation and want to migrate your Tails Admin Workstation to a separate Qubes-based Admin Workstation laptop:
    #. :doc:`Install Qubes OS and SecureDrop packages</admin/migration/migrate_install_qubes>` on the new laptop
    #. Perform :doc:`Admin migration</admin/migration/admin_migration>` to create new Admin Workstation


Decommissioning Tails Workstations
----------------------------------

After completing your migration and testing your new Qubes-based Admin and/or Journalist Workstations, securely decommission your Tails USB Workstations.

.. include:: /includes/destroy_usb.txt

.. TODO To create additional SecureDrop or Admin Workstations, follow the standard instructions in /deployment (need to be written!)

.. TODO destroy Tails USB keys

.. TODO test migration