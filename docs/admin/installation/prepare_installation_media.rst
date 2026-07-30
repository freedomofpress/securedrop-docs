.. _prepare_installation_media:

Prepare installation media
==========================

SecureDrop Application and Monitor Servers run **Ubuntu Server 24.04.3 LTS (Noble Numbat)**. 

SecureDrop Workstation laptops run **Qubes 4.3**.

Preparing your everyday computer
--------------------------------

Before you can install and configure SecureDrop, you must first download and verify the operating system installation media using a normal, everyday computer. This computer can be running macOS, Windows, or Linux.

In order to verify the integrity of the downloaded installation media, you will need to run commands from a terminal or command line. You’ll also need GnuPG (``gpg``) installed. Consult the list below to learn how to prepare your everyday computer:

* **Linux:** ``gpg`` can be accessed via your favorite Terminal emulator, such as GNOME Console, Konsole, or Ptyxis. If ``gpg`` is not already installed, you can install it from your distribution's package manager tool.
* **Mac:** ``gpg`` must be manually installed from the `GPG Suite <https://gpgtools.org/>`__. Use Terminal.app, or your favorite third-party terminal emulator, to enter commands.
* **Windows:** ``gpg`` must be installed via `Gpg4win <https://gpg4win.org/download.html>`__. Use the Windows PowerShell to enter commands, which you can find by searching and selecting "Windows PowerShell" from the Start menu.

Preparing the installation media
--------------------------------

This guide assumes the use of a USB 3.0 flash drive, although you may also use optical media via an external disc drive (which may make more sense depending on your `security concerns <https://www.qubes-os.org/doc/install-security/>`_).

.. note:: A USB flash drive with a Type-A connector is recommended, as USB-C ports may be disabled on your computer when the BIOS settings are disabled later in the installation

Downloading operating system installers
----------------------------------------

.. _download_ubuntu:

Download and verify Ubuntu Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The installation media and the files required to verify it are available on the `Ubuntu Releases page`_. You will need to download the following files:

* `ubuntu-24.04.3-live-server-amd64.iso`_
* `SHA256SUMS`_
* `SHA256SUMS.gpg`_

Alternatively, you can use the command line on Linux or Mac:

.. code:: sh

   cd ~/Downloads
   curl -OOO https://releases.ubuntu.com/24.04.3/{ubuntu-24.04.3-live-server-amd64.iso,SHA256SUMS{,.gpg}}

.. _Ubuntu Releases page: https://releases.ubuntu.com/
.. _ubuntu-24.04.3-live-server-amd64.iso: https://releases.ubuntu.com/24.04/ubuntu-24.04.3-live-server-amd64.iso
.. _SHA256SUMS: https://releases.ubuntu.com/24.04/SHA256SUMS
.. _SHA256SUMS.gpg: https://releases.ubuntu.com/24.04/SHA256SUMS.gpg

or from a Windows PowerShell:

.. code:: sh

   cd ~\Downloads
   curl.exe -O https://releases.ubuntu.com/24.04.3/ubuntu-24.04.3-live-server-amd64.iso
   curl.exe -O https://releases.ubuntu.com/24.04.3/SHA256SUMS
   curl.exe -O https://releases.ubuntu.com/24.04.3/SHA256SUMS.gpg

You should verify the Ubuntu image you downloaded hasn't been modified by a malicious attacker or otherwise corrupted. To do so, check its integrity with cryptographic signatures and hashes.

First, download both *Ubuntu Image Signing Keys* and verify their fingerprints. ::

    gpg --recv-key --keyserver hkps://keyserver.ubuntu.com \
    "C598 6B4F 1257 FFA8 6632 CBA7 4618 1433 FBB7 5451" \
    "8439 38DF 228D 22F7 B374 2BC0 D94A A3F0 EFE2 1092"

.. note:: It is important you type this out correctly. If you are not copy-pasting this command, double-check you have entered it correctly before pressing enter.

Again, when passing the full public key fingerprint to the ``--recv-key`` command, GPG will implicitly verify that the fingerprint of the key received matches the argument passed.

.. caution:: If GPG warns you that the fingerprint of the key received does not match the one requested **do not** proceed with the installation. If this happens, please email us at securedrop@freedom.press.

Next, verify the ``SHA256SUMS`` file. ::

    gpg --keyid-format long --verify SHA256SUMS.gpg SHA256SUMS

Move on to the next step if you see "Good Signature" in the output, as below. Note that any other message (such as "Can't check signature: no public key") means that you are not ready to proceed. ::

    gpg: Signature made Thu 11 Feb 2021 02:07:58 PM EST
    gpg:                using RSA key 843938DF228D22F7B3742BC0D94AA3F0EFE21092
    gpg: Good signature from "Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>" [unknown]
    gpg: WARNING: This key is not certified with a trusted signature!
    gpg:          There is no indication that the signature belongs to the owner.
    Primary key fingerprint: 8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092

The next and final step is to verify the Ubuntu image. ::

    sha256sum -c <(grep ubuntu-24.04.3-live-server-amd64.iso SHA256SUMS)

If the final verification step is successful, you should see the following output in your terminal. ::

    ubuntu-24.04.3-live-server-amd64.iso: OK
    
If it does not report a good signature, try deleting the ISO and downloading it again.

.. caution:: If you do not see "Good signature" above it is not safe to proceed with the installation. If this happens, please contact us at securedrop@freedom.press.
             
Download and verify Qubes OS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Download the ``.iso`` and the ``Detached PGP signature`` for ``Qubes OS 4.3.1`` from `https://www.qubes-os.org/downloads/ <https://www.qubes-os.org/downloads/#qubes-os-4-3-1>`_. The ISO is 8 GB approximately, and may take some time to download based on the speed of your Internet connection.

Follow the linked instructions to `verify the ISO <https://doc.qubes-os.org/en/latest/project-security/verifying-signatures.html#how-to-verify-detached-pgp-signatures-on-qubes-isos>`_. Ensure that the ISO and hash values are in the same directory, then run:

.. code-block:: sh

  gpg --keyserver-options no-self-sigs-only,no-import-clean --fetch-keys https://keys.qubes-os.org/keys/qubes-release-4.3-signing-key.asc
  gpg -v --verify Qubes-R4.3.1-x86_64.iso.asc

The output should look like this:

.. code-block:: sh

  gpg: requesting key from 'https://keys.qubes-os.org/keys/qubes-release-4.3-signing-key.asc'
  gpg: key 1C3D9B627F3FADA4: 1 signature not checked due to a missing key
  gpg: /home/user/.gnupg/trustdb.gpg: trustdb created
  gpg: key 1C3D9B627F3FADA4: public key "Qubes OS Release 4.3 Signing Key" imported
  gpg: Total number processed: 1
  gpg:               imported: 1
  gpg: no ultimately trusted keys found

  gpg: enabled compatibility flags:
  gpg: assuming signed data in 'Qubes-R4.3.1-x86_64.iso'
  gpg: Signature made Wed Dec 17 23:33:45 2025 GMT
  gpg:                using RSA key F3FA3F99D6281F7B3A3E5E871C3D9B627F3FADA4
  gpg: using pgp trust model
  gpg: Good signature from "Qubes OS Release 4.3 Signing Key" [unknown]
  gpg: WARNING: This key is not certified with a trusted signature!
  gpg:          There is no indication that the signature belongs to the owner.
  Primary key fingerprint: F3FA 3F99 D628 1F7B 3A3E  5E87 1C3D 9B62 7F3F ADA4
  gpg: binary signature, digest algorithm SHA512, key algorithm rsa4096

Specifically, you will want to make sure that you see "Good signature" listed in the text. If it does not report a good signature, try deleting the ISO and downloading it again.

.. caution:: If you do not see the line above it is not safe to proceed with the installation. If this happens, please contact us at securedrop@freedom.press.

Create the installation media
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`Follow the steps in this guide to create bootable USB drives <https://ubuntu.com/desktop/docs/en/latest/how-to/create-a-bootable-usb-stick/>`__

.. note:: The guide above is written for Ubuntu, but the same steps and procedures can be used for the Qubes installation image as well.
