Keeping the Workstation secure
==============================

The *SecureDrop Workstation* provides the combined functionality of the 
Tails-based *Journalist Workstation* and *Secure Viewing Station* (SVS). As such,
it contains both a copy of the *Submission Private Key*, and encrypted and 
decrypted messages and submissions. It's critical to ensure that the same
security practices that are used to protect the SVS are applied to the 
*SecureDrop Workstation* as well.

Physically secure the workstation
---------------------------------
The *SecureDrop Workstation* computer is subject to similar security requirements
as the *SVS*, with the additional requirement of a working Internet connection:

- It should be stored in a secure and locked room, with access restricted to
  users and administrators.
- The room may be monitored externally, but there should be no internal
  monitoring.
- A wired Internet connection that does not restrict Tor must be available for
  the workstation. This connection should either be dedicated to *SecureDrop
  Workstation*, or should be on a fully segregated subnet from the rest of the
  corporate network.
- Users should not bring other electronic devices into the room, with the
  exception of smartphones used for 2FA token generation. While in the room,
  smartphones should be set to airplane mode, and should not be used for any
  purpose other than 2FA.


Use strong passphrases
----------------------
It is recommended to use strong `Diceware-generated passphrases 
<https://en.wikipedia.org/wiki/Diceware>`_ for all passwords in the system. The
password manager included with current versions of Tails,
`KeepassXC <https://tails.boum.org/doc/encryption_and_privacy/manage_passwords/index.en.html>`_,
includes an option to generate Diceware passphrases, which may make the process
easier for end users.

Passwords and other credentials in use by *SecureDrop Workstation* include:

- the Qubes full disk encryption (FDE) password, required to unlock system 
  storage on boot. All users will need this password.
- the Qubes system user password, required to log in. All users will need this
  password
- *SecureDrop App* login credentials. These are the same credentials that
  are used by journalists and administrators to log in to the *Journalist
  Interface*, and are unique per user.

Apply updates when prompted
---------------------------

*SecureDrop Workstation* includes an updater application that runs automatically
on startup, checks for Qubes and SecureDrop updates, and prompts the user to
apply them if found. Given the sensitive nature of the system, it is critical
that updates are applied when available. Administrators should ensure that users
are aware of this requirement, and should periodically check to ensure that
the system is up to date. 
