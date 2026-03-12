Installation Overview
=====================

Migrating from a Tails-Based SecureDrop
---------------------------------------

If you are migrating from an older Tails-based SecureDrop, using the separate *Secure Viewing Station*, *Journalist Workstation* and *Admin Workstation* USB drives, then skip to the :ref:`Migration Overview<migration_overview>`.

Setting Expectations
--------------------

SecureDrop is a technical tool. It is designed to protect journalists and sources, but no tool can guarantee safety. This guide will instruct you in installing and configuring SecureDrop, but it does not explain how to use it safely and effectively. Put another way: at the end of this guide, you will have built a car; you will not know how to drive. The :ref:`Deployment Guide <deployment>` contains best practices for working with SecureDrop. Make sure to read it after completing the installation.

Setting up SecureDrop is a multi-step process, where each step builds on the steps that come before it. It's important that you treat the installation as a complete process, making sure not to skip any portions of the install guide or jump ahead to later content.

Once you have all the necessary hardware, :doc:`setting up SecureDrop <install>` will take at least a day's work.

We recommend that you set aside at least a week to :ref:`complete and test <Deployment>` your setup.

Tracking your progress
----------------------

To assist in the installation process, we offer a `SecureDrop Installation Worksheet`_, which you can print out and complete as you go. Only complete this worksheet on paper, never electronically.

It is **critical** that you destroy this worksheet when your installation is complete and all of your  passphrases have been safely stored in a password manager.

.. warning:: Remember to destroy the `SecureDrop Installation Worksheet`_ after the
             installation is complete.

.. _`SecureDrop Installation Worksheet`: https://docs.google.com/a/freedom.press/document/d/18RMAzhx1XCgpmw366I8tItBXQTzkFy_i_D0c605DTS8/edit?usp=sharing


Technical Summary
-----------------

This installation guide will walk you through the process of setting up
the computers and services needed for a functional SecureDrop.

During this process, you'll set up at least four devices:

- *SecureDrop Workstation*:
   A laptop running the QubesOS operating system configured as a *SecureDrop Workstation*, that you use to install and administer SecureDrop on the servers via SSH. If necessary (i.e. in a small newsroom), the same *SecureDrop Workstation* used for administration may be used by journalists to decrypt, view, and export submitted documents. For a larger newsroom, you may set up additional *SecureDrop Workstations* as needed for journalist use.
- *Application Server*:
   An Ubuntu server running two segmented Tor hidden services. The source connects to the *Source Interface*, a public-facing Tor Onion Service, to send messages and documents to the journalist. The journalist connects to the *Journalist Interface*, an `authenticated Tor Onion Service <https://community.torproject.org/onion-services/advanced/client-auth/>`__, using the SeucreDrop App on a SecureDrop Workstation to   download encrypted documents and respond to sources.
- *Monitor Server*:
   An Ubuntu server that monitors the *Application Server* with `OSSEC <https://www.ossec.net/>`__ and sends email alerts.
- Network Firewall
   A hardware firewall dedicated to your SecureDrop installation. 

A summary of the major steps is as follow:

#. Acquire compatible hardware.
#. Prepare email accounts and GPG keys for alert e-mails.
#. Prepare a primary *SecureDrop Workstation* laptop.
#. Set up the KeePassXC password manager on the primary *SecureDrop Workstation*.
#. Install and configure the dedicated network firewall from the primary *SecureDrop Workstation*. 
#. Prepare the (*Application* and *Monitor*) servers.
#. Install SecureDrop on the servers from the primary *SecureDrop Workstation*.
#. Complete local configuration of the primary *SecureDrop Workstation*.
#. Create the first Admin user.
#. Test the installation.

Optionally:
#. Prepare additional *SecureDrop Workstations* for use by journalists.
#. Prepare encrypted USB *Export Drives*.

Minimum security requirements for the SecureDrop Workstation
------------------------------------------------------------

The *SecureDrop Workstation* contains both a copy of the *Submission Private Key*, and encrypted and 
decrypted messages and submissions. It's critical to ensure that appropriate security practices are applied to the *SecureDrop Workstation*.

- *SecureDrop Workstations* should be stored in a secure and locked room, with access restricted to
  users and administrators. The room may be monitored externally, but there should be no internal
  monitoring.
- A wired Internet connection that does not restrict Tor must be available for
  the *SecureDrop Workstation*. This connection should either be dedicated to *SecureDrop
  Workstation*, or should be on a fully segregated subnet from the rest of the
  corporate network.
- Users should not bring other electronic devices into the room, with the
  exception of smartphones used for 2FA token generation. While in the room,
  smartphones should be set to airplane mode, and should not be used for any
  purpose other than 2FA.

Minimum security requirements for the SecureDrop servers
------------------------------------------------------------

-  The *Application* and *Monitor Servers* should be dedicated physical machines, not virtual machines.
-  A trusted location to host the servers. The servers should be hosted in a location that is owned or occupied by the organization to ensure that their legal department can not be bypassed with gag orders.
-  The SecureDrop servers should be on a separate internet connection or completely segmented from the corporate network, such as a dedicated subnet with DENY rules for all traffic to and from the corporate LAN.
-  All traffic from the corporate network should be blocked at the SecureDrop's point of demarcation.
-  Video monitoring should be recorded of the server area and the organizations safe.
-  An established monitoring plan and incident response plan. Who will receive the OSSEC alerts and what will their response plan be? These should cover technical outages and a compromised environment plan.