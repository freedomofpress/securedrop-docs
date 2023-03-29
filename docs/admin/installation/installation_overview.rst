Installation Overview
=====================

Before You Begin
----------------

Any organization can install SecureDrop for free and also make modifications
because the project is open source.

Because the installation and operation are complex, and because SecureDrop can
only be as secure as the operational security practices followed by its users,
Freedom of the Press Foundation will also help organizations install SecureDrop
and train journalists and administrators.

If you would like to work with Freedom of the Press Foundation on your
SecureDrop installation, please reach out to us. We do ask news organizations
that can afford to pay for installation support, training and maintenance to do
so.

As part of `priority support agreements <https://securedrop.org/priority-support/>`_ 
and on a pro-bono basis for smaller news organizations, Freedom of the Press
Foundation will visit your offices, help set up SecureDrop and train
journalists to use it. (For pro-bono support, we request that our travel costs
are covered.)


Setting Expectations
--------------------

Setting up SecureDrop is a multi-step process, where each step builds on the
steps that come before it. It's important that you treat the installation
as a complete process, making sure not to skip any portions of the install
guide or jump ahead to later content.

Once you have all the necessary hardware,
:doc:`setting up SecureDrop <install>` will take at least a day's work.

We recommend that you set aside at least a week to
:ref:`complete and test <Deployment>` your setup.


Technical Summary
-----------------

|SecureDrop architecture overview diagram|

This installation guide will walk you through the process of setting up
the computers and services needed for a functional SecureDrop.

During this process, you'll set up the following devices:

- *Secure Viewing Station*:
   A physically-secured and air-gapped laptop running
   the `Tails operating system`_ from a USB stick, that journalists use to
   decrypt and view submitted documents.
- *Application Server*:
   An Ubuntu server running two segmented Tor hidden
   services. The source connects to the *Source Interface*, a public-facing Tor
   Onion Service, to send messages and documents to the journalist. The
   journalist connects to the *Journalist Interface*, an `authenticated Tor
   Onion Service
   <https://community.torproject.org/onion-services/advanced/client-auth/>`__, to
   download encrypted documents and respond to sources.
- *Monitor Server*:
   An Ubuntu server that monitors the *Application Server*
   with `OSSEC <https://www.ossec.net/>`__ and sends email alerts.

As an administrator, you will also require a computer to connect to SecureDrop
and perform administrative tasks via SSH or the *Journalist Interface*.
This computer is referred to as the *Admin Workstation*, and must be capable of
running the `Tails operating system`_. The *Admin Workstation* may also be used
as a *Journalist Workstation* if necessary.

.. note:: The SecureDrop installation guide includes documentation on setting up
          Tails-based `Admin Workstation` and `Journalist Workstation` USB
          sticks. It is strongly recommended that these be used in preference to
          other undocumented solutions.


.. _`Tails operating system`: https://tails.boum.org


.. |SecureDrop architecture overview diagram| image:: ../../diagrams/SecureDrop.png
  :width: 100%
