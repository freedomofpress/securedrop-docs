Set Up the *Admin Workstation*
==============================

.. _set_up_admin_tails:

Earlier, you should have created the *Admin Workstation* Tails USB along with a
persistent volume for it. Now, we are going to add a couple more features to
the *Admin Workstation* to facilitate SecureDrop's setup.

If you have not switched to and booted the *Admin Workstation* Tails USB on your
regular workstation, do so now.

Start Tails with Persistence Enabled
------------------------------------

After you boot the *Admin Workstation* Tails USB on your normal workstation, you
should see a "Welcome to Tails" screen with a field labeled "Encrypted Persistent
Storage".  Enter your password and click **Unlock**. Do not click **Start
Tails** yet. Under "Additional Settings" click **+**.

Click **Administration password**, enter a password for use with this
specific Tails session, and click **Add**.

.. note:: The Tails administration password is a one-time password. It
      will reset every time you shut down Tails.

During the installation, you will need the unsafe browser to access the firewall
configuration. If you are using Tails 5.8 or newer, the unsafe browser is
enabled automatically. If you are using an eariler version, you can enable it
by clicking "Unsafe Browser" and then clicking **Add**:

|UnsafeBrowser|

Click **Start Tails**. After Tails finishes booting, make sure you're connected
to the Internet |Network| and that the Tor status onion icon is not crossed out
|TorStatus|, consulting the icons in the upper right corner of the
screen.

.. |UnsafeBrowser| image:: ../../images/tails_4x/unsafe-browser.png
.. |Network| image:: ../../images/network-wired.png
.. |TorStatus| image:: ../../images/tor-status-indicator.png


.. _Download the SecureDrop repository:

Download the SecureDrop repository
----------------------------------

The rest of the SecureDrop-specific configuration is assisted by files
stored in the SecureDrop Git repository. We're going to be using this
again once SecureDrop is installed, but you should download it now. To
get started, open a terminal |Terminal|. You will use this Terminal
throughout the rest of the install process.

Start by running the following commands to download the git repository.

.. code:: sh

    cd ~/Persistent
    git clone https://github.com/freedomofpress/securedrop.git

.. note:: Since the repository is fairly large and Tor can be slow,
      this may take a few minutes.

.. caution:: Do not download SecureDrop Git repository as a Zip file,
             or any other means. Only download by using the given git
             command.


Verify the Release Tag
~~~~~~~~~~~~~~~~~~~~~~

.. important::

   It is crucial for the integrity of your installation that you carefully
   follow the instructions below. By following these steps, you will verify
   if your copy of the codebase has been approved by the SecureDrop
   development team.

Download and verify the **SecureDrop Release Signing Key** using the following
command:

.. code:: sh

   gpg --keyserver hkps://keys.openpgp.org --recv-key \
   "2359 E653 8C06 13E6 5295 5E6C 188E DD3B 7B22 E6A3"

If you are not copy-pasting this command, we recommend you double-check you have
entered it correctly before pressing enter. GPG will implicitly verify that the
fingerprint of the key received matches the argument passed.

.. _Tails is connected to Tor: https://tails.net/doc/anonymous_internet/tor/index.en.html#index5h1

If GPG warns you that the fingerprint of the key received does not
match the one requested, do **not** proceed with the installation. If this
happens, please contact us at securedrop@freedom.press.

.. note::

   If the ``--recv-key`` command fails, first double-check that
   `Tails is connected to Tor`_. Once you've confirmed that you're successfully
   connected to Tor, try re-running the ``--recv-key`` command a few times.

   If the command still fails, the *keys.openpgp.org* keyserver may be down.
   In that case, we recommend downloading the key from the SecureDrop website:

   .. code:: sh

      cd ~/Persistent
      torify curl -LO https://securedrop.org/securedrop-release-key.asc

   Before importing it, inspect the key's fingerprint using the following
   command. The ``--dry-run`` option ensures that the key is not imported just
   yet:

   .. code:: sh

      gpg --with-fingerprint --import-options import-show --dry-run \
        --import securedrop-release-key.asc

   Compare the fingerprint in the output with the fingerprint at the beginning
   of this section. If the fingerprints match, you can safely import the key,
   using the following command:

   .. code:: sh

      gpg --import securedrop-release-key.asc

   If you encounter any difficulties verifying the integrity of the
   release key, do **not** proceed with the installation. Instead, please
   contact us at securedrop@freedom.press.

.. _Checkout and Verify the Current Release Tag:

Once you have imported the release key, verify that the current release tag was
signed with the release signing key:

.. code:: sh

    cd ~/Persistent/securedrop/
    git fetch --tags
    git tag -v 2.11.0

The output should include the following two lines:

.. code:: sh

   gpg:                using RSA key 2359E6538C0613E652955E6C188EDD3B7B22E6A3
   gpg: Good signature from "SecureDrop Release Signing Key <securedrop-release-key-2021@freedom.press>" [unknown]


.. important::

   If you do not see the message above, signature verification has failed
   and you should **not** proceed with the installation. If this happens,
   please contact us at securedrop@freedom.press.

Verify that each character of the fingerprint matches what is on the
screen of your workstation. If it does, you can check out the new release:

.. code:: sh

    git checkout 2.11.0

.. important:: If you see the warning ``refname '2.11.0' is ambiguous`` in the
               output, we recommend that you contact us immediately at
               securedrop@freedom.press (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__).


.. _keepassxc_setup:

Create the Admin Passphrase Database
------------------------------------

We provide a KeePassXC password database template to make it easier for
admins and journalists to generate strong, unique passphrases and
store them securely. Once you have set up Tails with persistence and
have cloned the repo, you can set up your personal password database
using this template.

.. note::

   Earlier versions of Tails used KeePassX instead of KeePassXC.
   The provided template is compatible with both.

You can find the template in ``tails_files/securedrop-keepassx.kdbx``
in the SecureDrop repository that you just cloned. To use the template:

-  Copy the template to the Persistent folder - from a terminal, run the
   command:

   .. code:: sh

     cp ~/Persistent/securedrop/tails_files/securedrop-keepassx.kdbx \
        ~/Persistent/Passwords.kdbx

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
         forget the peristent storage password or the location of the key
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

.. |Terminal| image:: ../../images/terminal.png
.. |KeePassXC| image:: ../../images/keepassxc.png
