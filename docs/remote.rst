Accessing SecureDrop Remotely
=============================

While it's necessary for SecureDrop servers to be hosted on-premise within your
organization, and for administrators to retain direct physical access to
troubleshoot any potential network-related issues that might arise, there are
methods available for both admins and journalists to access the system
remotely.

SSH Over Tor
^^^^^^^^^^^^
By default, SSH access to SecureDrop servers is routed through the Tor
network, allowing you to access the servers using an *Admin Workstation*
from anywhere in the world where you have a stable internet connection and
are able to access the Tor network.

To do so, simply open a Terminal from your *Admin Workstation* and run either
the ``ssh app`` or ``ssh mon`` command, depending on which server you are intending
to access.

This is useful for routine maintenance and log investigation tasks, although
direct physical access will still be necessary for network-related issues, in
situations where SSH access is not available.

For more details about the types of tasks that can be completed via SSH, you
can :ref:`review the SSH portion of our Admin Guide <server SSH access>`.

If you'd like to make adjustments to the SSH configuration, or disable SSH
access over Tor, you can do so by
:doc:`following the steps here <ssh_over_local_net>`.

In addition to remote SSH access, the web-based *Admin Interface* is also available
from an *Admin Workstation* from any location with a network connection and access
to the Tor network.


Remote *Secure Viewing Station*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Risk Mitigation for Remote *Secure Viewing Stations*
----------------------------------------------------

To allow uninterrupted access to SecureDrop for individual journalists,
it may be worthwhile to set up a Remote *Secure Viewing Station*.

This may be a good option for organizations with a distributed staff or a
strong work-from-home culture, although it's important to weigh the risks
and benefits of setting up remote access by adding additional *Secure Viewing
Stations* (SVS).

.. warning:: This increases the risk of the SVS—and its *Submission Key*—being
             compromised.

If you’re considering the use of a remote SVS, here are some steps you can
follow to minimize the associated risks:

1. Provide access to the smallest number of people that is reasonable to
   ensure sufficient coverage. Individuals with access to a *Secure Viewing
   Station* can triage submissions on behalf of other members of your team.
   This minimizes the risk that the *Submission Key* falls into the wrong
   hands.
2. Ensure that journalists have the necessary hardware off-site to access the
   Journalist Interface and to work with sensitive data. Discourage the use of
   personal hardware. Provide assistance to journalists to ensure the physical
   and digital security of sensitive devices and documents.
3. Provision a new *Secure Viewing Station* USB drive. This USB should be on the
   latest version of Tails, and should contain only the *Submission Key*. Keep
   an inventory of any provisioned SVS USBs for later decommissioning purposes.
   Please see below for a step-by-step guide.
4. Provide a secure communications method for SecureDrop users and
   administrators. The chosen procedure should provide end-to-end encryption
   and ideally guard against the threat of malware. Please see below for some
   considerations for sharing files securely.
5. Ensure the physical security of the SecureDrop servers and original SVS
   while your team works remotely. If the office will be completely unattended,
   consider storing the original SVS USB with senior staff or legal counsel.
6. Prepare to respond to the loss or compromise of the remote SVS. At a
   minimum, this would involve :ref:`rotating the Submission Key
   <rotate_submission_key>`, which would prevent an adversary from
   decrypting future submissions using the compromised key.

Necessary Equipment
-------------------

In order to create a new SVS for remote use, you will need the following:

* An air-gapped computer similar to the computer being used for your current
  *Secure Viewing Station*. This workstation will be used for provisioning the
  new SVS USB, and will also be used as part of the remote SVS system.

.. warning:: Any computer used as an SVS must be air-gapped by removing or
             physically disabling all networking hardware (including
             Bluetooth), and by removing or physically disabling speakers
             and microphones. A computer used as an SVS should never be used
             for any other purpose.

* An up-to-date Tails USB (the primary Tails USB). You do not need to set up
  persistent storage on this device, as it will not be used during the SVS
  setup process.
* The current SVS USB, and its persistent volume’s passphrase
* A USB key to act as the new SVS USB

Creating New SVS USB Drives
---------------------------

To create the new SVS USB:

1. Boot into Tails using the primary Tails USB on the air-gapped workstation.
   When you see the welcome dialog, you can proceed without enabling persistence
   or setting an admin password.
2. Install Tails on the new SVS USB, following the instructions
   `here. <https://tails.boum.org/install/clone/pc/index.en.html>`_
3. Boot into the new SVS USB and enable persistence with a strong passphrase
   (a 6-word Diceware passphrase is recommended). In the Persistent volume
   configuration wizard, be sure to enable persistence for “GnuPG - GnuPG
   Keyrings and configuration”.
4. Temporarily store the persistent volume passphrase in your password manager.
   You should delete it once you have given the USB and passphrase to the
   journalist who will be using them.
5. Reboot the new SVS USB with persistence enabled and an administration
   password set.
6. Plug the current SVS USB into a free port on the workstation.
7. Mount its persistent volume by browsing to Places > Computer, clicking
   the USB disk in the left-hand column, and entering its persistent volume’s
   passphrase.
8. Open a terminal via Applications > Favorites > Terminal
9. Copy the current SVS’s GPG keychain (which includes the *Submission Key*) to
   the new SVS USB using the following command (without linebreaks):

   .. code:: sh

      sudo bash -c "rsync -a --no-specials --no-devices \
      /media/amnesia/TailsData/gnupg/ \
      /live/persistence/TailsData_unlocked/gnupg/"


10. Eject and remove the current SVS USB.
11. Verify that the *Submission Key* is present with the correct fingerprint on
    the new SVS USB via Applications > Utilities > Passwords and Keys.

The new SVS should now be ready for use. The journalist that will be checking
submissions will need the new SVS USB, its Persistent Volume passphrase, and
the air-gapped computer—they should be handed over in a secure manner. They
should test the regular decryption workflow using the new SVS as part of the
handover process.

Sharing Files and Messages with Other Journalists
-------------------------------------------------

If you receive documents via SecureDrop, if possible, avoid sharing or opening
these files electronically outside of the *Secure Viewing Station*. Opening
documents on your daily-use computer exposes you to the risk that embedded
malware and tracking code could exfiltrate information or de-anonymize your
sources.

If printing is an option, printing and re-scanning a document is the most
effective mitigation against many of these risks.

If you want to transfer files electronically, you can take steps on the
*Secure Viewing Station* to mitigate against these risks (e.g.,
:ref:`stripping metadata from files <removing_metadata>` and converting
them to other formats). If you decide to copy files off the *Secure Viewing
Station*, we recommend using an encrypted Export Device, as
:ref:`described here <create_usb_transfer_device>`.

If you want to transfer files to another journalist using your day-to-day work
computer, we strongly recommend using end-to-end encrypted communication tools
like `Signal <https://signal.org/>`_ and `Wire <https://app.wire.com/>`_, both
of which have desktop apps, instead of more common tools like Slack or
unencrypted email.

For security reasons, we advise against taking photos of documents using your
phone, but if you decide to do so, please `see our guide to taking private
photos with Signal 
<https://freedom.press/training/taking-private-photos-signal/>`_.


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
   need to :doc:`update the server configuration using the Admin Workstation <ssh_over_local_net>`.

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
3. :doc:`Back up your servers <backup_and_restore>`  and
   :doc:`your workstation USBs <backup_workstations>`.
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