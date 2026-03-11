.. _keepassxc_setup:

Using the KeePassXC Password Manager
====================================

Qubes OS comes with the KeePassXC password manager preinstalled and SecureDrop Workstation. As outlined in our :ref:`passphrase best practices<passphrase_best_practices>`, we recommend all SecureDrop users, including administrators, use the KeePassXC password manager to generate and retain strong and unique passphrases. 

Template password database
------------------------------------

To facilitate using KeePassXC to organize all the credentials needed for using and administering the system, SecureDrop comes with a template database with organized entries ready to be filled in.

.. include:: /includes/keepassxc.txt

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