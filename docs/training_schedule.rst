SecureDrop On-Site Training Schedule
====================================

Who is This For?
----------------

While SecureDrop is open source and available for anyone to install and set up,
Freedom of the Press Foundation provides paid support contracts to assist with
the initial setup of the system, as well as training and ongoing technical
support.

We generally recommend that news organizations set aside two days for the setup
and training process. The first day is primarily the installation with the
administrators and the second day is the training for those journalists who will
regularly check SecureDrop.

Often, the entire process takes less time than two days but sometimes there are
unique network or hardware issues that come up and delay completion.

If you are considering a paid contract for your organization, the following
will provide you with an idea of the typical on-site installation and training
timeline.

Day 1: Install
--------------

Installing SecureDrop
~~~~~~~~~~~~~~~~~~~~~

Installation may be started by admins ahead of schedule to save on-site time.

**Time**: 6+ hours

**Participants**: SecureDrop Admins

**Format**: For assisted installs, in-person or hybrid-remote (FPF remote, admins in-person)

-  Follow :doc:`Installing SecureDrop <admin/installation/install>`

Day 2: Admin and Digital Security Training
------------------------------------------

Admin Training
~~~~~~~~~~~~~~

**Time**: 4+ hours

**Participants**: SecureDrop Admins

**Format**: In-person or hybrid-remote (FPF remote, admins in-person)

-  Check access to previously created Tails USB
-  Updating Tails
-  Setup KeePassXC manager (one for *Secure Viewing Station*, one for *Admin Workstation*)
-  Setting up SSH aliases for the *Admin Workstation* if needed
-  Go over common OSSEC alerts for security updates and daily reports
-  Adding/removing SecureDrop users
-  Backups
-  Disk space monitoring
-  Changing passphrases (for FDE, persistent volumes, 2FA, KeePassXC
   managers...)
-  Enabling logging for troubleshooting
-  Sending logs to FPF support team
-  Preparing *Journalist Workstation* drives
-  Updating SecureDrop

   -  Unattended upgrades
   -  Upgrades that require admin intervention

-  Distribute important info:

   -  https://docs.securedrop.org
   -  :doc:`Admin Best Practice Guide <admin/reference/admin>`
   -  :doc:`Hardware for SecureDrop <admin/installation/hardware>`
   -  :ref:`Deployment` guidelines


Digital Security 101
~~~~~~~~~~~~~~~~~~~~

**Time**: 2 hours

**Participants**: Journalists to be onboarded to SecureDrop, admins, OSSEC alert
recipients and anyone else interested

**Format**: In-person or remote

- Risk assessment and threat modeling
- Account security fundamentals

   - Passphrases and Password Managers
   - Two-factor authentication (2FA)
- Phishing prevention
- Web browser security
- IP address privacy, VPNs and Tor
- Secure communication tools for colleagues and sources
- Q & A

Day 3: Journalist Training and Onboarding
-----------------------------------------

Journalist Training, Part 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Time**: 2.5 hours

**Participants**: Journalists to be onboarded to SecureDrop, admins, OSSEC alert
recipients and anyone else interested

**Format**: In-person or remote

-  Introduction to Tails and its features
-  Importance of the *Landing Page* security
-  Demo of source submission process
-  Demo of journalist's processes for checking the *Journalist Interface*
-  Demo of journalist's processes for replies
-  Demo working with submissions on the *Secure Viewing Station*
-  Secure-deleting and difference between wipe and erase free space on
   Tails, and when to use each
-  Discuss scrubbing submitted documents prior to publication

   -  Using MAT (Metadata Anonymisation Toolkit)
   -  Converting files to more benign formats
   -  What to do for unsupported formats
-  Options for distributing with other news organizations
-  Show example of an OSSEC alert, briefly cover what it does
-  Overview of `onion names <https://securedrop.org/news/introducing-onion-names-securedrop/>`__
-  Physical security of servers and *Secure Viewing Station*
-  How to securely publicize the organization's *Source Interface* Tor URL
-  Distribute important info:

   -  https://securedrop.org
   -  :doc:`Source Best Practice Guide <source/source>`
   -  :doc:`Journalist Best Practice Guide <journalist/journalist>`

-  Link to security audits
- Q & A

Journalist Training, Part 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Time**: 1+ hours, depending on the number of journalists being onboarded

**Participants**: Journalists to be onboarded to SecureDrop, admins

**Format**: In-person or hybrid-remote (FPF remote, journalists and admins in-person)

-  Check access to previously created Tails USB drives
-  Create SecureDrop accounts for individual journalists
-  Setup KeePassXC for *Journalist Workstation* drive
-  Disaster recovery for 2FA and password manager
-  Updating Tails
-  If needed, process for distributing the *Submission Private Key*
   to a remote journalist's air-gapped *Secure Viewing Station*
-  Do complete journalist process walk through once, and repeat for each individual journalist being onboarded
