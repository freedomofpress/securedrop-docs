SecureDrop Workstation Installation Overview
============================================

Overview
--------

SecureDrop Workstation must be installed on a system running Qubes OS. The installation and configuration process should take between 4 and 6 hours, including time spent waiting for downloads and updates. At a high level, the tasks to be performed are as follows:

Pre-install tasks:
~~~~~~~~~~~~~~~~~~

#. Rotate legacy passphrases (for pre-2018 installations)
#. Apply BIOS updates and check settings
#. Download and verify Qubes OS
#. Install Qubes OS
#. (Hardware-dependent) Apply USB fixes
#. Apply updates to system templates
#. Install and update Fedora 41 base template

Install tasks:
~~~~~~~~~~~~~~

#. Copy the submission key
#. Copy *Journalist Interface* details
#. Copy SecureDrop login credentials
#. Download and install SecureDrop Workstation
#. Configure SecureDrop Workstation
#. Test the Workstation


Prerequisites
-------------
In order to install SecureDrop Workstation and configure it to use an existing SecureDrop instance, you will need the following:

- A Qubes-compatible computer with at least 16GB of RAM (32 GB is recommended) and known Linux Firmware Vendor support (https://fwupd.org/). SecureDrop Workstation has mainly been tested against Lenovo T400-series and T14 and Framework laptops. See Qubes' `Hardware Compatibility List <https://www.qubes-os.org/hcl/>`_ and the SecureDrop Workstation :doc:`hardware` page for more options. Note that HP laptops are not recommended due to firmware support limitations.
- Qubes installation medium - this guide assumes the use of a USB 3.0 stick. Qubes may also be installed via optical media, which may make more sense depending on your `security concerns <https://www.qubes-os.org/doc/install-security/>`_.

  .. note:: A USB stick with a Type-A connector is recommended, as USB-C ports may be disabled on your computer when the BIOS settings detailed below are applied.

- The SecureDrop instance's *Admin Workstation* and Secure Viewing Station (SVS) USBs, and the full GPG fingerprint of the submission key.
- (Optional, for a single-user workstation) The *Journalist Workstation* USB for the intended user of this workstation, if you want to import their SecureDrop login credentials into the workstation's password manager.
- The passphrases required to unlock the persistent volumes on each of these USB drives.

- A working computer (Linux is recommended and assumed in this guide) to use for verification and creation of the Qubes installation medium.

  .. note:: A Tails USB can be used to perform the tasks below, but due to the size of the Qubes installation ISO, it may make sense to download it on another computer rather than via Tor, and then to use a USB stick to transfer it to Tails for verification and creation of the installation medium.

- A password manager or other system to generate and store strong passphrases for Qubes full disk encryption (FDE) and user accounts.

A basic knowledge of the Qubes OS is helpful.
