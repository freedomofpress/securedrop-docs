.. SecureDrop documentation master file, created by
   sphinx-quickstart on Tue Oct 13 12:08:52 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to SecureDrop's documentation!
======================================

SecureDrop is an open-source whistleblower submission system that media
organizations can use to securely accept documents from and communicate with
anonymous sources. It is a free and open source source project of the
`Freedom of the Press Foundation (FPF) <https://freedom.press/>`_, a US-based
nonprofit organization.

.. note:: This documentation is also available as a Tor Onion Service at
          http://dftlffjdogaragaxkc6jqxpo77s7rrngimyoq7uuq3clowhmttblcoyd.onion/en/stable/.


How it works
------------

Sources and journalists connect to SecureDrop using the Tor network. A source
uploads a submission via `Tor Browser <https://www.torproject.org/>`__ to the
*Source Interface*, a public onion service. A journalist then connects using
their *SecureDrop Workstation* to view, process, and respond to submissions.
Submissions are encrypted in place on the *Application Server* as they are
uploaded, and decrypted documents are never accessed in an Internet-connected
environment.

SecureDrop connects journalists and their sources directly, without third parties, and substantially limits recorded metadata. It puts news organizations in control to challenge any legal orders seeking data.

.. seealso:: :doc:`What makes SecureDrop Unique </introduction/what_makes_securedrop_unique>`


User roles
----------

There are three main user roles that interact with a SecureDrop instance:

:doc:`Sources </source/source>`
   Submit documents and messages using Tor Browser (or Tails) to access the
   *Source Interface*. Submissions are encrypted on the *Application Server*
   as they are uploaded.

:doc:`Journalists </journalist/journalist>`
   Use a *SecureDrop Workstation* to connect to SecureDrop and communicate
   with sources. Journalists download encrypted submissions and process
   them in an air-gapped environment.

:doc:`Admins </admin/installation/intro_for_admins>`
   Manage the *Application* and *Monitor Servers* over authenticated onion
   services.

.. note:: The terms in italics are terms of art specific to SecureDrop. The
	  :doc:`Glossary </appendices/glossary>` provides more-precise
          definitions of these and other terms. SecureDrop is designed against
          a comprehensive :doc:`/appendices/threat_model/threat_model`, and
          has a specific notion of the :doc:`roles </appendices/glossary>`
          that are involved in its operation.


Infrastructure overview
-----------------------

SecureDrop runs on two dedicated servers, one of which is the *Application 
Server* that hosts the *Source* and *Journalist Interfaces*, and the other
which is a *Monitor Server* that runs an intrusion detection service and sends 
email alerts.
  
The servers operate on a segmented network connected directly to a dedicated
hardware firewall.

A specially configured laptop, called a *SecureDrop Workstation*, 
is then used by journalists to download encrypted submissions and by admins
to perform server maintenance.

SecureDrop is free to install, but requires hardware costing roughly
$2,200–$2,400. See the :doc:`hardware guide </admin/installation/hardware>`
for supported and recommended equipment.

In addition to the hardware, you should make sure that you have the expertise
necessary to operate and maintain SecureDrop. You'll need
a systems administrator or IT professional familiar with using a command-line
interface within Linux.

The journalists in your organization will need to be trained in the operation of
SecureDrop, and you'll need to publish and promote your new SecureDrop instance 
afterwards using your existing websites, mailing lists, and social media.

It is recommended that you have all of this planned out before you get started.
If you need help, contact the `Freedom of the Press Foundation
<https://securedrop.org/help>`__ who will be glad to help walk you through
the process and make sure that you're ready to proceed.

Privacy and security
--------------------

While no system can guarantee 100% security, SecureDrop provides a number of
:ref:`safeguards and countermeasures <mitigations>` 
to create a significantly safer environment for
sources than standard channels.

Major architectural releases undergo third-party security audits; a full
`list of audits <https://securedrop.org/research/#audits>`__ is available,
along with a `bug bounty program <https://bugcrowd.com/freedomofpress>`__
hosted by Bugcrowd.

SecureDrop routes all traffic to and from the server via the encrypted Tor
network. Each SecureDrop server is completely owned by, and sits inside of, the
news organization that operates it. SecureDrop minimizes metadata by not 
recording IP addresses, browser details, or computer information. It forces
security best pactices for journalists and can be used in high-risk environments.


Get involved
------------

SecureDrop is an open source project. You can support the work by
`contributing to SecureDrop <https://developers.securedrop.org/en/latest/contributing.html>`_
or making `a donation <https://freedom.press/donate>`_.

.. toctree::
   :caption: Introduction
   :name: introtoc
   :maxdepth: 1
   :hidden:

   introduction/what_makes_securedrop_unique
   introduction/securedrop_workstation
   introduction/getting_support
   introduction/history

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
