Install Journalist Workstation
==============================

You have created your first :ref:`Admin Workstation<glossary_admin_workstation>` and used it to install and configure your SecureDrop Servers. Now, it is time to create the first :ref:`Journalist Workstation<glossary_journalist_workstation>`. It is important that this first Journalist Workstation is same the laptop where your :ref:`Submission Key<glossary_submission_key>` was :doc:`generated</admin/installation/generate_submission_key>`. Some of the following steps will vary depending on your situation:

- If you :doc:`installed Qubes OS</admin/installation/install_qubes>` on only one laptop, intending to create a :ref:`Combined Workstation<glossary_combined_workstation>`, then you will perform the indicated steps (one laptop install) on that single laptop. 

- If instead you installed Qubes OS on two laptops, intending to create separate Admin and Journalist Workstations, then you should perform the indicated steps (two laptops install) on the new Journalist Workstation, *not* your first Admin Workstation. 

When you installed the SecureDrop Servers from your Admin Workstation, the onion addresses of your SecureDrop Source Interface and Admin Interface and the associated :ref:`Onion Service<glossary_onion_service>` private key were created. You need to import the ``config.json`` file containing these addresses and key onto the Journalist Workstation.

Importing to ``dom0`` on a Combined Workstation (one laptop install)
--------------------------------------------------------------------

If you have a Combined Workstation, you simply need to copy the ``config.json`` file from ``sd-admin`` to the correct location in ``dom0``.

In a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), run the following command:

.. code-block:: sh

  qvm-run --pass-io sd-admin 'cat /home/user/.config/securedrop-admin/config.json' > ~/.config/securedrop-manage/config.json


Importing from the Admin Workstation (two laptops install)
----------------------------------------------------------

If your Admin Workstation is a separate laptop, then you will need to transfer the ``config.json`` file using a LUKS-encrypted USB flash drive.

Create LUKS-encrypted transfer drive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Boot the Admin Workstation and log in to Qubes.
2. Insert the USB flash drive into the Admin Workstation.
3. Open the Disks utility in ``sd-admin``: (|qubes_menu| **▸ sd-admin ▸ Disks**).
4. Open the Qubes Devices Widget and find your newly inserted USB flash drive under **USB Storage** at the bottom of the list (indicated by the word **new** in blue). Attach your USB flash drive to the ``sd-admin`` qube:

.. TODO screenshot

5. The USB drive should appear in the list of devices in Disks, likely identified as a **Generic Flash Disk**. Select inter-qube.

.. TODO screenshot

6. Click the interlocking gear icon under the drive volumes schematic in the right-hand panel and choose **Format Partition...**.

7. In the Format Volume dialog, enter "Transfer" for **Volume Name:** and select **Type: Internal disk for use with Linux systems only (Ext4)**, with the **Password protect volume (LUKS)** option enabled.

.. TODO screenshot

8. Then, click **Next**. You will be prompted to set a password. This password should be strong - a 6-word passphrase is highly recommended. You can use use KeePassXC in the ``sd-admin-vault`` qube to generate one. You will need this password to unlock the USB flash drive in later steps.
9. Once the password is set, click **Format**, then when prompted, click **Format** again. The formatting process should take only a few seconds.

Export from the Admin Workstation to encrypted USB drive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Attach your newly created encrypted transfer drive to ``sd-admin-vault`` using the Devices Widget.
2. Open the File Manager in ``sd-admin``: (|qubes_menu| **▸ sd-admin ▸ File Manager**), and mount and unlock the drive.
3. Enter the path ``~/.config/securedrop-admin/`` into the location bar of the file manager to open the ``securdrop-admin`` config directory.

.. TODO screenshot

4. Drag the ``config.json`` file to the transfer drive to copy it.
5. Eject the USB flash drive and shut down the Admin Workstation.

Import onto the new Journalist Workstation from encrypted USB drive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Switch to the Journalist Workstation, boot it, and log in to Qubes.
2. Open the File Manager in ``vault``: (|qubes_menu| **▸ vault ▸ Thunar File Manager**)
3. Insert the transfer drive into the Journalist Workstation.
4. Open the Qubes Devices Widget and attach your transfer drive to the ``vault`` qube.
5. In the ``vault`` File Manager, mount and unlock the drive using the password you set earlier:

.. TODO screenshot

6. Open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**)and run the following command to copy the ``config.json`` file:

.. code-block:: sh

    qvm-run --pass-io vault 'cat /run/media/user/Transfer/config.json' > ~/.config/securedrop-manage/config.json

7. In the same ``dom0`` terminal, run the following command to validate that you imported the file successfully:

.. code-block:: sh
  
  securedrop-manage validate --target journalist

Securely erase transfer drive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The encrypted USB flash drive you used to transfer between the SecureDrop and Admin Workstations now contains sensitive credentials related to your SecureDrop. You must ensure it is securely erased. 

.. include:: /includes/destroy_usb.txt

.. _install_securedrop_workstation:

Install Journalist Workstation
------------------------------

Now that you have imported the Onion Service files, you are ready to install and configure SecureDrop Inbox. Perform this step on either the new Journalist Workstation (two laptops install) or the Combined Workstation (one laptop install).

These steps should be performed from a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**). 
 
Configure infinite scrollback for your terminal via **Edit ▸ Preferences ▸ General ▸ Unlimited scrollback**. This helps to ensure that you will be able to review any error output printed to the terminal during the installation.

When ready run the following command in the ``dom0`` terminal:

.. code-block:: sh

  securedrop-manage apply --target admin


.. TODO update command for Journalist Workstation

This command will take approximately 30-60 minutes and 4GB of bandwidth, as it sets up multiple qubes and installs supporting packages. When the command finishes, reboot the machine to complete the installation of SecureDrop Inbox and it's associated qubes and configuration.

.. _end_install_securedrop_workstation:

