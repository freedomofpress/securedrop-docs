Prepare the servers
===================

Pre-install steps
-----------------

Upgrade the server BIOS
~~~~~~~~~~~~~~~~~~~~~~~

Before beginning the installation process, you should upgrade your servers' BIOS
to the most recent stable version available. This process will differ for each
server make/model - if you are using one of the recommended NUC models, you can
find instructions in :doc:`../maintenance/bios_server`.

Update BIOS settings
~~~~~~~~~~~~~~~~~~~~

Once the BIOS has been updated, you should boot into it again to disable any unused
hardware, including:

* wireless LAN and Bluetooth
* Thunderbolt support
* audio support (output, speakers, microphones)
* other features supported by the hardware but not used by SecureDrop, such as Thunderbolt, SD card controller, or enhanced consumer infrared

In most cases, you should enable support for LAN and USB ports only. On NUC models, you can find this under **Advanced ▸ Onboard Devices**

You should also check the servers' boot settings. Ubuntu 24.04 supports both
Legacy and UEFI boot modes, with UEFI preferred. You should also disable Secure
Boot. SecureDrop uses a custom kernel with security patches, which is unsigned
and will not boot if Secure Boot is enabled.

Our :ref:`specific hardware recommendations <Specific Hardware Recommendations>`
enumerate recommended BIOS settings for hardware that we have tested.

.. _install_ubuntu:

Install Ubuntu
---------------

Ubuntu introduction
~~~~~~~~~~~~~~~~~~~

.. note:: Installing Ubuntu is simple and may even be something you are very familiar
  with, but it is **strongly** encouraged that you read and follow this documentation
  exactly as there are some "gotchas" that may cause your SecureDrop setup to break.

The SecureDrop Application Server and Monitor Server run **Ubuntu Server 24.04.3 LTS (Noble Numbat)**. To install Ubuntu on the servers, :ref:`you must first download and verify the Ubuntu installation media. <prepare_installation_media>` 

Perform the installation
~~~~~~~~~~~~~~~~~~~~~~~~

The steps below are the same for both the Application Server and the
Monitor Server.

Start by inserting the Ubuntu installation media into the server. Boot
or reboot the server with the installation media inserted, and enter the
boot menu. To enter the boot menu, you need to press a key as soon as
you turn the server on. This key varies depending on server model, but
common choices are Esc, F2, F10, and F12. Often, the server will briefly
display a message on boot that shows which key should be pressed to
enter the boot menu. Once you've entered the boot menu, select the
installation media (USB or CD) and press Enter to boot it.

On newer hardware, such as the NUC12s, you may need to use a newer Linux kernel
than the one that ships by default in **Ubuntu Server 24.04.3** in order to have
more up-to-date hardware drivers. To use a newer Linux kernel, select **Ubuntu
Server with the HWE kernel** in the initial OS boot menu that appears prior to
booting the Ubuntu image.

After booting the Ubuntu image, select **Install Ubuntu Server**.

Follow the steps to select your language, country and keyboard settings.
Once that's done, let the installation process continue.

Configure the network
~~~~~~~~~~~~~~~~~~~~~

On the **Network connections** screen, the installer will ask you to configure
at least one interface for use by the server. Your server should only have one
available, corresponding to its Ethernet, usually named ``eno1``. Select its list
entry using the arrow keys and press **Enter**, then select **Edit IPv4** and press
**Enter** again.

The **Edit eno1 IPv4 configuration** dialog will be displayed. In the
**IPv4 Method** menu, select **Manual**, then add your server-specific settings.

.. note:: For a production install with a pfSense network firewall in place, the
  Application Server and the Monitor Server are on separate networks.
  You may choose your own network settings at this point, but make sure
  the settings you choose are unique on the firewall's network and
  remember to propagate your choices through the rest of the installation process.

Below are the configurations you should enter, assuming you used the
default network settings from the network firewall guide. If you did not,
adjust these settings accordingly.

- Application Server:

  - **Subnet:** 10.20.2.0/24
  - **Address:** 10.20.2.2
  - **Gateway:** 10.20.2.1
  - **Name servers:** 8.8.8.8, 8.8.4.4
  - **Search domains:** *should be left blank*

- Monitor Server:

  - **Subnet:** 10.20.3.0/24
  - **Address:** 10.20.3.2
  - **Gateway:** 10.20.3.1
  - **Name servers:** 8.8.8.8, 8.8.4.4
  - **Search domains:** *should be left blank*

Select **Save** and press **Enter** to apply your settings. Then select **Done** and press **Enter**.

The default values on the **Configure Proxy** and **Configure Ubuntu archive mirror**
screens should not need to be changed. Select **Done** for both.

Continue without updating the installer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

With the network connection now active, the installer may alert you that a
newer version of Ubuntu Sever is now available.

It is critical that you use the version of Ubuntu Server you downloaded and
verified in the previous steps, rather than upgrading to the latest available
version.

Select the **Continue without updating** option when prompted.

Full disk encryption - pros and cons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The use of `Full Disk Encryption (FDE)
<https://www.eff.org/deeplinks/2012/11/privacy-ubuntu-1210-full-disk-encryption>`__
with SecureDrop is **not recommended**. While FDE does offer data protection for
devices that are powered down, SecureDrop's servers are designed to be always-on,
with the exception of a nightly reboot after automatic upgrades are applied.
Given this update schedule, with FDE enabled, the servers would become unreachable
once every 24 hours until an Administrator entered the full-disk encryption
passphrase via the console, and during that time, Sources and Journalists would
be unable to access your instance.

The increased responsibility for Administrators, as well as the daily downtime
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
- **Your server's name:** Use ``app`` for the Application Server, and ``mon`` for
  the Monitor Server
- **Pick a username:** Specify the administrator account username, e.g. ``sdadmin``
- **Choose a password:** Specify a strong password for the administrator account.
  A Diceware-generated passphrase is recommended.
- **Confirm your password:** Enter the password chosen above.

Select **Done** and press **Enter** to proceed.

.. warning:: The username and password you choose must be the same on both the
             Application Server and the Monitor Server. When you install
             SecureDrop on the servers from your Admin Workstation in a later step, you will
             only be allowed to enter one password, so it must be identical on
             both servers.

Decline upgrade to Ubuntu Pro
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The SecureDrop servers should not be registered with Ubuntu Advantage.  On the
**Upgrade to Ubuntu Pro** screen, make sure **Skip for now** is selected, then
choose **Continue**.

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

Save the configurations
~~~~~~~~~~~~~~~~~~~~~~~

When you are done, make sure you save the following information:

- The IP address of the Application Server
- The IP address of the Monitor Server
- The non-root user's name and passphrase for the servers.


