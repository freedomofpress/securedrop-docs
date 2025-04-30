.. SecureDrop documentation master file, created by
   sphinx-quickstart on Tue Oct 13 12:08:52 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to SecureDrop's documentation!
======================================

SecureDrop is an open-source whistleblower submission system that media
organizations can use to securely accept documents from and communicate with
anonymous sources.

This documentation is intended for sources, journalists, and administrators.
If you would like to contribute to SecureDrop, please see our
`developer documentation <https://developers.securedrop.org/>`_.

.. note:: This documentation is also available as a Tor Onion Service at
          http://dftlffjdogaragaxkc6jqxpo77s7rrngimyoq7uuq3clowhmttblcoyd.onion/en/stable/.


Get Started
^^^^^^^^^^^

:doc:`I want to learn more about how SecureDrop works. <what_is_securedrop>`

:doc:`I have information I want to share, and would like to learn how to do so safely. <source/source>`

:doc:`I am looking to set up a SecureDrop installation. <admin/installation/installation_overview>`

:doc:`I have a SecureDrop installation and am interested in next steps. <admin/deployment/getting_the_most_out_of_securedrop>`

:doc:`I am a journalist and would like information about how to best use this system. <journalist/journalist>`


.. toctree::
   :caption: Overview
   :name: overviewtoc
   :maxdepth: 2
   :hidden:

   what_is_securedrop
   what_makes_securedrop_unique
   glossary
   threat_model/threat_model.rst
   threat_model/dataflow.rst
   threat_model/mitigations.rst
   getting_support
   training_schedule
   passphrase_best_practices

.. toctree::
   :caption: Source Guide
   :name: sourceguidetoc
   :maxdepth: 2
   :hidden:

   source/source
   source/before_you_submit
   source/how_to_submit
   source/after_you_submit

.. toctree::
   :caption: Journalist Guide
   :name: journalistguidetoc
   :maxdepth: 2
   :hidden:

   journalist/journalist
   journalist/workstation
   journalist/svs
   journalist/documents
.. toctree::
   :caption: Admin Guide: Reference
   :name: adminguidetoc
   :maxdepth: 2
   :hidden:

   admin/reference/admin
   admin/reference/responsibilities
   admin/reference/admin_interface
   admin/reference/ssh_access
   admin/reference/securedrop_admin
   admin/reference/faq

.. toctree::
   :caption: Admin Guide: Installation
   :name: installtoc
   :maxdepth: 2
   :hidden:

   admin/installation/installation_overview
   admin/installation/passphrases
   admin/installation/hardware
   admin/installation/minimum_security_requirements
   admin/installation/create_usb_boot_drives
   admin/installation/set_up_svs
   admin/installation/set_up_transfer_and_export_device
   admin/installation/generate_submission_key
   admin/installation/set_up_admin_tails
   admin/installation/network_firewall
   admin/installation/firewall_pfsense
   admin/installation/firewall_opnsense
   admin/installation/servers
   admin/installation/install
   admin/installation/configure_admin_workstation_post_install
   admin/installation/create_admin_account
   admin/installation/test_the_installation

.. toctree::
   :caption: Admin Guide: Deployment
   :name: deploymentguide
   :maxdepth: 2
   :hidden:

   admin/deployment/deployment_practices
   admin/deployment/landing_page.rst
   admin/deployment/onion_name.rst
   admin/deployment/whole_site_changes.rst
   admin/deployment/sample_privacy_policy.rst
   admin/deployment/getting_the_most_out_of_securedrop
   admin/deployment/onboarding_journalists
   admin/deployment/onboarding_admins
   admin/deployment/yubikey_setup
   admin/deployment/tor_pow
   admin/deployment/https_source_interface
   admin/deployment/ssh_over_local_net
   admin/deployment/remote
   admin/deployment/tails_printing_guide
   admin/deployment/offboarding

.. toctree::
   :caption: Admin Guide: Maintenance
   :name: maintenance
   :maxdepth: 2
   :hidden:

   admin/maintenance/logging
   admin/maintenance/ossec_alerts
   admin/maintenance/backup_and_restore
   admin/maintenance/backup_workstations
   admin/maintenance/update_workstations
   admin/maintenance/update_tails_usbs
   admin/maintenance/updates_over_tor
   admin/maintenance/kernel_troubleshooting
   admin/maintenance/rebuild_admin
   admin/maintenance/update_bios
   admin/maintenance/decommission
   admin/maintenance/noble_migration_prep
   admin/maintenance/noble_migration

.. toctree::
   :caption: Admin Guide: Upgrades
   :name: upgradetoc
   :maxdepth: 2
   :hidden:

   upgrade/2.12.2_to_2.12.3.rst
   upgrade/2.12.1_to_2.12.2.rst
   upgrade/2.12.0_to_2.12.1.rst
   upgrade/2.11.1_to_2.12.0.rst
   upgrade/2.11.0_to_2.11.1.rst
   upgrade/2.10.1_to_2.11.0.rst
   upgrade/2.10.0_to_2.10.1.rst
   upgrade/2.9.0_to_2.10.0.rst
   upgrade/2.8.0_to_2.9.0.rst
   upgrade/2.7.0_to_2.8.0.rst
   upgrade/2.6.1_to_2.7.0.rst
   upgrade/2.6.0_to_2.6.1.rst

Get Involved
^^^^^^^^^^^^

SecureDrop is an open source project. If you would like to contribute
to SecureDrop, please see our
`developer documentation <https://developers.securedrop.org/>`_.

Two versions of this documentation are available, and can be selected in the
lower left corner using the version dropdown menu:

- ``latest`` - built from the ``develop`` branch of the SecureDrop
  repository, containing updates that have been tested but not yet released.
- ``stable`` - built from the ``stable`` branch of the SecureDrop repository,
  and up to date with the most recent release, |version|.
