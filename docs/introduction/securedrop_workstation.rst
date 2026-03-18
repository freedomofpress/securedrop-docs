SecureDrop Workstation and Qubes OS
===================================

What is SecureDrop Workstation?
-------------------------------

A SecureDrop Workstation is a laptop used by a journalist to connect to a SecureDrop instance and securely view submissions and reply to messages from sources. The SecureDrop Workstation is based on Qubes OS and it consists of several different carefully-configured virtual machines (VMs), so that everything a journalist needs to use SecureDrop resides on one computer.

Encryption and decryption happen with one click using a network-isolated VM that holds the SecureDrop Submission Key. Submissions can be viewed securely on the same machine thanks to a `feature of Qubes`_ that creates temporary VMs in which to view untrusted content without exposing the rest of the system to that content. Journalists use the SecureDrop Workstation to decrypt, view, reply to, and export submissions.

A key feature of SecureDrop is that journalists can receive submissions from unknown sources without risking the security of their own machines and networks. Previously, SecureDrop accomplished this by using a physical airgap (the *Secure Viewing Station*), meaning that to view submissions, journalists would have to download them, transfer them to an encrypted USB drive, and physically take that drive to a separate, non-networked computer for decryption and viewing. SecureDrop Workstation combines all of those steps into one workflow on one machine: a Qubes computer that combines the *Journalist Workstation* and the *Secure Viewing Station*.

.. | securedrop_workstation_workflow |

.. _`feature of Qubes`: https://www.qubes-os.org/doc/disposablevm/

What is Qubes OS?
-----------------

`Qubes OS <https://www.qubes-os.org>`_ is an open source, security-focused
operating system. It is very different than operating systems you may be familiar with already, because it consists of multiple isolated virtual machines that allow you to separate more trusted components, files, or programs on your computer from less trusted components, files, or programs.

Broadly speaking, this means that even if files in one of your virtual machines are exposed to malware, files in others still have some protection, which is not true of other operating systems.

For more about the security features of Qubes, see
`the Qubes OS documentation`_.

.. _`Xen hypervisor`: https://wiki.xen.org/wiki/Xen_Project_Software_Overview
.. _`the Qubes OS documentation`: https://www.qubes-os.org/faq/#general--security


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

- ``sd-app``, which runs the SecureDrop Application, and holds decrypted messages,
  replies, and documents.
- ``sd-viewer``, which is the template for disposable VMs used for opening
  documents from the SecureDrop Application.
- ``sd-gpg``, which holds the *Submission Private Key* required to decrypt
  messages, replies, and documents.
- ``sd-devices``, which passes exported documents through to USB devices like
  printers and encrypted flash drives.

By design, the Qubes OS host domain, ``dom0``, also does not have Internet
access.

.. note::

   If you attempt to directly access the network in any of these VMs, it will
   not work. That is the expected behavior.

Because the SecureDrop Application must connect to the SecureDrop
*Application Server* in order to send or retrieve messages, documents, and
replies, it can communicate through Qubes-internal Remote Procedure Calls (RPCs)
with another VM, ``sd-proxy``, which can only access the open Internet through
the Tor network.

Like all networked VMs, ``sd-proxy`` uses the ``sys-firewall`` service to
connect to the network, which is provided via ``sys-net``. All three VMs must be
running for the SecureDrop Application to successfully connect to the server.

.. important::

   The ``sd-proxy`` VM contains a sensitive authentication token required to
   access the SecureDrop API via Tor, and should not be attached to VMs that are
   unrelated to SecureDrop.


Installing additional software on the SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Right now, the project is designed to make the journalist experience
easier by combining the functionality of the Journalist Workstation and Secure
Viewing Station. The main focus is making sure that checking SecureDrop is
easier and faster.

While we hope to add advanced tooling and document-processing options down the line,
at this time we request that you do not change the configuration of the workstation
or install additional software on it. If you have specific needs that you would like
to discuss with us, please contact us via Signal, or send us a
`PGP-encrypted email`_ at support@freedom.press.

.. _`PGP-encrypted email`: https://securedrop.org/sites/default/files/fpf-email.asc

Why can’t I save or print from the Viewer VM apps?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When you view a file on SecureDrop Workstation, it is opened in a disposable
VM that cannot access the network or any peripherals. The VM and all its data
will be destroyed the moment you close the viewer application.

You can save files from a viewer application, but copies saved inside a disposable
VM will be deleted when you close the application, and the changes will not be applied
to the main copy of the file stored on your computer.

You cannot print from the viewer application, because it does not have access
to peripherals. This prevents malware from exfiltrating data (e.g., via attached
USB devices), and from targeting hardware-level security vulnerabilities.

You *can* print files directly from the SecureDrop Application by clicking "Print"
for a downloaded file, which will pass the file through to your USB printer
without opening it in an interactive viewer application.

Why can't I copy and paste?
~~~~~~~~~~~~~~~~~~~~~~~~~~~
You should be able to copy and paste *within* any VM on the system, e.g.,
from one application running in ``sd-app`` to another.

Copy and paste between and to SecureDrop Workstation VMs is disabled for security
reasons. The goal of this restriction is to minimize the risk of accidental
pastes of sensitive content, and to reduce the attack surface for attempts to
exfiltrate information.

Administrators can configure limited exceptions to this policy; please see the
section :doc:`Managing Clipboard Access </admin/workstation_reference/managing_clipboard>`
of the admin guide for more information.

How is using Qubes different from using virtual machines?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Virtual machines that run on your Mac, Windows, or Linux machine (such as those
created using VirtualBox, Parallels, and so on) are a "guest" on your machine,
but still require a "host" operating system on top of which to run. These virtual machines are not designed as security tools; if the host OS is
compromised, there are no protections for the guest OS, and some features (such
as networking) allow communications between guest and host that can compromise
the security of both.

In contrast, Qubes virtualization occurs at a lower level, under the `Xen
hypervisor`_. This means that virtual machines (VMs) in a Qubes environment
can run operating systems that are independent of each
other and are not reliant on a host OS.

In addition, these virtual machines can be used to quarantine specific
functions of your computer. For example, network access is provided via two or
more VMs, and you can control which applications or files
have access to a networked environment by connecting to or disconnecting from
these VMs.

Finally, Qubes is designed to make it more difficult for malware to remain on
your machine. Each VM has read-only access to the root filesystem that
provides its operating system, meaning that if a VM is infected
with malware, it will be more difficult for that malware to persist across a
reboot of that VM.

For more about the security features of Qubes, see
`the Qubes OS documentation`_.

.. _`Xen hypervisor`: https://wiki.xen.org/wiki/Xen_Project_Software_Overview
.. _`the Qubes OS documentation`: https://www.qubes-os.org/faq/#general--security

How does the security of this system compare to using an air-gapped Secure Viewing Station?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The air-gapped Secure Viewing Station that is part of a SecureDrop setup offers strong
protections against exfiltration of submissions or encryption keys by adversaries. It lacks
important protections that SecureDrop Workstation provides. On the other hand, vulnerabilities
in Qubes OS or Xen Hypervisor may have a greater security impact than vulnerabilities
in Tails, the operating system used on a Secure Viewing Station.

A typical SVS USB drive may contain documents from multiple sources and always
contains the highly sensitive private key needed to decrypt them. An adversary who does
manage to achieve a security compromise (e.g., through a vulnerability in a file viewer
application) can access these other files, and may be able to exfiltrate them.

In spite of the air-gap, this may be possible through physical channels used to transfer files
off the SVS (e.g., USB drives), or by motivating the journalist user to perform an
unsafe action (e.g., `scanning a QR code <https://securedrop.org/news/security-advisory-do-not-scan-qr-codes-submitted-through-securedrop-connected-devices/>`__).

Because the air-gapped SVS has no Internet access, updates can only be performed using
another computer and a USB drive. In practice, newsrooms may not update their SVS
in a timely manner, which can significantly worsen its security posture.

In SecureDrop Workstation, any document received via SecureDrop is opened in a
disposable VM that has no Internet access and no access to other files submitted
via SecureDrop. The encryption keys are stored in a separate, networkless VM
from the SecureDrop Application.

Because SecureDrop Workstation has Internet access, updates can be applied
automatically as soon as they are available. SecureDrop Workstation enforces this
by downloading and applying updates before the user logs into SecureDrop.

SecureDrop Workstation uses hardware-assisted virtualization, which allows us
to use custom kernels for its VMs. These custom kernels use the
`grsecurity <https://grsecurity.net/>`__ patches which are also used on the
SecureDrop servers, and provide additional mitigation against security
vulnerabilities.

An attacker able to exploit vulnerabilities in Qubes OS or Xen-based bare metal
virtualization (likely in combination with other vulnerabilities, e.g., in a
viewer application) may be able to exfiltrate information directly to the Internet.
Qubes closely `tracks <https://www.qubes-os.org/security/xsa/>`__ any security
vulnerabilities that may impact it, and the automatic update mechanism helps to
ensure that, in the event of a vulnerability, every SecureDrop Workstation can be
patched as quickly as possible.

For further technical detail on design rationale and mitigations, please consult
our `design document <https://securedrop.org/whitepaper.pdf>`__.