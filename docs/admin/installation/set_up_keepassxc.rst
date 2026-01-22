.. _keepassxc_setup:

Using the Admin Password Database
------------------------------------

While setting up the *Admin Workstation* in the previous step, you copied a KeePassXC password database template from the cloned SecureDrop Repository to the Tails Persistent storage

Using a KeePassXC database makes it easier for
admins and journalists to generate strong, unique passphrases and
store them securely. You are encourage to set up your personal password database
using this template.

.. note::

   Earlier versions of Tails used KeePassX instead of KeePassXC.
   The provided template is compatible with both.

-  Open the KeePassXC program |KeePassXC| which is already installed on
   Tails
-  Select **Database ▸ Open database**, and navigate to the location of
   **~/Persistent/Passwords.kdbx**, select it, and click **Open**
-  Leave the password blank and click **OK**. If you receive an "Unlock failed"
   prompt, click **Retry with empty password**.
-  Edit entries as required.
-  Select **Database ▸ Save Database** to save your changes.

The next time you use KeepassXC, the database at ``~/Persistent/Passwords.kdbx``
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
         forget the persistent storage password or the location of the key
         file used to protect the database.

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

**Secure Viewing Station**:

- SecureDrop GPG Key

**Backup**:

- This section contains clones of the above entries in case a user
  accidentally overwrites an entry.

.. |KeePassXC| image:: ../../images/keepassxc.png