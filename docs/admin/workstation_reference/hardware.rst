Recommended hardware
====================

Qubes OS hardware requirements
------------------------------

In order to install and use SecureDrop Workstation, you will need a Qubes-Compatible computer with the following specifications:

- 64-bit Intel processor with virtualization support
- a minimum of 32GB RAM
- sufficient disk space for the Qubes OS base install and SecureDrop Workstation VMs (a 128GB or greater SSD is recommended)

More information on hardware compatibility can be found on the `Qubes OS System Requirements <https://www.qubes-os.org/doc/system-requirements/>`_ page.


Choosing a laptop
-----------------
We recommend against a device that requires an external USB keyboard or other externally-connected devices, for security reasons. In practice this usually means that you should run SecureDrop Workstation on a Qubes-compatible laptop. Not all laptops support Qubes, and some may require additional customization. We recommend (in order) either a Qubes-certified laptop, one of the laptop models we use for development and testing, or a computer from the community-maintained Qubes Hardware compatibility list.

Qubes-certified laptops
~~~~~~~~~~~~~~~~~~~~~~~

Qubes-certified laptops are certified and tested against Qubes major releases. They must support additional security features beyond the minimal requirements above, such as the use of `coreboot <https://www.coreboot.org/>`_ in place of proprietary firmware. Where possible, we recommend that you use a Qubes-certified laptop with ``coreboot`` for SecureDrop Workstation. A full list of certified computers can be found on the `Qubes OS Certified Hardware <https://www.qubes-os.org/doc/certified-hardware/>`_ page.

        .. note:: Some certified computers also support the use of `Heads <https://osresearch.net>`_ with ``coreboot``, for additional protection against advanced attacks during the boot process. Heads adds a layer of complexity to the overall user experience, but may make sense for you as an option if you have an expectation of those kinds of threats. If you have questions about Heads, or other hardware choices, contact us via Signal`_.

FPF-tested laptops
~~~~~~~~~~~~~~~~~~
In addition to Qubes-certified devices, we develop and test using Qubes-compatible laptops from other vendors. The following models may be used for SecureDrop Workstation, though some level of additional configuration may be required.

.. _framework_13_series:

Framework 13 (Intel Core Ultra Series 1)
****************************************

The Framework 13 laptop with an Intel Core Ultra Series 1 processor is a recommended option for the SecureDrop Workstation beginning with Qubes 4.2. 

You can either order a preassmbled system, or you can customize your build and assemble the laptop yourself once it is delivered, which is useful as either a cost-saving measure or in the event that you wish to customize the ports or internal components.

Framework laptops are designed to be repairable, customizable, and user-servicable, and have grown to be a popular choice with Qubes users and SecureDrop developers.

You will want to ensure you are using the latest BIOS version available. Instructions for checking the BIOS version and performing an upgrade for the Intel Core Ultra Series 1 models can be found on `this page in the Framework knowledgebase. <https://knowledgebase.frame.work/framework-laptop-bios-and-driver-releases-intel-core-ultra-series-1-H1nZQdxYR>`_

.. note::

    You'll want to be sure to install Qubes OS using the kernel-latest option, available from the initial boot menu (GRUB) prior to booting to the Qubes OS installer.

Framework 13 (13th-generation)
******************************

The Framework 13 laptop with a 13th generation Intel processor is a recommended option for the SecureDrop Workstation beginning with Qubes 4.2. 

You can either order a preassmbled system, or you can customize your build and assemble the laptop yourself once it is delivered, which is useful as either a cost-saving measure or in the event that you wish to customize the ports or internal components.

Framework laptops are designed to be repairable, customizable, and user-servicable, and have grown to be a popular choice with Qubes users and SecureDrop developers.

You will want to ensure you are using the latest BIOS version available. Instructions for checking the BIOS version and performing an upgrade for the 13th generation models can be found `here in the Framework knowledgebase. <https://knowledgebase.frame.work/framework-laptop-bios-and-driver-releases-13th-gen-intel-core-BkQBvKWr3>`_

.. _thinkpad_x_series:

Lenovo ThinkPad X1 Carbon (10th-generation)
*******************************************

The 10th-generation ThinkPad X1 Carbon **with a 12th-generation Intel Core processor** is a recommended option for the SecureDrop Workstation beginning with Qubes 4.1. If you plan to use it, you will want to ensure the BIOS is up-to date by following these instructions: :ref:`general_BIOS_update`.

You'll need to have a USB-to-Ethernet adapter on hand in order to :ref:`apply Qubes updates <apply_dom0_updates>`, which will enable Wi-Fi and fix glitchy video rendering and cursor performance.

.. _thinkpad_t_series:

Lenovo ThinkPad T14 (2nd-generation)
************************************

The 2nd-generation ThinkPad T14 **with an 11th-generation Intel Core processor** is a recommended option for the SecureDrop Workstation beginning with Qubes 4.1. If you plan to use it, you will want to ensure the BIOS is up-to date by following these instructions: :ref:`general_BIOS_update`.

The Ethernet and Wi-Fi controllers may not work without one-time manual configuration, as documented in the following sections.

Ethernet controller
^^^^^^^^^^^^^^^^^^^
After Qubes starts for the first time, when ``sys-net`` fails to start, follow the troubleshooting instructions for :ref:`reset_pci`, but only for the ``dom0:00_1f.6`` Ethernet device.

The Qubes Hardware Compatibility List (HCL)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The `Qubes Hardware Compatibility List (HCL) <https://www.qubes-os.org/hcl/>`_
is a community-maintained list of hardware that has been tested by Qubes users.
It consists of individual reports generated and submitted by Qubes users across
the world. Anyone can attempt to install Qubes on their computer, then report
back on whether or not it can be installed, if there are any issues, and overall,
what the experience is like.

There are some benefits to this list:

* A much wider selection of hardware is tested, because anyone can contribute to the list
* There are sometimes multiple reports for a particular system, which lets you compare and feel confident the results are consistent
* It tells you exactly what is and isn't working within the system, so you can decide if a device you own will function well enough to suit your needs
* Devices get tested across many different configurations and Qubes versions

However, there are some things to consider:

* Reports are not verified for their accuracy by either the Qubes team or Freedom of the Press Foundation
* Reports correspond to a specific Qubes OS version, and may not reflect breaking changes or expanded hardware support in the most recent Qubes OS version
* It's important that you update the BIOS of your laptop prior to installing SecureDrop Workstation: for more details see :ref:`general_BIOS_update`

For the best experience, we recommend choosing a Qubes-certified laptop, or a
laptop that we have directly tested (in that order); however, if none of those
suit your needs, or if you want to see if your existing hardware might be
Qubes compatible, the HCL is a good choice.

Choosing a printer
------------------

There are several requirements for a printer to be compatible with SecureDrop Workstation. Your printer should:

1. Support **driverless printing** standards
2. Have a **USB port**
3. Be offline, or at least have **no WiFi**

These requirements are expanded below.

Driverless
~~~~~~~~~~

SecureDrop Workstation implements driverless IPP printing to support a large selection of modern printers. Compatible printers can be easily identified by their support for the Apple AirPrint or Moipra standards:

.. figure:: images/airprint.jpg

.. figure:: images/moipra.jpg

You may consult Apple's `list of printers that support AirPrint <https://support.apple.com/en-us/HT201311#printers>`_, Moipra's `list of certified products <https://mopria.org/certified-products>`_, or OpenPrinting's `list of printers supporting driverless printing <https://openprinting.github.io/printers/>`_.

USB
~~~

SecureDrop Workstation only supports printing over USB, so ensure the printer you select has a **USB port**.

.. note::
  In rare cases, an AirPrint or Moipra-compatible printer with a USB port may not actually support IPP-over-USB, which is required for SecureDrop to use the printer. Check with the manufacturer if in doubt. 

Offline
~~~~~~~

To maintain the isolation of SecureDrop Workstation, it is essential that your printer not be shared with other computers and networks. 

* Select a compatible printer with **no WiFi**. A printer that connects with USB only is best if you can find one, but compatible USB printers lacking *both* Ethernet and WiFi are rare. 
* In the case of a printer with Ethernet and/or WiFi, **keep the printer offline** and **disabling WiFi** (if present).
* Use this printer exclusively with SecureDrop Workstation and do not connect it directly to other computers.
