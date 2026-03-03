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
   introduction
   workstation_architecture
   supported_filetypes
   what_makes_securedrop_unique
   glossary
   threat_model/threat_model.rst
   threat_model/dataflow.rst
   threat_model/mitigations.rst
   getting_support
   training_schedule
   passphrase_best_practices
   known_issues

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
   journalist/starting_qubes
   journalist/starting_client
   journalist/sources
   journalist/submissions
   journalist/ending_session
   journalist/faq
   journalist/documents
   
.. toctree::
   :caption: Admin Guide: Reference
   :name: adminguidetoc
   :maxdepth: 2
   :hidden:

   
   admin/reference/admin
   admin/reference/responsibilities
   admin/workstation_reference/hardware
   admin/reference/admin_interface
   admin/reference/ssh_access
   admin/reference/securedrop_admin
   admin/workstation_reference/securing_workstation
   admin/workstation_reference/troubleshooting_connection
   admin/workstation_reference/troubleshooting_updates
   admin/reference/faq
   admin/workstation_reference/managing_clipboard

   
.. toctree::
   :caption: Admin Guide: Installation
   :name: installtoc
   :maxdepth: 2
   :hidden:

   admin/installation/installation_overview
   admin/installation/overview
   admin/installation/prepare
   admin/installation/passphrases
   admin/installation/hardware
   admin/installation/minimum_security_requirements
   admin/installation/create_usb_boot_drives
   admin/installation/set_up_transfer_and_export_device
   admin/installation/generate_submission_key
   admin/installation/set_up_keepassxc
   admin/installation/network_firewall
   admin/installation/firewall_pfsense
   admin/installation/firewall_opnsense
   admin/installation/servers
   admin/installation/install
   admin/installation/create_admin_account
   admin/installation/test_the_installation
   admin/installation/install_sdw
   admin/installation/troubleshoot

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
   admin/deployment/yubikey_setup
   admin/deployment/tor_pow
   admin/deployment/https_source_interface
   admin/deployment/ssh_over_local_net
   admin/deployment/offboarding

.. toctree::
   :caption: Admin Guide: Maintenance
   :name: maintenance
   :maxdepth: 2
   :hidden:

   admin/maintenance/upgrade_guide
   admin/maintenance/logging
   admin/maintenance/ossec_alerts
   admin/maintenance/backup_and_restore
   admin/maintenance/rebuild_admin
   admin/maintenance/updates_over_tor
   admin/maintenance/kernel_troubleshooting
   admin/maintenance/update_bios
   admin/maintenance/decommission
   admin/workstation_reference/backup
   admin/workstation_reference/bios_update
   admin/workstation_reference/provisioning_usb
   admin/workstation_reference/removing_gpg_passphrase
   admin/workstation_reference/reviewing_logs


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
