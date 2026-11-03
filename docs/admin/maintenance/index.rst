**************
Maintenance
**************

All the components of SecureDrop are designed to run with as little need for maintenance as possible. Nevertheless, there are times when manual intervention is necessary.

.. _manage_updates:

SecureDrop updates
-------------------

The Administrator should be aware of all SecureDrop updates and take any required manual action if requested in the `SecureDrop Release Blog`_ (`RSS feed`_). We also recommend making contact with SecureDrop support :ref:`via Signal<support_via_signal>`, so that we may let you know in advance of major releases if manual intervention will be required. Administrators should verify that the Servers and Workstations stay up-to-date and troubleshoot any issues with updates by following the instructions on the following pages.

- :doc:`server/server_updates`
- :doc:`workstation/workstation_updates`

.. _`SecureDrop Release Blog`: https://securedrop.org/news
.. _`RSS Feed`: https://securedrop.org/news/feed

.. _bios_updates:

BIOS updates
------------

The hardware used for the SecureDrop servers and Workstations will have underlying BIOS firmware provided by the hardware manufacturer. Keeping this firmware up-to-date is essential for maintaining the security of the devices that make up your SecureDrop.

- :doc:`server/bios_server`
- :doc:`workstation/bios_workstation`

Network Firewall updates
------------------------

Given all traffic first hits the network firewall as it faces the non-Tor public network, the Administrator should ensure that critical security patches are also applied to the firewall.

Refer to the respective sections :ref:`Keeping pfSense up to date` or :ref:`Keeping OPNSense up to date` if you used one of our recommended firewalls. Otherwise, consult your firewall manufacturer's documentation. 

Back up and restore
-------------------

All types of Workstations and the Application Server can be backed up and restored if necessary. It is also possible to rebuild the Admin Workstation from an existing Application Server and Journalist Workstation.

- :doc:`server/backup_servers`
- :doc:`workstation/backup_workstations`
- :doc:`workstation/rebuild_admin`
- :doc:`rotate_submission_key`

Alerts and logs
---------------

Both SecureDrop Servers and Workstations produce logs which can be useful for investigating problems and troubleshooting.

.. warning:: Do not post logs or alerts to public forums without first carefully examining and redacting any sensitive information.

.. _monitoring_ossec:

SecureDrop uses OSSEC to monitor the servers for unusual activity caused by system configuration issues or security breaches. The Administrator should decrypt and read all OSSEC alerts. Report any suspicious events to FPF through the `SecureDrop Support Portal`_. See the :doc:`OSSEC Guide </admin/maintenance/server/ossec_alerts>` for more information on common OSSEC alerts.

.. _`OSSEC`: https://www.ossec.net/
.. _`SecureDrop Support Portal`: https://support-docs.securedrop.org/

- :doc:`server/server_logs`
- :doc:`server/ossec_alerts`
- :doc:`workstation/workstation_logs`

Troubleshooting
---------------

Troubleshooting steps and fixes are provided for some of the most common issues you may encounter using the different components of SecureDrop:

- :doc:`server/troubleshoot_ossec`
- :doc:`workstation/troubleshoot_sd_manage`
- :doc:`workstation/troubleshoot_connection`
- :doc:`workstation/troubleshoot_qubes_install`

Decommissioning SecureDrop
--------------------------

Special steps should be followed if your SecureDrop needs to be temporarily shut down, moved, or permanently decommissioned. These steps are outlined on the :doc:`decommission` page.

.. toctree::
   :maxdepth: 1
   :hidden:

   server/index
   workstation/index
   decommission
   rotate_submission_key
