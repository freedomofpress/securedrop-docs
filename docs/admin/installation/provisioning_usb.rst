Provisioning Export USB devices
===============================

SecureDrop Workstation supports the export of submissions from the SecureDrop App
to a LUKS- or VeraCrypt-encrypted USB *Export Device*.

Creating a LUKS-encrypted drive
-------------------------------

.. note:: LUKS-encrypted devices can only be used with Linux-based
  systems such as Tails. For compatibility with macOS and Windows systems, use VeraCrypt.

In order to provision a LUKS-encrypted *Export Device* for use with SecureDrop Workstation,
you will need a fresh USB stick and a Linux-based system. Tails is recommended -
if available, the *Secure Viewing Station* can be used, adding the extra benefit
of its airgap:

- First, boot into the *Secure Viewing Station*, without unlocking its
  persistent volume or setting an admin password.
- Next, open the Disks utility: **Applications ▸ Utilities ▸ Disks**.
- Connect the fresh USB stick and select it in the list in the left-hand panel.

.. warning:: The formatting operation will wipe any data on an existing partition.
  Make sure that you select the correct device!

- Click the interlocking gear icon under the drive volumes schematic in the
  right-hand panel and choose **Format Partition...**.
- Select the following options in the Format Volume dialog:

  - Volume Name: Transfer
  - Type: Ext4, with the "Password protect volume (LUKS)" option enabled

- Then, click **Next**. You will be prompted to set a password. This password
  should be strong - a 6-word `Diceware <https://en.wikipedia.org/wiki/Diceware>`_
  passphrase is highly recommended.
- Once the password is set, click **Format**, then when prompted, click **Format**
  again. The formatting process should take only a few seconds.
- Once formatting is complete, you will need to provide the *Export Device* and
  its decryption password to the SecureDrop Workstation users. Make sure that
  they store it and its password securely, as it will contain decrypted
  submissions.

Creating a VeraCrypt-encrypted drive
------------------------------------

.. Remove the following warning once securedrop-docs#599 and
   veracrypt/VeraCrypt#1422 are resolved.

.. warning::

   If you plan to use your *Export Device* with computers running macOS 15
   ("Sequoia") or later, you must also perform the VeraCrypt setup on that
   version of macOS.

- If it isn't already done, download and install the `VeraCrypt software <https://www.veracrypt.fr/en/Home.html>`_.
- Start VeraCrypt from your computer's application or software interface.
- Click **Create Volume**
- Select **Encrypt a non-system partition/drive** and click **Next**.
- Select **Standard VeraCrypt volume** and click **Next**
- Connect your fresh USB stick and click **Select Device...** to choose your USB.

  - You may see a warning that says "We strongly recommend that inexperienced
    users create a VeraCrypt file container on the selected device/partition,
    instead of attempting to encrypt the entire device/partition." We disagree with
    this recommendation, so click **Yes**.
  - Click **Next** to advance.

.. warning:: The formatting operation will wipe any data on an existing partition.
  Make sure that you select the correct device!

- You will be prompted to set a password. This password
  should be strong - a 6-word `Diceware <https://en.wikipedia.org/wiki/Diceware>`_
  passphrase is highly recommended.
- You will be asked if you need to store large files, select **No** and click **Next**.
- Select the following options in the Volume Format dialog:

  - Filesystem: exFAT
  - Quick Format: unselected
- Click **Next**. VeraCrypt will now collect entropy from your mouse movements.
  Randomly move your mouse cursor around the screen until the progress bar is filled up.
  Then click **Format**.

  - You will be reminded that all files on the device will be erased and lost and given
    a final confirmation to begin. Click **Yes**.
- Wait until VeraCrypt says "The VeraCrypt volume has been successfully created." Until
  this pops up, it may look like the program is frozen, but it's running in the background.
- Click **OK** and then **Exit** to finish formatting process.
- Once formatting is complete, you will need to provide the *Export Device* and
  its decryption password to the SecureDrop Workstation users. Make sure that
  they store it and its password securely, as it will contain decrypted
  submissions.
