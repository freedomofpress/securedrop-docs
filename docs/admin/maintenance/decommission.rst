Decommission SecureDrop
=======================

Protecting, Moving, or Taking Down Your SecureDrop Instance
-----------------------------------------------------------

If the location hosting your SecureDrop servers is going to be empty for
extended periods of time, you should take steps to ensure the security of your
servers and associated hardware:

1. Ensure that the room where the servers are installed is locked by default,
   and that only authorized personnel have access. If possible, have access
   logged.
2. If the server room is covered by CCTV, verify that the footage will be
   monitored or reviewed periodically.
3. Ask to have adjacent corridors included in any regular security patrols.
4. Ask journalists to purge old submissions, to reduce the impact if the 
   servers are compromised (this is good general practice in any case).
5. If your SecureDrop instance is set up to allow SSH-over-LAN admin access,
   consider switching it to SSH-over-Tor access instead. To do so, you will
   need to update the server configuration using the Admin VM.

In some cases, if you are not able to ensure the security of your instance
during periods of prolonged absence, it may be better to relocate it, or in
extreme circumstances, temporarily take it down. If you decide to take down
your SecureDrop instance, we recommend the following steps:

1. Consult with journalists using the system, to ensure that any active
   sources are aware of the situation, and that source conversations can
   either be paused or continued via other means.
2. Update your SecureDrop landing page (typically a “send us tips” page,
   or a page linked from there) to let prospective sources know that the
   outage is coming, and optionally to redirect them to other contact
   methods, such as a shared Signal tipline.
3. :doc:`Back up your servers <../maintenance/backup_and_restore>`.
4. Power down the servers, and remove them and the network firewall from the
   server room. Store the equipment securely offsite.

.. warning:: By default the SecureDrop servers are not set up with full disk
             encryption enabled, to allow for hands-off reboots. This means
             that it is crucial that they be kept secure. If the servers are
             lost or stolen, an adversary would gain access to all encrypted
             submissions and messages. While they would not be able to decrypt
             them, this would still provide valuable metadata about source
             conversations.

In most cases, restoring the instance, whether in their original hosting
location or elsewhere, is a matter of reconnecting the servers to the
firewall, attaching a WAN connection that allows unfiltered access to Tor to
the firewall WAN port, and powering everything on.

Permanently Decommissioning SecureDrop
--------------------------------------

The following steps will guide you through the decommissioning of your
SecureDrop instance.

#. **Put a notice in advance on your landing page to inform sources that your
   instance will soon be retired.**
   You may want to direct them to other secure methods of contacting you.
#. **Locate and create an inventory of all your hardware.**
     - *SecureDrop Workstation* laptops
     - *Export Devices* (USBs, optical drives, or external drives)
     - Backup USBs/other storage media
     - Servers
     - Firewall

   You may also want to inventory credentials, such as the email address or
   alias and PGP key used for receiving OSSEC alerts, in order to retire them.

#. **Optional: Save a backup.**
   If you want to save a backup of the *Application Server* (for example, to reinstall SecureDrop in the future using the same `.onion` address), follow
   our :doc:`backup guidelines <backup_and_restore>`. Once the backup has been
   created, you can move it onto an encrypted device, such as a LUKS-encrypted 
   drive. You will also require a backup of the *Submission Key* found on the
   *SecureDrop Workstation*.

   If you do not require a server backup, you may choose to download specific
   submissions, and store them in a secure manner (such as on an encrypted
   drive). 
#. **Optional: Delete submissions on the server.**
   Log into the *SecureDrop Workstation* and delete all sources to take advantage
   of SecureDrop's secure deletion properties. Note that depending on the
   number of sources on your server, it may take anywhere from several minutes
   to an hour or more for the submissions to be completely deleted from the
   server.

   You can either leave the server ample time to complete this operation, or
   monitor the progress by SSHing to the Application server and running

   .. code:: sh

      sudo journalctl -f

   You will see repeated log lines that contain the following:

   .. code:: sh

      [Timestamp] app python [...] INFO Clearing shredder
      [Timestamp] app python [...] INFO Files to delete: <number>

   When the number of files to delete reaches 0, the process is complete.
#. **Disconnect the firewall and the servers from the internet.**
   Be sure to inform your network administrator of any changes to devices on
   your network.
#. **Wipe and destroy the USB drives.**
   Because the USB drives used for SecureDrop are all LUKS-encrypted,
   reformatting the USB drives (in particular, overwriting a portion of internal
   storage called the **LUKS header**) should be sufficient to make any existing
   data on those drives unrecoverable.

   For example, you could use your *Template Tails USB* to launch Gnome Disks,
   insert and identify the USB drive you are trying to erase, and reformat this
   drive with a new, LUKS-encrypted partition, erasing the existing partition
   data.

   .. caution:: Be **very** sure you are reformatting the right drive.
      You may want to use the Secure Viewing Station laptop for this procedure
      to reduce the risk of accidentally erasing a drive on your regular-use
      machine.

   You may also choose to destroy the drives by physical means, such as using a
   hammer or purpose-built shredder to pulverize or destroy the drive.
#. **Wipe and destroy the storage drives on the servers.**
   SecureDrop submissions are stored GPG-encrypted on the *Application Server*.
   Unless your SecureDrop *Submission Key* is compromised (or a significant
   vulnerability in GPG is discovered), access to the servers does not guarantee
   access to the submissions and messages you have received.

   That said, there may still be some sensitive information on the servers,
   including system logs and the SecureDrop database, which would yield
   information on the number of submissions and replies stored on the server.
   This risk is partially mitigated by securely deleting submissions from the
   server, as described in a previous step; however, physically destroying or
   encrypting the storage drives on the servers are the best ways to ensure
   that data on the drives cannot be recovered.

   Physically destroying SSD drives is not as straightforward as destroying
   older hard drives, but drives can be pulverized, shredded, or incinerated,
   as long as the flash chips are destroyed.

   If those options are not available, you may choose instead to write over the
   information on the existing drives. Most SSDs support ATA Secure Erase,
   although the implementation of this feature varies by manufacturer.

   Another option is to re-install a clean version of Ubuntu server with full-
   disk encryption enabled. During the disk-partitioning portion of the
   installation wizard, select *Guided - use entire disk and set up encrypted
   LVM*. You will need to reclaim the space that was taken up by your previous
   installation, so whenever prompted to unmount and reclaim unused partitions,
   select "yes."
#. **Destroy Export media, if applicable.**
#. **Optional: Factory-reset the firewall.**
#. **Update your Landing Page (tips page) to reflect the fact that your organization no longer has SecureDrop.**
#. **Notify the SecureDrop Support team that your instance is no longer active.**
   If you have any questions about the decommissioning process, or about other
   secure communications options, please feel free to contact us at
   securedrop@freedom.press
   (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__)
   or via the `support portal <https://support.freedom.press/>`__.
   

