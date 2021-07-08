Set Up the Servers
==================

Pre-Install Steps
-----------------

Upgrade the Server BIOS
~~~~~~~~~~~~~~~~~~~~~~~
Before beginning the installation process, you should upgrade your servers' BIOS
to the most recent stable version available. This process will differ for each
server make/model - if you are using one of the recommended NUC models, you can
find instructions in :doc:`update_bios`.

Update BIOS Settings
~~~~~~~~~~~~~~~~~~~~
Once the BIOS has been updated, you should boot into it again to disable any unused
hardware, including:

* wireless LAN and Bluetooth
* Thunderbolt support
* audio support (output, speakers, microphones)
* other features supported by the hardware but not used by SecureDrop.

In most cases, you should enable support for LAN and USB ports only.

You should also check the servers' boot settings. Ubuntu 20.04 supports both
Legacy and UEFI boot modes, with UEFI preferred. You should also disable Secure
Boot. SecureDrop uses a custom kernel with security patches, which is unsigned
and will not boot if Secure Boot is enabled.

Our :ref:`specific hardware recommendations <Specific Hardware Recommendations>`
enumerate recommended BIOS settings for hardware that we have tested.

Install Ubuntu
--------------

.. note:: Installing Ubuntu is simple and may even be something you are very familiar
  with, but it is **strongly** encouraged that you read and follow this documentation
  exactly as there are some "gotchas" that may cause your SecureDrop setup to break.

The SecureDrop *Application Server* and *Monitor Server* run **Ubuntu Server
20.04.2 LTS (Focal Fossa)**. To install Ubuntu on the servers, you must first
download and verify the Ubuntu installation media. You should use the *Admin
Workstation* to download and verify the Ubuntu installation media.

.. _download_ubuntu:

Download the Ubuntu Installation Media
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The installation media and the files required to verify it are available on the
`Ubuntu Releases page`_. You will need to download the following files:

* `ubuntu-20.04.2-live-server-amd64.iso`_
* `SHA256SUMS`_
* `SHA256SUMS.gpg`_

If you're reading this documentation in Tor Browser on the *Admin
Workstation*, you can just click the links above and follow the prompts to save
them to your Admin Workstation. Save them to the ``/home/amnesia/Persistent/Tor Browser``
directory on the *Admin Workstation*, because it can be useful to have a copy of
the installation media readily available.

Alternatively, you can use the command line:

.. code:: sh

   cd ~/Persistent
   torify curl -OOO https://releases.ubuntu.com/20.04.2/{ubuntu-20.04.2-live-server-amd64.iso,SHA256SUMS{,.gpg}}

.. note:: Downloading Ubuntu on the *Admin Workstation* can take a while
   because Tails does everything over Tor, and Tor is typically slow relative
   to the speed of your upstream Internet connection.

.. _Ubuntu Releases page: https://releases.ubuntu.com/
.. _ubuntu-20.04.2-live-server-amd64.iso: https://releases.ubuntu.com/20.04/ubuntu-20.04.2-live-server-amd64.iso
.. _SHA256SUMS: https://releases.ubuntu.com/20.04/SHA256SUMS
.. _SHA256SUMS.gpg: https://releases.ubuntu.com/20.04/SHA256SUMS.gpg

Verify the Ubuntu Installation Media
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should verify the Ubuntu image you downloaded hasn't been modified by
a malicious attacker or otherwise corrupted. To do so, check its integrity with
cryptographic signatures and hashes.

First, download both *Ubuntu Image Signing Keys* and verify their
fingerprints. ::

    gpg --recv-key --keyserver hkps://keyserver.ubuntu.com \
    "C598 6B4F 1257 FFA8 6632 CBA7 4618 1433 FBB7 5451" \
    "8439 38DF 228D 22F7 B374 2BC0 D94A A3F0 EFE2 1092"

.. note:: It is important you type this out correctly. If you are not
          copy-pasting this command, double-check you have
          entered it correctly before pressing enter.

Again, when passing the full public key fingerprint to the ``--recv-key`` command, GPG
will implicitly verify that the fingerprint of the key received matches the
argument passed.

.. caution:: If GPG warns you that the fingerprint of the key received
             does not match the one requested **do not** proceed with
             the installation. If this happens, please email us at
             securedrop@freedom.press.

Next, verify the ``SHA256SUMS`` file. ::

    gpg --keyid-format long --verify SHA256SUMS.gpg SHA256SUMS

Move on to the next step if you see "Good Signature" in the output, as
below. Note that any other message (such as "Can't check signature: no public
key") means that you are not ready to proceed. ::

    gpg: Signature made Thu 11 Feb 2021 02:07:58 PM EST
    gpg:                using RSA key 843938DF228D22F7B3742BC0D94AA3F0EFE21092
    gpg: Good signature from "Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>" [unknown]
    gpg: WARNING: This key is not certified with a trusted signature!
    gpg:          There is no indication that the signature belongs to the owner.
    Primary key fingerprint: 8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092

The next and final step is to verify the Ubuntu image. ::

    sha256sum -c <(grep ubuntu-20.04.2-live-server-amd64.iso SHA256SUMS)

If the final verification step is successful, you should see the
following output in your terminal. ::

    ubuntu-20.04.2-live-server-amd64.iso: OK

.. caution:: If you do not see the line above it is not safe to proceed with the
             installation. If this happens, please contact us at
             securedrop@freedom.press.

Create the Ubuntu Installation Media
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To create the Ubuntu installation media, you can either burn the ISO image to a
CD-R or create a bootable USB stick.  The ``dd`` command can be used to copy the
hybrid ISO directly to a USB drive, instead of a utility like UNetbootin which
can result in errors. Once you have a CD or USB with an ISO image of Ubuntu on
it, you may begin the Ubuntu installation on both SecureDrop servers.

To use `dd` you first need to find where the USB device you wish to install
Ubuntu on has been mapped. Simply running the command ``lsblk`` in the terminal
will give you a list of your block storage device mappings (this includes hard
drives and USB). If the USB you are writing the Ubuntu installer to is of a
different size or brand than the USB you are running Tails from, it should be
easy to identify which USB has which sdX identifier. If you are unsure, try
running ``lsblk`` before and after plugging in the USB you are using for the
Ubuntu installer. Note that you should use the main block device (e.g. ``/dev/sdb``)
rather than any listed partitions (e.g. ``/dev/sdb2``).

If your USB is mapped to /dev/sdX and you are currently in the directory that
contains the Ubuntu ISO, you would use dd like so: ::

   sudo dd conv=fdatasync if=ubuntu-20.04.2-live-server-amd64.iso of=/dev/sdX

.. _install_ubuntu:

Perform the Installation
~~~~~~~~~~~~~~~~~~~~~~~~

The steps below are the same for both the *Application Server* and the
*Monitor Server*.

Start by inserting the Ubuntu installation media into the server. Boot
or reboot the server with the installation media inserted, and enter the
boot menu. To enter the boot menu, you need to press a key as soon as
you turn the server on. This key varies depending on server model, but
common choices are Esc, F2, F10, and F12. Often, the server will briefly
display a message on boot that shows which key should be pressed to
enter the boot menu. Once you've entered the boot menu, select the
installation media (USB or CD) and press Enter to boot it.

After booting the Ubuntu image, select **Install Ubuntu Server**.

Follow the steps to select your language, country and keyboard settings.
Once that's done, let the installation process continue.

Configure the Network
~~~~~~~~~~~~~~~~~~~~~

On the **Network conections** screen, the installer will ask you to configure
at least one interface for use by the server. Your server should only have one
available, corresponding to its Ethernet, usually named ``eno1``. Select its list
entry using the arrow keys and press **Enter**, then select **Edit IPv4** and press
**Enter** again.

The **Edit eno1 IPv4 configuration** dialog will be displayed. In the
**IPv4 Method** menu, select **Manual**, then add your server-specific settings.

.. note:: For a production install with a pfSense network firewall in place, the
  *Application Server* and the *Monitor Server* are on separate networks.
  You may choose your own network settings at this point, but make sure
  the settings you choose are unique on the firewall's network and
  remember to propagate your choices through the rest of the installation process.

Below are the configurations you should enter, assuming you used the
network settings from the network firewall guide for a 3 NIC or 4 NIC firewall.
If you did not, adjust these settings accordingly.

-  *Application Server*:

  -  **Subnet:** 10.20.2.0/24
  -  **Address:** 10.20.2.2
  -  **Gateway:** 10.20.2.1
  -  **Name servers:** 8.8.8.8, 8.8.4.4
  -  **Search domains:** *should be left blank*

-  *Monitor Server*:

  -  **Subnet:** 10.20.3.0/24
  -  **Address:** 10.20.3.2
  -  **Gateway:** 10.20.3.1
  -  **Name servers:** 8.8.8.8, 8.8.4.4
  -  **Search domains:** *should be left blank*

Select **Save** and press **Enter** to apply your settings. Then select **Done** and press **Enter**.

The default values on the **Configure Proxy** and **Configure Ubuntu archive mirror**
screens should not need to be changed. Select **Done** for both.

Full Disk Encryption - pros and cons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The use of `Full Disk Encryption (FDE)
<https://www.eff.org/deeplinks/2012/11/privacy-ubuntu-1210-full-disk-encryption>`__
with SecureDrop is **not recommended**. While FDE does offer data protection for
devices that are powered down, SecureDrop's servers are designed to be always-on,
with the exception of a nightly reboot after automatic upgrades are applied.
Given this update schedule, with FDE enabled, the servers would become unreachable
once every 24 hours until an administrator entered the full-disk encryption
passphrase via the console, and during that time, sources and journalists would
be unable to access your instance.

The increased responsibility for administrators, as well as the daily downtime
and limited scenarios in which FDE would be a net security benefit, inform this
recommendation, but you may make a decision based on your own requirements.
(See this `GitHub issue <https://github.com/freedomofpress/securedrop/issues/511#issuecomment-50823554>`_
for more information.)

Setting up storage
~~~~~~~~~~~~~~~~~~

On the **Guided storage configuration** screen, verify that **Use an entire disk**
is checked, and that the server's local disk is selected. Also verify that **Set
up this disk as an LVM group** is selected.

If you decided to set up FDE, despite the implications for administration overhead,
select **Encrypt the LVM group with LUKS**, and enter and confirm the disk passphrase.
Store this passphrase securely, as it will be required to unlock storage on every reboot.

Select **Done** and press **Enter** to move to the **Storage Configuration** screen.
Review the configuration and select **Done** and press **Enter** to continue. Then,
choose **Continue** on the **Confirm destructive action** dialog.


Configure account and hostname
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On the **Profile setup** screen, configure the server's hostname and the administration account.
The administrator account username and password should be the same for both
servers:

- **Your name:** Specify the administrator account name, e.g. ``SecureDrop Admin``
- **Your server's name:** Use ``app`` for the *Application Server*, and ``mon`` for
  the *Monitor Server*
- **Pick a username:** Specify the administrator account username, e.g. ``sdadmin``
- **Choose a password:** Specify a strong password for the administrator account.
  A Diceware-generated passphrase is recommended.
- **Confirm your password:** Enter the password chosen above.

Select **Done** and press **Enter** to proceed.

Set up SSH access
~~~~~~~~~~~~~~~~~

On the **SSH Setup** screen, enable **Install OpenSSH server**. Verify that **No**
is selected for the **Import SSH Identity** option, as a custom SSH key will be created
for the administration account later in the installation process.

Verify that **Allow password authentication over SSH** is selected, and choose **Done**
to proceed.

Finish the installation
~~~~~~~~~~~~~~~~~~~~~~~
On the **Featured server snaps** screen, ensure that no snaps are selected and
choose **Done** to start the server installation process.

Once the server installation is complete, choose **Reboot Now** to reboot the system.

.. _nuc8_back_to_setup:

Save the Configurations
~~~~~~~~~~~~~~~~~~~~~~~

When you are done, make sure you save the following information:

-  The IP address of the *Application Server*
-  The IP address of the *Monitor Server*
-  The non-root user's name and passphrase for the servers.

.. _test_connectivity:

Test Connectivity
-----------------


Now that the firewall is set up, you can plug the *Application Server*
and the *Monitor Server* into the firewall. If you are using a setup
where there is a switch on the LAN port, plug the *Application Server*
into the switch and plug the *Monitor Server* into the OPT1 port.

You should make sure you can connect from the Admin
Workstation to both of the servers before continuing with the
installation.

In a terminal, verify that you can SSH into both servers,
authenticating with your passphrase:

.. code:: sh

    $ ssh <username>@<App IP address> hostname
    app
    $ ssh <username>@<Monitor IP address> hostname
    mon

.. tip:: If you cannot connect, check the network firewall logs for
         clues.

Set Up SSH Keys
---------------

Ubuntu's default SSH configuration authenticates users with their
passphrases; however, public key authentication is more secure, and once
it's set up it is also easier to use. In this section, you will create
a new SSH key for authenticating to both servers. Since the *Admin
Workstation* was set up with `SSH Client Persistence`_, this key will be saved
on the *Admin Workstation* and can be used in the future to authenticate to
the servers in order to perform administrative tasks.

.. _SSH Client Persistence: https://tails.boum.org/doc/first_steps/persistence/configure/index.en.html#index3h2

First, generate the new SSH keypair:

::

    ssh-keygen -t rsa -b 4096

You'll be asked to "Enter file in which to save the key" Type
**Enter** to use the default location.

Given that this key is on the encrypted persistence of a Tails USB,
you do not need to add an additional passphrase to protect the key.
If you do elect to use a passphrase, note that you will need to manually
type it (Tails' pinentry will not allow you to copy and paste a passphrase).

Once the key has finished generating, you need to copy the public key
to both servers. Use ``ssh-copy-id`` to copy the public key to each
server, authenticating with your passphrase:

.. code:: sh

    ssh-copy-id <username>@<App IP address>
    ssh-copy-id <username>@<Mon IP address>

Verify that you are able to authenticate to both servers by running
the below commands. You should not be prompted for a passphrase
(unless you chose to passphrase-protect the key you just created).

.. code:: sh

    $ ssh <username>@<App IP address> hostname
    app
    $ ssh <username>@<Monitor IP address> hostname
    mon

If you have successfully connected to the server via SSH, the terminal
output will be name of the server to which you have connected ('app'
or 'mon') as shown above.
