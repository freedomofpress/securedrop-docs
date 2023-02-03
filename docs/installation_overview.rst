Installation Overview
=====================

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

SecureDrop is a tool for sources to communicate securely with journalists. The
SecureDrop application environment consists of three dedicated computers:

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

These computers should all physically be in your organization's office.

In addition to these dedicated computers, each journalist will also need a
computer to connect to SecureDrop:

- *Journalist Workstation:*
   The computer used by the journalist to connect to
   the *Journalist Interface* to download encrypted documents that they will
   transfer to the *Secure Viewing Station*. The *Journalist Workstation*
   is also used to respond to sources via the *Journalist Interface*.

Depending on the news organization's threat model, the *Journalist Workstation*
can either be the journalist's every-day laptop or a dedicated computer. In
either case, it is recommended that journalists always use the
`Tails operating system`_ on their *Journalist Workstation* when connecting
to the *Journalist Interface*.

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


.. |SecureDrop architecture overview diagram| image:: ./diagrams/SecureDrop.png
  :width: 100%
