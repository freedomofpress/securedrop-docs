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

.. toctree::
   :caption: Overview
   :name: overviewtoc
   :maxdepth: 2

   what_makes_securedrop_unique
   passphrase_best_practices
   threat_model/threat_model.rst
   threat_model/dataflow.rst
   threat_model/mitigations.rst
   training_schedule
   getting_support
   
.. toctree::
   :caption: User Guides
   :name: userguidetoc
   :maxdepth: 2

   source
   journalist
   admin

.. toctree::
   :caption: Installation Guide
   :name: installtoc
   :maxdepth: 2

   overview
   glossary
   passphrases
   hardware
   minimum_security_requirements
   before_you_begin
   create_usb_boot_drives
   set_up_svs
   set_up_transfer_and_export_device
   generate_submission_key
   set_up_admin_tails
   network_firewall
   firewall_pfsense
   firewall_opnsense
   servers
   install
   configure_admin_workstation_post_install
   create_admin_account
   test_the_installation

.. toctree::
   :caption: Deployment Guide
   :name: deploymentguide
   :maxdepth: 2

   deployment_practices
   deployment/landing_page.rst
   deployment/whole_site_changes.rst
   deployment/sample_privacy_policy.rst
   getting_the_most_out_of_securedrop
   onboarding_journalists
   onboarding_admins
   yubikey_setup
   https_source_interface
   ssh_over_local_net
   remote
   tails_printing_guide
   offboarding
   
.. toctree::
   :caption: Maintenance Guide
   :name: maintenance
   :maxdepth: 2

   logging
   ossec_alerts
   backup_and_restore
   backup_workstations
   update_tails_usbs
   kernel_troubleshooting
   rebuild_admin
   update_bios
   decommission

.. toctree::
   :caption: Upgrades
   :name: upgradetoc
   :maxdepth: 2

   upgrade/2.5.0_to_2.5.1.rst
   upgrade/2.4.2_to_2.5.0.rst
   upgrade/2.4.1_to_2.4.2.rst
   upgrade/2.4.0_to_2.4.1.rst
   upgrade/2.3.2_to_2.4.0.rst
   upgrade/2.3.1_to_2.3.2.rst

Two versions of this documentation are available:

- ``latest`` - built from the ``develop`` branch of the SecureDrop repository, containing updates that have been tested but not yet released.
- ``stable`` - built from the ``stable`` branch of the SecureDrop repository, and up to date with the most recent release, |version|.
