Install SecureDrop Workstation
==============================

You have created the Admin Workstation and used it to install the SecureDrop servers. Now, you may set up the SecureDrop Workstation. 

If you have opted to perform your initial installation with *two* laptops (distinct Admin and SecureDrop Workstations, rather than a combined laptop for both), then make sure that you are performing these steps on the same laptop where you :doc:`generated</admin/installation/generate_submission_key>` your :ref:`Submission Key<glossary_submission_key>` earlier.

Import Onion Service addresses and auth token
---------------------------------------------

When you installed the SecureDrop servers from your Admin Workstation, the onion addresses of your SecureDrop Source and Admin Interfaces and the associated :ref:`Onion Service<glossary_onion_service>` authentication token were created. You need to import the ``config.json`` file containing these addresses and token onto the SecureDrop Workstation.

Importing to ``dom0`` on a combined laptop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have a combined Admin + SecureDrop Workstation on the same laptop, you simply need to copy the ``config.json`` file containing the onion addresses and authentication token from ``sd-admin`` to the correct location in ``dom0``.

In a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), run the following command:

.. code-block:: sh

  qvm-run --pass-io sd-admin 'cat /home/user/.config/securedrop-admin/config.json' > ~/.config/securedrop-manage/config.json


Importing from an Admin Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your Admin Workstation is a separate laptop, then you will need to transfer the ``config.json`` file using a LUKS-encrypted USB flash drive.

Create LUKS-encrypted transfer drive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Boot the Admin Workstation and log in to Qubes.
#. Insert the USB flash drive into the Admin Workstation.
#. Open the Disks utility in ``sd-admin``: (|qubes_menu| **▸ sd-admin ▸ Disks**).
#. Open the Qubes Devices Widget and find your newly inserted USB flash drive under **USB Storage** at the bottom of the list (indicated by the word **new** in blue). Attach your USB flash drive to the ``sd-admin`` qube:

.. TODO screenshot

#. The USB drive should appear in the list of devices in Disks, likely identified as a **Generic Flash Disk**. Select inter-qube.

.. TODO screenshot

#. Click the interlocking gear icon under the drive volumes schematic in the right-hand panel and choose **Format Partition...**.

#. In the Format Volume dialog, enter "Transfer" for **Volume Name:** and select **Type: Internal disk for use with Linux systems only (Ext4)**, with the **Password protect volume (LUKS)** option enabled.

.. TODO screenshot

#. Then, click **Next**. You will be prompted to set a password. This password should be strong - a 6-word passphrase is highly recommended. You can use use KeePassXC in the ``sd-admin-vault`` qube to generate one. You will need this password to unlock the USB flash drive in later steps.
#. Once the password is set, click **Format**, then when prompted, click **Format** again. The formatting process should take only a few seconds.

Export from an Admin Workstation to encrypted USB drive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Attach your newly created encrypted transfer drive to ``sd-admin-vault`` using the Devices Widget.
#. Open the File Manager in ``sd-admin``: (|qubes_menu| **▸ sd-admin ▸ File Manager**), and mount and unlock the drive.
#. Enter the path ``~/.config/securedrop-admin/`` into the location bar of the file manager to open the ``securdrop-admin`` config directory.

.. TODO screenshot

#. Drag the ``config.json`` file to the transfer drive to copy it.
#. Eject the USB flash drive and shut down the Admin Workstation.

Import onto the SecureDrop Workstation from encrypted USB drive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Switch to the SecureDrop Workstation, boot it, and log in to Qubes.
#. Open the File Manager in ``vault``: (|qubes_menu| **▸ vault ▸ Thunar File Manager**)
#. Insert the transfer drive into the SecureDrop Workstation.
#. Open the Qubes Devices Widget and attach your transfer drive to the ``vault`` qube.
#. In the ``vault`` File Manager, mount and unlock the drive using the password you set earlier:

.. TODO screenshot

#. Open a `dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**)and run the following command to copy the ``config.json`` file:

.. code-block:: sh

    qvm-run --pass-io vault 'cat /run/media/user/Transfer/config.json' > ~/.config/securedrop-manage/config.json

#. In the same ``dom0`` terminal, run the following command to validate that you imported the file successfully:

.. code-block:: sh
  
  securedrop-manage --validate --target journalist

Securely erase transfer drive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The encrypted USB flash drive you used to transfer between the SecureDrop and Admin Workstations now contains sensitive credentials related to your SecureDrop. You must ensure it is securely erased. 

.. include:: /includes/destroy_usb.txt

.. _install_securedrop_workstation:

Install SecureDrop Workstation
------------------------------

These steps should be performed from a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**). 
 
Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.

When ready run the following command in the ``dom0`` terminal:

.. code-block:: sh

  securedrop-manage --apply target admin


.. TODO update command for SecureDrop Workstation

This command will take a considerable amount of time and approximately 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation of SecureDrop Inbox and it's associated qubes and configuration.

.. _end_install_securedrop_workstation:

