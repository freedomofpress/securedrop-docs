Working with Documents
======================

This section describes how to handle unusual file formats,
safely research submissions, remove metadata, and mitigate risks from
submitted malware.

.. tip::

   This is only a very limited introduction. Freedom of the Press Foundation
   publishes and maintains `digital security guides for journalists <https://freedom.press/training/>`__,
   many of which relate to these topics, and offers `digital security training <https://freedom.press/training/request-training/>`__
   for news organization staff.

Handling File Formats
~~~~~~~~~~~~~~~~~~~~~

SecureDrop accepts submissions of any file type.


Researching Submissions
~~~~~~~~~~~~~~~~~~~~~~~

Journalists should take care to research submissions using the Tor
Browser.

.. _removing_metadata:

Removing Metadata
~~~~~~~~~~~~~~~~~

.. tip:: For detailed information about removing metadata from documents, check
   out this in-depth guide to removing metadata.
   
.. _malware_risks:

Risks From Malware
~~~~~~~~~~~~~~~~~~
SecureDrop does not scan for or remove malware in submissions you receive. There
are important steps you can take to protect yourself:

1. **Keep your SecureDrop Workstation up-to-date.**

2. **Print documents from the SecureDrop Workstation instead of exporting them
   digitally, whenever possible.**

   Printing documents prevents the proliferation of malware to your everyday
   workstation, and eliminates most categories of embedded metadata. Note that
   printing a document may still preserve watermarks, printer codes,
   steganographically encoded data, or other information not visible to the
   naked eye.
   |br| |br|

3. **Consult with your administrator or your digital security staff before
   copying files digitally.**

   If you must copy a file in digital form (because of its format, the volume
   of information, or for other reasons), we recommend taking the time to
   consult with technical experts within the organization.

   .. tip::

      Converting files to simpler formats (e.g., PDF to PNG) can help reduce the
      risk of malware. Tails provides both graphical and command-line utilities
      that can be used for this purpose.

4. **Never scan QR codes embedded in documents using a network-connected
   device.**

   `QR codes can contain malicious links`_ that your device will automatically
   visit. This can alert third-parties to your actions, reveal the identities
   of your sources, and breach the air gap that is in place with the
   *Secure Viewing Station*. 

   In general, be careful when opening any links provided in a SecureDrop
   submission. If you are unsure if a link is safe to click, you should
   consult internally, or contact Freedom of the Press Foundation for
   assistance.
   |br| |br|

5. **Don't photograph submissions using your smartphone, and be careful with all
   digital photography**.

   Many smartphones are configured to back up photographs to cloud services,
   immediately or intermittently; newer digital cameras have similar
   functionality. Not all backup settings may be visible to you.

   Any digital photograph will include certain metadata by default, which may
   reveal sensitive information about your SecureDrop usage patterns
   (potentially including GPS coordinates) to anyone who gains access
   to the file.

.. warning::

   If you have not memorized the passphrases to unlock the USB drives
   for the *Secure Viewing Station* or the *Transfer Device*, you may need
   to access a password manager on your phone or laptop to do so. We
   recommend switching any required electronic devices into airplane mode,
   and securely storing any devices you do not need outside the environment
   in which you access the *Secure Viewing Station*. This further mitigates
   the risk of accidentally compromising the air-gap.

Fully mitigating the risks of malware received via SecureDrop is beyond the
scope of this documentation. If you have questions, you can contact us at
securedrop@freedom.press (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__).
Please do **NOT** disclose details about the contents of any submission you have received.

.. _`QR codes can contain malicious links`: https://securedrop.org/news/security-advisory-do-not-scan-qr-codes-submitted-through-securedrop-connected-devices

Moving Documents to Your Everyday Workstation
---------------------------------------------

.. important::

   As noted above, SecureDrop does not scan for or remove malware. If the file
   you received contains malware targeting the operating system and applications
   running on your everyday workstation, copying it in its original form carries
   the risk of spreading malware to that computer. Make sure you understand the
   risks, and consider other methods to export the document (e.g., print).

If you must copy a file from your *SecureDrop Workstation* to your everyday
workstation in digital form, our 
:doc:`recommendation <../admin/installation/set_up_transfer_and_export_device>`
is that journalists are provided with an *Export Device*, typically a USB drive,
which is encrypted using `VeraCrypt <https://www.veracrypt.fr/en/Home.html>`__.
These instructions assume that you are following the recommended workflow.
If you are unsure, ask your administrator.

.. note:

Decrypting and Preparing to Publish
-----------------------------------

.. note::

   To decrypt a VeraCrypt drive on a Windows or Mac workstation, you need
   to have the *VeraCrypt* software installed. If you are unsure if you have the
   software installed or how to use it, ask your administrator, or see
   the `Freedom of the Press Foundation guide <https://freedom.press/training/encryption-toolkit-media-makers/veracrypt-guide/>`__
   for working with VeraCrypt.

To access the *Export Device* on your everyday workstation, follow these steps:

1. If your *Export Device* has a physical write protection switch, make sure it
   is in the *locked* position.
2. Plug the *Export Device* into your everyday workstation.
3. Launch the *VeraCrypt* application.
4. Click **Select Device** and select the *Export Device*, then click **OK**.
5. Click **Mount**.
6. Enter the passphrase for your *Export Device*. You should find this in your
   own personal password manager.
7. Open the *Export Device* in your operating system's file manager, and copy
   the contents of interest to your everyday workstation.

As a security precaution, we recommend deleting the files on the *Export
Device* after each copy operation. If you are using write protection, you have to perform this step on the *Secure Viewing Station* to get the security benefits of write protection.

When you are done, switch back to the *VeraCrypt* window, and click **Dismount**.

You are now ready to write articles and blog posts, edit video and
audio, and begin publishing important, high-impact work!

.. tip:: Check out our SecureDrop :doc:`Promotion Guide
         <../admin/deployment/getting_the_most_out_of_securedrop>` to read
         about encouraging sources to use SecureDrop.

Deleting submissions and source accounts
----------------------------------------

As part of routine SecureDrop usage, we recommend that you establish data retention
practices consistent with your organization's threat model, data lifecycle and data
retention policies. Regularly deleting submissions and source accounts can
mitigate risks in the event that your SecureDrop servers or a source's account
details are compromised.

If you delete messages and files for a source, the source will continue to appear
in the list of sources in the *SecureDrop App*, and they will still be able
to log into the *Source Interface* using their codename. Consider using this
option as part of regular deletion of reviewed submissions, especially if you
are not sure that all communication with the source has concluded.

.. note::

   If you delete all messages and files, that includes all replies you have sent
   to the source, even if the source has not seen them yet. You will still be
   able to send new replies.

If you delete the entire source account, the source will not be able to log
in again using their codename, and all information about them will be
destroyed. Consider using this option if it is clear that all communication
with the source has concluded, or if the source has requested that all information
about them and their submissions should be removed.

You can more selectively delete source submissions and journalist replies by
clicking the source's two-word designation in the list of all sources.


.. |br| raw:: html

    <br>
