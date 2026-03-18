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

:doc:`I want to learn more about how SecureDrop works. <introduction/what_is_securedrop>`

:doc:`I have information I want to share, and would like to learn how to do so safely. <source/source>`

:doc:`I am looking to set up a SecureDrop installation. <admin/installation/installation_overview>`

:doc:`I have a SecureDrop installation and am interested in next steps. <admin/deployment/getting_the_most_out_of_securedrop>`

:doc:`I am a journalist and would like information about how to best use this system. <journalist/journalist>`

.. note:: The terms in italics are terms of art specific to SecureDrop. The
	  :doc:`Glossary </appendices/glossary>` provides more-precise
          definitions of these and other terms. SecureDrop is designed against
          a comprehensive :doc:`/appendices/threat_model/threat_model`, and has a specific notion of the :doc:`roles </appendices/glossary>` that are involved in its operation.

.. toctree::
   :caption: Introduction
   :name: introtoc
   :maxdepth: 2
   :hidden:

   introduction/what_is_securedrop
   introduction/what_makes_securedrop_unique
   introduction/securedrop_workstation
   introduction/getting_support

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

.. toctree::
   :caption: Admin Guide: Installation
   :name: installtoc
   :maxdepth: 2
   :hidden:

   admin/installation/intro_for_admins
   admin/installation/installation_overview
   admin/installation/hardware
   admin/installation/passphrases.rst
   admin/installation/email_alerts
   admin/installation/prepare_sdw
   admin/installation/generate_submission_key
   admin/installation/set_up_keepassxc
   admin/installation/network_firewall
   admin/installation/firewall_pfsense
   admin/installation/firewall_opnsense
   admin/installation/prepare_servers
   admin/installation/install
   admin/installation/apply_sdw
   admin/installation/create_admin_account
   admin/installation/test_the_installation
   admin/installation/provisioning_usb
   admin/installation/troubleshoot_qubes
   admin/installation/troubleshoot_ossec

.. toctree::
   :caption: Admin Guide: Migration
   :name: migrationguide
   :maxdepth: 2
   :hidden:

   admin/migration/migration_overview
   admin/migration/admin_migration
   admin/migration/journalist_migration
   admin/migration/removing_gpg_passphrase

.. toctree::
   :caption: Admin Guide: Deployment
   :name: deploymentguide
   :maxdepth: 2
   :hidden:

   admin/deployment/onboard_journalists
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
   admin/deployment/configuring_ossec_fingerprint

.. toctree::
   :caption: Admin Guide: Reference
   :name: adminguidetoc
   :maxdepth: 2
   :hidden:
   
   admin/reference/admin_interface
   admin/reference/ossec_alerts
   admin/reference/ssh_access
   admin/reference/offboarding
   admin/reference/securedrop_admin

.. toctree::
   :caption: Admin Guide: Maintenance
   :name: maintenance
   :maxdepth: 2
   :hidden:

   admin/maintenance/upgrade_guide
   admin/maintenance/logging
   admin/maintenance/troubleshooting_connection
   admin/maintenance/backup_and_restore
   admin/maintenance/rebuild_admin
   admin/maintenance/updates_over_tor
   admin/maintenance/kernel_troubleshooting
   admin/maintenance/bios_server
   admin/maintenance/decommission
   admin/workstation_reference/backup
   admin/workstation_reference/bios_workstation
   admin/workstation_reference/reviewing_logs
   admin/workstation_reference/troubleshooting_updates
   admin/workstation_reference/managing_clipboard

.. toctree::
   :caption: Appendices
   :name: appendicestoc
   :maxdepth: 2
   :hidden:

   appendices/glossary
   appendices/threat_model/threat_model.rst
   appendices/threat_model/dataflow.rst
   appendices/threat_model/mitigations.rst
   appendices/training_schedule

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
