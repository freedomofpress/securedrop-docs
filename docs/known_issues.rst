Limitations and known issues
============================

Reporting issues
----------------

Please report sensitive issues that are specific to your instance
via Signal or another secure method. 

Bugs and other issues that are not specific to your instance can be reported
via GitHub using the following links:

 - `SecureDrop Workstation issues <https://github.com/freedomofpress/securedrop-workstation/issues>`_ - issues related to the Qubes environment and workstation provisioning.
 - `SecureDrop App issues <https://github.com/freedomofpress/securedrop-client/issues>`_ - issues related to the *SecureDrop App*.
 
If you encounter a security-related issue, please see
`SECURITY.md <https://github.com/freedomofpress/securedrop-workstation/blob/main/SECURITY.md>`_ 
for instructions on how to privately report it.

Current known issues
--------------------

- Updates are slow due to the number of VMs involved. We have made improvements to the performance and reliability
  of the updater, and this work will continue.
- Printing different file types is not as reliable yet as under Tails. 
- Printing of individual files inside an archived submission is not yet supported.
- Currently, only app-based two-factor authentication (TOTP) is supported.
- The SecureDrop App does not currently handle files that are "double-encrypted"
  (when a source pre-encrypts a submission locally before uploading it to SecureDrop).
  Until this is fully supported, we suggest using the Tails-based *Secure Viewing
  Station* for pre-encrypted submissions.
- There are a limited number of file types that can be viewed on
  SecureDrop Workstation. Some file types (such as `.eml`) are not
  yet supported for viewing, and must be exported via USB, and/or viewed using
  the Tails-based *Secure Viewing Station*. :doc:`Broader file type support is planned <supported_filetypes>`.
- If the *Submission Key* for your SecureDrop server was rotated in the past,
  you must manually re-add the old key to your vault VM (`sd-gpg`) in order to
  view old submissions in SecureDrop Client. Contact Support for assistance.
- We do not support uninstalling SecureDrop Workstation without wiping all of
  Qubes OS. There is an ``--uninstall`` option for ``sdw-admin``, but it is not
  officially supported and will leave behind sensitive material in
  ``/usr/share/securedrop-workstation-dom0-config`` in ``dom0``. If you need to decomission
  a SecureDrop Workstation, please contact us for assistance.
