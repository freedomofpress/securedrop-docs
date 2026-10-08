Installation overview
=====================

This section will walk you though all the steps involved in planning and executing a new SecureDrop installation.

.. note:: If you are migrating from an older SecureDrop, using the separate Tails-based "Secure Viewing Station", "Journalist workstation" and "Admin Workstation" USB flash drives, then skip to the :ref:`Migration Overview<migration_overview>`.

Setting expectations
--------------------

Setting up SecureDrop is a multi-step process, where each step builds on the steps that come before it. It's important that you treat the installation as a complete process, making sure not to skip any portions of the install guide or jump ahead to later steps.

Once you have all the necessary hardware, setting up SecureDrop will take at least a day's work. After installation, you will need at least one more day to :ref:`complete and test <Deployment>` your setup.

Planning your installation
--------------------------------

SecureDrop requires several different pieces of hardware, outlined below. 

Workstations
~~~~~~~~~~~~

The workstations are laptops running the Qubes operating system, with additional software and configurations depending on which roles they will fill.

The :ref:`Admin Workstation<glossary_admin_workstation>` is used by Administrators. It is configured with the tools and credentials needed to administer and install SecureDrop servers. 

The :ref:`SecureDrop Workstation<glossary_securedrop_workstation>` is used by Journalists. It has :ref:`SecureDrop Inbox<glossary_securedrop_inbox>` installed and configured to connect to your SecureDrop server.

Note that a single laptop can serve as a *combined* SecureDrop Workstation and Admin Workstation. This configuration accommodates small or cash-strapped newsrooms, where only a single laptop is shared between Administrators and Journalists, or where a single individual fills both roles. 

You may also segregate these roles onto two different laptops: one Admin Workstation for the Administrator and one SecureDrop Workstation for Journalists.

Alternatively, you may set up multiple SecureDrop Workstations to be used in different locations, or by different Journalists. It is even possible to have multiple Admin Workstations for different Administrators, although this requires :ref:`some coordination<multiple_admins>`. 

Before proceeding, you should decide how many laptops you will be use in your initial installation, and if one of them will be a combined Admin + SecureDrop Workstation as this will change how some of the following installation steps are performed.

You can always add additional workstations of any type later.

Servers
~~~~~~~

SecureDrop requires two paired physical servers that are installed at a premise controlled by your organization. These servers run the Ubuntu operating system.

The :ref:`Application Server<glossary_application_server>` runs the SecureDrop server application, providing the :ref:`Source Interface<glossary_source_interface>`, :ref:`Admin Interface<glossary_admin_interface>`, and the API endpoint used by SecureDrop Inbox to sync messages between Sources and Journalists.

The :ref:`Monitor Server <glossary_monitor_server>` monitors the Application server with `OSSEC <https://www.ossec.net/>`__ and sends email alerts.

Finally, a physical hardware Network Firewall is required to securely manage the connection between the Application and Monitor Servers and their connection to the internet. 

Minimum security requirements
-----------------------------

SecureDrop is a technical tool. It is designed to protect Journalists and Sources, but no tool can guarantee safety. There are a number of security requirements for the usage of SecureDrop's components, which should be considered when planning your installation.

Minimum security requirements for servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The SecureDrop servers handle all messages and files exchanged between Journalists and Sources. It is of the utmost importance that the SecureDrop servers are housed somewhere physically secure to prevent tampering and access by unauthorized parties.

- The Application and Monitor Servers should be dedicated physical machines, not virtual machines, :ref:`nor hosted on cloud servers<faq_physically_hosted>`.
- A trusted location to host the servers. The servers should be hosted in a location that is owned or occupied by the organization to ensure that their legal department can not be bypassed with gag orders.
- The SecureDrop servers should be on a separate internet connection or completely segmented from the corporate network, such as a dedicated subnet with DENY rules for all traffic to and from the corporate LAN.
- All traffic from the corporate network should be blocked at the SecureDrop's point of demarcation.
- Video monitoring should be recorded of the server area and the organization's safe.
- An established monitoring plan and incident response plan. Who will receive the OSSEC alerts and what will their response plan be? These should cover technical outages and a compromised environment plan.

Minimum security requirements for workstations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Every Admin and SecureDrop Workstation contains sensitive credentials and information related to your SecureDrop, such as SSH keys, the :ref:`Private Submission Key<glossary_submission_key>`, and copies of messages and files exchanged between Journalists and Sources. Therefore, it's critical to ensure that appropriate security practices are applied to every Admin and SecureDrop Workstation.

- SecureDrop Workstations should always be powered off and stored securely when not in use.
- During installation, a wired internet connection that is either dedicated for this purpose, or on a fully segregated subnet should be used. 
- Users should not bring other electronic devices into the room during installation, with the exception of smartphones used for 2FA token generation. While in the room, smartphones should be set to airplane mode, and should not be used for any purpose other than 2FA.

Summary of installation tasks
------------------------------

#. Acquire compatible hardware.
#. Prepare email accounts and GPG keys for alert emails.
#. Install Qubes OS and SecureDrop packages on workstations.
#. Generate the Submission Key.
#. Prepare the Admin Workstation.
#. Set up the KeePassXC password manager on the Admin Workstation.
#. Install and configure the dedicated network firewall from the Admin Workstation.
#. Prepare the (Application and Monitor) servers.
#. Install SecureDrop on the servers from the Admin Workstation.
#. Apply the Admin Workstation configuration.
#. Create the first Administrator user.
#. Create an Export Device.
#. Install SecureDrop Workstation.
#. Test the installation.
#. Troubleshoot any issues that occurred during installation.

Optionally:

#. Prepare additional Journalist Workstations for use by Journalists.

Tracking your progress
----------------------

To assist in the installation process, we offer a `SecureDrop Installation Worksheet`_, which you can print out and complete as you go. Only complete this worksheet on paper, never electronically.

It is **critical** that you destroy this worksheet when your installation is complete and all of your passphrases have been safely stored in a password manager.

.. warning:: Remember to destroy the `SecureDrop Installation Worksheet`_ after the installation is complete.

.. _`SecureDrop Installation Worksheet`: https://docs.google.com/a/freedom.press/document/d/18RMAzhx1XCgpmw366I8tItBXQTzkFy_i_D0c605DTS8/edit?usp=sharing

Installation support
--------------------

Any organization can install SecureDrop for free and also make modifications because the project is open source.

Because the installation and operation are complex, and because SecureDrop can only be as secure as the  operational security practices followed by its users, Freedom of the Press Foundation will also help  organizations install SecureDrop and train *Journalists* and administrators.

If you would like to work with Freedom of the Press Foundation on your SecureDrop installation, please reach out to us. We do ask news organizations that can afford to pay for installation support, training and maintenance to do so.

As part of `priority support agreements <https://securedrop.org/priority-support/>`_  and on a pro-bono basis for smaller news organizations, Freedom of the Press Foundation will visit your offices, help set up SecureDrop and train *Journalists* to use it. (For  pro-bono support, we request that our travel costs are covered.)

.. include:: ../../includes/provide-feedback.txt
