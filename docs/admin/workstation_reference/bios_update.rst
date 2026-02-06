BIOS Update Instructions
====================================

.. _general_BIOS_update:


Automatic BIOS Updates
----------------------

These instructions should work for many recent laptops, including the two ThinkPad models specifically included in our :doc:`hardware`.

If your laptop has Ubuntu preinstalled, run its **Software Updater** twice as follows:

  #. to install software updates, especially for the ``fwupd`` package; and then
  #. to run ``fwupd`` to update the BIOS automatically.

If **Software Updater** offers to run ``fwupd`` during step (1), decline until step (2), to make sure ``fwupd`` itself has received its latest security updates.

Other Linux
~~~~~~~~~~~

If your laptop has another Linux distribution installed, use the built-in software manager (such as GNOME Software or KDE Discover) to update the available software. Most modern distributions include ``fwupd`` by default. If not, you can install the package using your preferred software manager.

Once ``fwupd`` is installed, you can install available updates by running:

  .. code-block:: sh
  
    fwupdmgr refresh
    fwupdmgr update

Manual BIOS Updates
-------------------

If your laptop is not supported by ``fwupd``, you will need to consult the manual for your specific make and model to determine how to manually apply a BIOS update. The process will likely include downloading an update file, verifying its integrity, copying it to a USB drive, and then accessing an update menu within the BIOS settings. If you have a Thinkpad, refer to the instructions for :ref:`thinkpad_bios`.

.. _thinkpad_bios:

Manual BIOS on Lenovo ThinkPad laptops
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The instructions below assume the use of a Linux-based computer for the creation of a BIOS upgrade USB. To upgrade the BIOS:

- Locate the ThinkPad's "machine type" in its BIOS setup program:

  #. Boot (or reboot) the ThinkPad and follow the prompts to enter setup, usually via the <Enter> and <F1> keys.
  #. On the **Main** tab, look for the **Machine Type Model**.  The first four characters, such as `20L5`, `20L6`, or `20S0`, are the machine type.

- Visit `<https://support.lenovo.com>`_ in the Linux-based computer. Type the machine type found above into the search bar, then press **Enter**.
- In the "Product Home" page, select **Drivers And Software** and choose **BIOS/UEFI**.
- Download the file called either **BIOS Update (Bootable CD)** or **BIOS Update (Utility & Bootable CD)**.

.. note::
  A Tails USB can be used for the verification and conversion process described below, but the Lenovo support site blocks requests over Tor, preventing the ISO download. To work around this, either:

  - download the BIOS ISO on a different computer and transfer it to Tails using a USB stick, or
  - download the ISO in Tails using the Unsafe Browser as follows:

    - Start Tails with an administration password set and the Unsafe Browser enabled under "Additional Settings" on the Welcome Screen.
    - Open the Unsafe Browser: **Applications ▸ Internet ▸ Unsafe Browser** and find and download the ISO
    - Note the filename, as you'll need it for subsequent steps.
    - Leave the Unsafe Browser running, and open a terminal via **Applications ▸ System Tools ▸ Terminal**.
    - Copy the ISO to the desktop with the command:

      .. code-block:: sh

        sudo cp /var/lib/unsafe-browser/chroot/home/clearnet/Downloads/<fileName.iso> ~amnesia/Desktop

    - Fix the ISO file's ownership with the command:

      .. code-block:: sh

        sudo chown amnesia:amnesia ~amnesia/Desktop/<fileName.iso>

- Verify the checksum of the downloaded ISO file using the following command, comparing it against the checksum in the file listing above:

  .. code-block:: sh

    sha256sum /path/to/downloaded.iso

- Create a USB-bootable version of the ISO using the command:

  .. code-block:: sh

    geteltorito <path/to/CDISO> > usb-bios.iso

  .. note:: To install the ``geleltorito`` utility on Debian-based systems, use the command

    .. code-block:: sh

      sudo apt install genisoimage

    To install it on Fedora-based systems, use the command:

    .. code-block:: sh

      sudo dnf install geteltorito genisoimage

- Plug in a USB and check its device name with the ``lsblk`` command - use the root device name below, not a partition (eg. ``/dev/sdc`` instead of ``/dev/sdc1``).

- Write the BIOS update ISO to the USB using the following command:

  .. code-block:: sh

    sudo dd if=usb-bios.iso of=/dev/sdX bs=1M && sync

  where ``sdX`` is the device name verified above.

  .. caution::

    The ``dd`` command will wipe data on the targeted device. Make sure that you use the correct device name.

  Once complete, remove the USB.

- Plug the USB into the ThinkPad.

- Boot the ThinkPad and follow the prompts to enter its startup and boot menus, likely via the <Enter> and <F12> keys, respectively.

- Follow the on-screen instructions to update the BIOS, including any mandatory reboots. Note that the instructions may refer to an update CD instead of your update USB.
