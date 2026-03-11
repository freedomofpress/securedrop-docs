.. _keepassxc_setup:

Using the KeePassXC Password Manager
====================================

Qubes OS comes with the KeePassXC password manager preinstalled and SecureDrop Workstation. As outlined in our :ref:`passphrase best practices<passphrase_best_practices>`, we recommend all SecureDrop users, including administrators, use the KeePassXC password manager to generate and retain strong and unique passphrases. 

Template password database
------------------------------------

To facilitate using KeePassXC to organize all the credentials needed for using and administering the system, SecureDrop comes with a template database with organized entries ready to be filled in.

.. _keepasscx_template_database:

-  Open the KeePassXC program |KeePassXC| in the `vault` VM
-  Select **Database ▸ Open database**, and navigate to the location of
   **/path/to/Passwords.kdbx**, select it, and click **Open**
-  Leave the password blank and click **OK**. If you receive an "Unlock failed"
   prompt, click **Retry with empty password**.
-  Edit entries as required.
-  Select **Database ▸ Save Database** to save your changes.

The next time you use KeepassXC in `vault`, the database at ``/path/to/Passwords.kdbx``
will be selected by default.

KeePassXC will show a warning every time you attempt to open a database without
entering a password. Because your persistent volume is encrypted, setting up this
additional password is not strictly required. It provides some additional
protection, e.g., if a computer is left running, at the cost of convenience.

For passwordless access without warnings, you can protect the database using a
key file, via **Database ▸ Database settings ▸ Security ▸ Add additional protection
▸ Add Key File ▸ Generate**. This key file has to be stored in your Persistent
folder and it must be selected when you open the database.

After configuring the password database, restart KeePassXC once to verify
that you are able to access it as expected.

.. warning:: You will not be able to access your passwords if you
         forget the full disk encryption or the location of the key
         file used to protect the database.

.. |KeePassXC| image:: ../../images/keepassxc.png

.. _keepassxc_manual_create_database:

In case you wish to manually create a database, the suggested password fields in
the template are:

**Admin**:

- Admin account username
- App Server SSH Onion URL
- Email account for sending OSSEC alerts
- Monitor Server SSH Onion URL
- Network Firewall Admin Credentials
- *OSSEC Alert Public Key*
- SecureDrop Login Credentials

**Journalist**:

- Auth Value: Journalist Interface
- Onion URL: Journalist Interface
- Personal GPG Key
- SecureDrop Login Credentials

**Backup**:

- This section contains clones of the above entries in case a user
  accidentally overwrites an entry.

As you proceed with the installation, enter the credentials you create in this database as you go.