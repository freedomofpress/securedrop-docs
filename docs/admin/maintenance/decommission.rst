Decommission SecureDrop
=======================

Protecting, moving, or taking down your SecureDrop instance
-----------------------------------------------------------

If the location hosting your SecureDrop Servers is going to be empty for extended periods of time, you should take steps to ensure the security of your Servers and associated hardware:

1. Ensure that the room where the Servers are installed is locked by default, and that only authorized personnel have access. If possible, have access logged.
2. If the server room is covered by CCTV, verify that the footage will be monitored or reviewed periodically.
3. Ask to have adjacent corridors included in any regular security patrols.
4. Ask Journalists to delete unneeded Source accounts and conversations, to reduce the impact if the Servers are compromised (this is good general practice in any case).
5. If your SecureDrop instance is set up to allow SSH-over-LAN admin access, consider switching it to SSH-over-Tor access instead. To do so, you will need to update the server configuration using the ``sd-admin`` qube.

In some cases, if you are not able to ensure the security of your instance during periods of prolonged absence, it may be better to relocate it, or in extreme circumstances, temporarily take it down. If you decide to take down your SecureDrop instance, we recommend the following steps:

1. Consult with Journalists using the system, to ensure that any active Sources are aware of the situation, and that source conversations can either be paused or continued via other means.
2. Update your SecureDrop Landing Page (typically a “send us tips” page, or a page linked from there) to let prospective Sources know that the outage is coming, and optionally to redirect them to other contact methods, such as a shared Signal tipline.
3. :doc:`Back up your Servers <../maintenance/backup_and_restore>`.
4. Power down the Servers, and remove them and the network firewall from the server room. Store the equipment securely offsite.

.. warning:: By default the SecureDrop Servers are not set up with full disk encryption enabled, to allow for hands-off reboots. This means that it is crucial that they be kept secure. If the Servers are lost or stolen, an adversary would gain access to all encrypted files and messages sent by Sources that have not been deleted. While they would not be able to decrypt them, this would still provide valuable metadata about source conversations.

In most cases, restoring the instance, whether in their original hosting location or elsewhere, is a matter of reconnecting the Servers to the firewall, attaching a WAN connection that allows unfiltered access to Tor to the firewall WAN port, and powering everything on.

Permanently decommissioning SecureDrop
--------------------------------------

The following steps will guide you through the decommissioning of your SecureDrop instance.

#. Put a notice in advance on your Landing Page to inform sources that your instance will soon be retired. You may want to direct them to other secure methods of contacting you.
#. Locate and create an inventory of all your hardware. 

   - All Admin and Journalist Workstations 
   - Export Devices (USB flash drives, optical drives, or external drives) 
   - Backup USB flash drives/other storage media 
   - Servers 
   - Firewall

   You may also want to inventory credentials, such as the email address or alias and PGP key used for receiving OSSEC alerts, in order to retire them.

#. Optional: Save a backup. 
   
   If you want to save a backup of the Application Server (for example, to reinstall SecureDrop in the future using the same onion address), follow our :doc:`backup guidelines <backup_and_restore>`. Once the backup has been created, you can move it onto an encrypted drive, such as a LUKS-encrypted USB flash drive. You will also require a backup of the Submission Private Key found on the Journalist Workstation.

   If you do not require a server backup, you may choose to export specific submitted files or conversation transcripts, and store them in a secure manner (such as on an encrypted USB flash drive). 
#. Optional: Delete data on the Server.

   Log into the SecureDrop Inbox and delete all sources to take advantage of SecureDrop's secure deletion properties. Note that depending on the number of sources on your Server, it may take anywhere from several minutes to an hour or more for everything to be completely deleted from the Server.

   You can either leave the Server ample time to complete this operation, or monitor the progress by SSHing to the Application Server and running

   .. code:: sh

      sudo journalctl -f

   You will see repeated log lines that contain the following:

   .. code:: sh
      :class: no-copybutton

      [Timestamp] app python [...] INFO Clearing shredder
      [Timestamp] app python [...] INFO Files to delete: <number>

   When the number of files to delete reaches 0, the process is complete.
#. Disconnect the firewall and the Servers from the internet.
      Be sure to inform your network administrator of any changes to devices on your network.
#. Wipe and destroy the USB flash drives.

   .. include:: /includes/destroy_usb.txt

#. Wipe and destroy the storage drives on the Servers.

   Messages and files sent via SecureDrop are stored GPG-encrypted on the Application Server. Unless your SecureDrop Submission Key is compromised (or a significant vulnerability in GPG is discovered), access to the Servers does not guarantee access to the files and messages you have received.

   That said, there may still be some sensitive information on the Servers, including system logs and the SecureDrop database, which would yield information on the number of messages and replies stored on the Server. This risk is partially mitigated by securely deleting data from the Server, as described in a previous step; however, physically destroying or encrypting the storage drives on the Servers are the best ways to ensure that data on the drives cannot be recovered.

   Physically destroying SSD drives is not as straightforward as destroying older hard drives, but drives can be pulverized, shredded, or incinerated, as long as the flash chips are destroyed. 

   If those options are not available, you may choose instead to write over the information on the existing drives. Most SSDs support ATA Secure Erase, although the implementation of this feature varies by manufacturer.

   Another option is to re-install a clean version of Ubuntu Server with full disk encryption enabled. During the disk-partitioning portion of the installation wizard, select **Guided - use entire disk and set up encrypted LVM**. You will need to reclaim the space that was taken up by your previous installation, so whenever prompted to unmount and reclaim unused partitions, select "yes."
#. Destroy Export media, if applicable.
#. Optional: Factory-reset the firewall.
#. Update your Landing Page (tips page) to reflect the fact that your organization no longer has SecureDrop.
#. Notify the SecureDrop Support team that your instance is no longer active.

   If you have any questions about the decommissioning process, or about other secure communications options, please feel free to contact us at securedrop@freedom.press (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__) or via the `support portal <https://support.freedom.press/>`__.
