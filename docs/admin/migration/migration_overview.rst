Migration overview
==================

.. _migration_overview:

The previous version of SecureDrop was based three workstations: 

- The Journalist Workstation, where Journalists downloaded new submissions or replied to Sources.
- The Secure Viewing Station (or SVS), where journalists decrypted and viewed submissions.
- The Admin Workstation, used by Administrators to administer the SecureDrop servers. 

Each of these workstations was actually an individual USB flash drive with the `Tails <https://tails.net>`__ operating system installed, used to boot a laptops for each role (in the case of the SVS, this was always a physically air-gapped laptop).

SecureDrop Workstation has been available as an open beta `since 2024 <https://securedrop.org/news/securedrop-workstation-1_0_0-released/>`__, but the Tails-based Admin Workstation was still needed for administration tasks. Some organizations already have a mix of the older Tails-based workstations and newer Qubes based SecureDrop Workstations.

As of SecureDrop Workstation 2.0.0, administrative tasks can be performed using a Qubes-based Admin Workstation. The Tails-based components are no longer needed, and will soon be depreciated.

.. note:: Everywhere else in this documentation, the older *Tails-based Admin Workstation* (a USB flash drive) will be named as such. Take care not to confuse it with the new :ref:`Admin Workstation<glossary_admin_workstation>` (a laptop running Qubes OS with the SecureDrop administrative tools installed).

Hardware overview
---------------------

Workstations
^^^^^^^^^^^^

SecureDrop Workstation has different hardware requirements for the physical laptops used. 

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

SecureDrop Workstation supports printing directly from the workstation where Source messages and files are decrypted and viewed.

.. include:: /admin/installation/hardware.rst
    :start-after: .. _hardware_printers_overview:
    :end-before: .. _hardware_printers_overview_end:

Other hardware
^^^^^^^^^^^^^^

There is no need to upgrade or reinstall the SecureDrop Application and Monitor servers. Likewise for the Network Firewall. The software, configuration, and hardware requirements for these devices are unchanged.

However, if you have been using SecureDrop for awhile, you may take this opportunity to audit your current server and firewall hardware, and replace it if it has reached end-of-life. See our complete hardware recommendations list for :ref:`servers <hardware_recommendations_servers>` and :ref:`firewalls <hardware_recommendations_firewall>`.

Migration scenarios
-------------------

If you are starting with only the Tail-based Workstation:

1. :doc:`Install Qubes OS and SecureDrop packages</admin/migration/migrate_install_qubes>` on the desired number of laptops
    - One laptop to create a combined Admin + SecureDrop Workstation
    - Two laptops to create separate Admin and SecureDrop Workstations

2. Perform :doc:`Admin migration</admin/migration/admin_migration>` to create new Admin Workstation
3. Perform Journalist migration to create new SecureDrop Workstation

If you already have a Qubes-based SecureDrop Workstation and simply want to install the administrative tools on it, turning it into a combined Admin + SecureDrop Workstation:

#. Perform the :doc:`Journalist migration</admin/migration/journalist_migration>` steps on the current SecureDrop Workstation 

If you already have a Qubes-based SecureDrop Workstation and want to migrate your Tails-based Admin Workstation to a separate Qubes-based Admin Workstation laptop:

#. :doc:`Install Qubes OS and SecureDrop packages</admin/migration/migrate_install_qubes>` on the new laptop
#. Perform :doc:`Admin migration</admin/migration/admin_migration>` to create new Admin Workstation

.. TODO To create additional SecureDrop or Admin Workstations, follow the standard instructions in /deployment (need to be written!)