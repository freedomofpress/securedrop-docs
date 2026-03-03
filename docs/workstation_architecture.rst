SecureDrop Workstation Architecture
===================================

.. _Networking Architecture:

SecureDrop Workstation networking architecture
----------------------------------------------
One key security feature of Qubes OS is that it enables users to configure the
appropriate level of network access for each VM. For example, you could have a
VM for password storage that has no network access, a work VM that is firewalled
to only connect to work servers, and a personal VM that always uses Tor.

SecureDrop Workstation tightly controls access to the network, in order to
prevent the exfiltration of messages, replies, documents, or encryption keys by
adversaries. Specifically, the following VMs have no network access:

- ``sd-app``, which runs the SecureDrop App, and holds decrypted messages,
  replies, and documents.
- ``sd-viewer``, which is the template for disposable VMs used for opening
  documents from the SecureDrop App.
- ``sd-gpg``, which holds the *Submission Private Key* required to decrypt
  messages, replies, and documents.
- ``sd-devices``, which passes exported documents through to USB devices like
  printers and encrypted flash drives.

By design, the Qubes OS host domain, ``dom0``, also does not have Internet
access.

.. note::

   If you attempt to directly access the network in any of these VMs, it will
   not work. That is the expected behavior.

Because the SecureDrop App must connect to the SecureDrop
*Application Server* in order to send or retrieve messages, documents, and
replies, it can communicate through Qubes-internal Remote Procedure Calls (RPCs)
with another VM, ``sd-proxy``, which can only access the open Internet through
the Tor network.

Like all networked VMs, ``sd-proxy`` uses the ``sys-firewall`` service to
connect to the network, which is provided via ``sys-net``. All three VMs must be
running for the SecureDrop App to successfully connect to the server.

.. important::

   The ``sd-proxy`` VM contains a sensitive authentication token required to
   access the SecureDrop API via Tor, and should not be attached to VMs that are
   unrelated to SecureDrop.

