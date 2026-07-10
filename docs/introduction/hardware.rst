.. _hardware_guide:
.. _hardware:

Hardware
========

This document outlines the required hardware components necessary to
successfully install and operate a SecureDrop instance, and recommends
some specific components that we have found to work well. For specific
hardware recommendations, see :doc:`../appendices/hardware_recommendations`.
If you have any questions, please :doc:`contact the SecureDrop Support team </introduction/getting_support>`.

Hardware overview
-----------------

.. _Required Hardware:

For an installation of SecureDrop, you must acquire:

* 2 computers (with storage drives) to use as the SecureDrop servers.
* A mouse, keyboard, and monitor (along with any necessary dongles or adapters) for
  installing the servers.
* At least 1 dedicated physical laptop for the *SecureDrop Workstation*.
* A dedicated network firewall with at least 4 NICs.
* At least 3 ethernet cables.
* At least 1 USB flash drive for OS installation media,
  and at least 1 more USB flash drive if needed as an *Export Device*.

.. _Optional Hardware:

Additionally, you may want to consider the following purchases:

* a printer without wireless network support, to use in combination with the
  *SecureDrop Workstation*.
* an external hard drive for server backups.
* a USB flash drive to store backups of your *SecureDrop Workstation*.
* a security key for HOTP authentication, such as a YubiKey, if you want to
  use hardware-based *Two-Factor Authentication* instead of a mobile app.
* a USB flash drive with a physical write protection switch, or a USB write blocker,
  if you want to mitigate the risk of introducing malware from your network to
  your *SecureDrop Workstation* during repeated use of an *Export Device*.
  
.. tip::

    While a printer is not required, we highly recommend it. Printing documents
    is generally far safer than copying them in digital form. See our
    guide to working with documents for more information.

Advice for users on a tight budget
----------------------------------

If you cannot afford to purchase new hardware for your
SecureDrop instance, we encourage you to consider
re-purposing existing hardware to use with SecureDrop. If
you are comfortable working with hardware, this is a great
way to set up a SecureDrop instance for cheap.

Since SecureDrop's throughput is significantly limited by
the use of Tor for all connections, there is no need to use
top of the line hardware for any of the servers or the
firewall.

We recommend against re-purposing Apple Macintosh
laptops and desktops, due to incompatibility with Qubes OS.

If you choose to use recycled hardware, you should of course
consider whether or not it is trustworthy; making that
determination is outside the scope of this document.

Required hardware
-----------------

Servers
^^^^^^^

* *Application Server*: 1 physical server to run the SecureDrop web services.

* *Monitor Server*: 1 physical server which monitors activity on the
  *Application Server* and sends email notifications to an admin.
  
We recommend using NUCs for the servers and routinely test new models for compatibility.
NUCs ("Next Unit of Computing") are comparatively inexpensive, compact, quiet,
and low-power devices, which makes them suitable for deployment in a wide range
of environments. Originally produced by Intel, ASUS has taken over production
beginning with the 14th generation.

There are a `variety of models <https://www.asus.com/us/content/nuc-overview/>`__
to choose from. We currently recommend the 11th through 14th generation NUC models.
See our :ref:`hardware recommendations list <hardware_recommendations_servers>` for details
on specific models.

.. note:: If using non-recommended hardware, ensure you remove as much
    extraneous hardware as physically possible from your servers. This
    could include: speakers, cameras, microphones, fingerprint readers,
    wireless, and Bluetooth cards.
    
NUCs typically come as kits, and some assembly is required. You will need to
purchase the RAM and hard drive separately for each NUC and insert both into the
NUC before it can be used. We recommend:

-  2x 240GB SSDs (2.5" or M.2, depending on your choice of kit)
-  1x memory kit of compatible 2x8GB sticks
   -  You can put one 8GB memory stick in each of the servers.

We are often asked if it is acceptable to run SecureDrop on
cloud servers (e.g. Amazon EC2, DigitalOcean, etc.) or on dedicated
servers in third-party datacenters instead of on dedicated hardware
hosted in the organization. This request is generally motivated by a
desire for cost savings and/or convenience. However: we consider it
**critical** to have dedicated physical machines hosted within the
organization for both technical and legal reasons:

* While the documents are stored encrypted at rest (via PGP) on the
  SecureDrop *Application Server*, the documents hit server memory
  unencrypted (unless the source used the GPG key provided to
  encrypt the documents first before submitting), and are then
  encrypted in server memory before being written to disk. If the
  machines are compromised then the security of source material
  uploaded from that point on cannot be assured. The machines are
  hardened to prevent compromise for this reason. However, if an
  attacker has physical access to the servers either because the
  dedicated servers are located in a datacenter or because the
  servers are not dedicated and may have another virtual machine
  co-located on the same server, then the attacker may be able to
  compromise the machines. In addition, cloud servers are trivially
  accessible and manipulable by the provider that operates them. In
  the context of SecureDrop, this means that the provider could
  access extremely sensitive information, such as the plaintext of
  submissions or the encryption keys used to identify and access
  the *Onion Services*.

* In addition, attackers with legal authority such as law
  enforcement agencies may (depending on the jurisdiction) be able
  to compel physical access, potentially with a gag order attached,
  meaning that the third party hosting your servers or VMs may be
  legally unable to tell you that law enforcement has been given
  access to your SecureDrop servers.

One of the core goals of SecureDrop is to avoid the potential
compromise of sources through the compromise of third-party
communications providers. Therefore, we consider the use of
virtualization for production instances of SecureDrop to be an
unacceptable compromise and do not support it. Instead, dedicated
servers should be hosted in a physically secure location in the
organization itself. While it is technically possible to modify
SecureDrop's automated installation process to work on virtualized
servers (for example, we do so to support our CI pipeline), doing so
in order to run it on cloud servers is at your own risk and without
our support or consent.

Workstations
^^^^^^^^^^^^

In order to install and use *SecureDrop Workstation*, you will need a Qubes-compatible computer with the following specifications:

- 64-bit Intel processor with virtualization support
- a minimum of 32GB RAM
- sufficient disk space for the Qubes OS base install and SecureDrop Workstation (a 128GB or greater SSD is recommended)

We recommend against a device that requires an external USB keyboard or other externally-connected devices, for security reasons. In practice this usually means that you should run SecureDrop Workstation on a Qubes-compatible laptop. Not all laptops support Qubes, and some may require additional customization. We recommend (in order) either a Qubes-certified laptop, one of the laptop models we use for development and testing, or a computer from the community-maintained Qubes Hardware compatibility list. See our :ref:`specific laptop recommendations <hardware_recommendations_workstations>` for more detail on each of these options.

Network firewall
^^^^^^^^^^^^^^^^

You will need one physical computer that is used as a dedicated firewall
for the SecureDrop servers.

We recommend a 4 NIC network firewall and currently provide setup instructions for pfSense and OPNSense.
You can :ref:` find our list of recommended hardware firewalls here.<hardware_recommendations_firewall>`

An acceptable alternative that requires more technical expertise is
to :doc:`configure an existing hardware firewall <../admin/installation/network_firewall>`.

Two-factor device
^^^^^^^^^^^^^^^^^

*Two-Factor Authentication* is used when connecting to different parts of the
SecureDrop system. Each admin and each *Journalist* needs a two-factor
device. We currently support two options for *Two-Factor Authentication*:

* Your existing smartphone with an app that computes TOTP codes
  (e.g. FreeOTP `for Android <https://play.google.com/store/apps/details?id=org.fedorahosted.freeotp>`__ and `for iOS <https://apps.apple.com/us/app/freeotp-authenticator/id872559395>`__).

* A dedicated hardware dongle that computes HOTP codes (e.g. a
  `YubiKey <https://www.yubico.com/setup/>`__).

.. include:: ../includes/otp-app.txt

USB flash drives
^^^^^^^^^^^^^^^^

*Journalists* need physical media (known as the
*Export Device*) to copy submissions to their everyday workstation.

Our standard recommendation is to use USB flash drives, in combination with
volume-level encryption and careful data hygiene. We also urge the use
of a secure printer or similar analog conversions to 
export documents from the *SecureDrop Workstation*, whenever possible.

You may want to consider enforcing write protection on USB flash drives when only read
access is needed. We encourage you to evaluate these options in the context of
your own threat model. When it is consistently applied and correctly implemented in hardware, write
protection can prevent the spread of malware from the computers used to read
files stored on an *Export Device*. The two main options to achieve write protection of USB flash drives are:

- drives with a built-in physical write protection switch
- a separate USB write blocker device as used in forensic applications.

For USB flash drives with physical write protection, we have tested the `Kanguru SS3 <https://www.kanguru.com/products/kanguru-ss3>`__,
and it works well with and without encryption.

It is especially advisable to enable write protection before attaching an
*Export Device* to an everyday workstation that lacks the security protections
of the Tails operating system.

Please review our :doc:`setup guide <../admin/installation/provisioning_usb>`
for additional background on setting up *Export Devices*.

We also recommend buying an additional USB flash drive for making regular backups of
your *SecureDrop Workstations*.

One thing to consider is that you are going to have *a lot* of USB flash drives to
keep track of, so you should consider how you will label or identify them and
buy drives accordingly. Drives that are physically larger are often easier to
label (e.g. with tape, printed sticker or a label from a labelmaker).


Monitor, keyboard, mouse
^^^^^^^^^^^^^^^^^^^^^^^^

You will need these to do the initial installation of Ubuntu on the
*Application* and *Monitor Servers*.


Optional hardware
-----------------

This hardware is not *required* to run a SecureDrop instance, but most
of it is still recommended.

Printers
^^^^^^^^

There are several requirements for a printer to be compatible with SecureDrop Workstation. Your printer should:

1. Support **driverless printing** standards
2. Have a **USB port**
3. Be offline, or at least have **no WiFi**

These requirements are expanded below.

Driverless
~~~~~~~~~~

*SecureDrop Workstation* implements driverless IPP printing to support a large selection of modern printers. Compatible printers can be easily identified by their support for the Apple AirPrint or Moipra standards:

.. figure:: ../admin/workstation_reference/images/airprint.jpg

.. figure:: ../admin/workstation_reference/images/moipra.jpg

You may consult Apple's `list of printers that support AirPrint <https://support.apple.com/en-us/HT201311#printers>`_, Moipra's `list of certified products <https://mopria.org/certified-products>`_, or OpenPrinting's `list of printers supporting driverless printing <https://openprinting.github.io/printers/>`_.

USB ports
~~~~~~~~~

SecureDrop Workstation only supports printing over USB, so ensure the printer you select has a **USB port**.

.. note::
  In rare cases, an AirPrint or Moipra-compatible printer with a USB port may not actually support IPP-over-USB, which is required for SecureDrop to use the printer. Check with the manufacturer if in doubt. 
  
Offline
~~~~~~~

To maintain the isolation of SecureDrop Workstation, it is essential that your printer not be shared with other computers and networks. 

* Select a compatible printer with **no WiFi**. A printer that connects with USB only is best if you can find one, but compatible USB printers lacking *both* Ethernet and WiFi are rare. 
* In the case of a printer with Ethernet and/or WiFi, **keep the printer offline** and **disabling WiFi** (if present).
* Use this printer exclusively with SecureDrop Workstation and do not connect it directly to other computers.


Backup storage
^^^^^^^^^^^^^^

It's useful to run periodic backups of the servers in case of failure. We
recommend buying an external hard drive to store server backups.

.. include:: ../includes/encrypting-drives.txt

Hardware end-of-life
--------------------

No matter what hardware you decide to use, it's important to be mindful of
how long it will continue to receive security updates. Given the security
requirements for a SecureDrop instance, any hardware that is no longer
receiving security updates from the manufacturer will become more and more
vulnerable over time. Once your hardware has reached its end-of-life (EOL),
we recommend upgrading to newer, supported hardware. See our
:ref:`hardware recommendations <hardware_recommendations_eol>` for a list of
end-of-life dates for currently recommended hardware.
