Installation overview
=====================

Migrating from a Tails-based SecureDrop
---------------------------------------

If you are migrating from an older SecureDrop, using the separate Tails-based *Secure Viewing Station*, *Journalist workstation* and *Admin Workstation* USB flash drives, then skip to the :ref:`Migration Overview<migration_overview>`.

Setting expectations
--------------------

SecureDrop is a technical tool. It is designed to protect *Journalists* and *Sources*, but no tool can guarantee safety. This guide will instruct you in installing and configuring SecureDrop, but it does not explain how to use it safely and effectively. The :ref:`deployment guide <deployment>` contains best practices for working with SecureDrop. Make sure to read it after completing the installation.

Setting up SecureDrop is a multi-step process, where each step builds on the steps that come before it. It's important that you treat the installation as a complete process, making sure not to skip any portions of the install guide or jump ahead to later content.

Once you have all the necessary hardware, :doc:`setting up SecureDrop <install>` will take at least a day's work. After installation, you will need at least one more day to :ref:`complete and test <Deployment>` your setup.

Installation support
--------------------

Any organization can install SecureDrop for free and also make modifications because the project is open source.

Because the installation and operation are complex, and because SecureDrop can only be as secure as the  operational security practices followed by its users, Freedom of the Press Foundation will also help  organizations install SecureDrop and train *Journalists* and administrators.

If you would like to work with Freedom of the Press Foundation on your SecureDrop installation, please reach out to us. We do ask news organizations that can afford to pay for installation support, training and maintenance to do so.

As part of `priority support agreements <https://securedrop.org/priority-support/>`_  and on a pro-bono basis for smaller news organizations, Freedom of the Press Foundation will visit your offices, help set up SecureDrop and train *Journalists* to use it. (For  pro-bono support, we request that our travel costs
are covered.) 

.. include:: ../../includes/provide-feedback.txt

Technical summary
-----------------

During this process, you'll set up at least four devices:

- *Admin Workstation*:
   A laptop running the Qubes OS operating system configured as an *Admin Workstation*, that you use to install and administer SecureDrop on the servers via SSH. If necessary (i.e. in a small newsroom), the same *SecureDrop Workstation* used for administration may be used as a *Journalist Workstation* by *Journalists* to decrypt, view, and export submitted documents. For a larger newsroom, you may set up additional *Journalist Workstations* as needed for *Journalist* use.
- *Application Server*:
   An Ubuntu server running two segmented Tor hidden services. The *Source* connects to the *Source Interface*, a public-facing Tor *Onion Service*, to send messages and documents to the *Journalist*. The *Journalist* connects to the *Journalist Interface*, an `authenticated Tor *Onion Service* <https://community.torproject.org/onion-services/advanced/client-auth/>`__, using SecureDrop Inbox on a *Journalist Workstation* to download encrypted documents and respond to *Sources*.
- *Monitor Server*:
   An Ubuntu server that monitors the *Application Server* with `OSSEC <https://www.ossec.net/>`__ and sends email alerts.
- Network Firewall
   A hardware firewall dedicated to your SecureDrop installation. 
   
A summary of the major steps is as follow:  

#. Acquire compatible hardware.
#. Prepare email accounts and GPG keys for alert emails.
#. Prepare an *Admin Workstation* laptop.
#. Generate the *Submission Key*
#. Set up the KeePassXC password manager on the *Admin Workstation*.
#. Install and configure the dedicated network firewall from the *Admin Workstation*. 
#. Prepare the (*Application* and *Monitor*) servers.
#. Install SecureDrop on the servers from the *Admin Workstation*.
#. Complete local configuration of the *Admin Workstation*.
#. Create the first Admin user.
#. Test the installation.

Optionally:

#. Prepare additional *Journalist Workstations* for use by *Journalists*.
#. Prepare encrypted *Export Devices*.
#. Troubleshoot any issues that occurred during installation

Tracking your progress
----------------------

To assist in the installation process, we offer a `SecureDrop Installation Worksheet`_, which you can print out and complete as you go. Only complete this worksheet on paper, never electronically.

It is **critical** that you destroy this worksheet when your installation is complete and all of your passphrases have been safely stored in a password manager.

.. warning:: Remember to destroy the `SecureDrop Installation Worksheet`_ after the
             installation is complete.

.. _`SecureDrop Installation Worksheet`: https://docs.google.com/a/freedom.press/document/d/18RMAzhx1XCgpmw366I8tItBXQTzkFy_i_D0c605DTS8/edit?usp=sharing


Minimum security requirements for a *SecureDrop Workstation*
------------------------------------------------------------

.. TODO Clarify differences between Journalist and Admin Workstations

A *SecureDrop Workstation* (either an *Admin Workstation* or a *Journalist Workstation*) contains both a copy of the *Submission Private Key*, and encrypted and decrypted messages and submissions. It's critical to ensure that appropriate security practices are applied to a *SecureDrop Workstation*.

- *SecureDrop Workstations* should always be powered off when not in use, and
  stored somewhere secure. Never leave them unattended.
- A wired Internet connection that does not restrict Tor must be available for
  the *SecureDrop Workstation* during installation. This connection should
  either be dedicated to *SecureDrop Workstation*, or should be on a fully
  segregated subnet from the rest of the corporate network.
- Users should not bring other electronic devices into the room during installation,
  with the exception of smartphones used for 2FA token generation. While in the room,
  smartphones should be set to airplane mode, and should not be used for any
  purpose other than 2FA.

Minimum security requirements for the SecureDrop servers
------------------------------------------------------------

-  The *Application* and *Monitor Servers* should be dedicated physical machines, not virtual machines, :ref:`nor hosted on cloud servers<faq_physically_hosted>`..
-  A trusted location to host the servers. The servers should be hosted in a location that is owned or occupied by the organization to ensure that their legal department can not be bypassed with gag orders.
-  The SecureDrop servers should be on a separate internet connection or completely segmented from the corporate network, such as a dedicated subnet with DENY rules for all traffic to and from the corporate LAN.
-  All traffic from the corporate network should be blocked at the SecureDrop's point of demarcation.
-  Video monitoring should be recorded of the server area and the organizations safe.
-  An established monitoring plan and incident response plan. Who will receive the OSSEC alerts and what will their response plan be? These should cover technical outages and a compromised environment plan.
