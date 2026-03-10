Install SecureDrop
==================

Now that the servers are prepared, you are ready to install and configure the SecureDrop server on them. Like all future administrative tasks, this is performed from the ``sd-admin`` VM on the Primary SecureDrop Workstation you prepared earlier. 

For this step, the Primary SecureDrop Workstation must have a network connection to the servers as configured 

.. _test_connectivity:

Test Connectivity to Servers
----------------------------

Having set up the firewall, you can plug the *Application Server* and the *Monitor Server* into the firewall. Your Primary SecureDrop Workstation should also be connected to the firewall.

If you are using a setup where there is a switch on the LAN port, plug the *Application Server*
into the switch and plug the *Monitor Server* into the OPT1 port.

You should make sure you can connect from the Admin Workstation to both of the servers before continuing with the
installation.

Open a terminal in ``sd-admin`` and verify that you can SSH into both servers, authenticating with your server administrator username (e.g. ``sdadmin``) and password:

.. code:: sh

    $ ssh <username>@<App IP address> hostname
    app
    $ ssh <username>@<Monitor IP address> hostname
    mon

.. tip:: If you cannot connect, check the network firewall logs for
         clues.

Set Up SSH Keys
---------------

Ubuntu's default SSH configuration authenticates users with their
passphrases; however, public key authentication is more secure, and once
it's set up it is also easier to use. In this section, you will create
a new SSH key for authenticating to both servers. Since the *Admin
Workstation* was set up with `SSH Client Persistence`_, this key will be saved
on the *Admin Workstation* and can be used in the future to authenticate to
the servers in order to perform administrative tasks.

.. _SSH Client Persistence: https://tails.net/doc/persistent_storage/configure/index.en.html#index11h2

First, generate the new SSH keypair:

::

    ssh-keygen -t rsa -b 4096

You'll be asked to "Enter file in which to save the key" Type
**Enter** to use the default location.

Given that this key is on the encrypted persistence of a Tails USB,
you do not need to add an additional passphrase to protect the key.
If you do elect to use a passphrase, note that you will need to manually
type it (Tails' pinentry will not allow you to copy and paste a passphrase).

Once the key has finished generating, you need to copy the public key
to both servers. Use ``ssh-copy-id`` to copy the public key to each
server, authenticating with your passphrase:

.. code:: sh

    ssh-copy-id <username>@<App IP address>
    ssh-copy-id <username>@<Mon IP address>

Verify that you are able to authenticate to both servers by running
the below commands. You should not be prompted for a passphrase
(unless you chose to passphrase-protect the key you just created).

.. code:: sh

    $ ssh <username>@<App IP address> hostname
    app
    $ ssh <username>@<Monitor IP address> hostname
    mon

If you have successfully connected to the server via SSH, the terminal
output will be name of the server to which you have connected ('app'
or 'mon') as shown above.

.. _configure_securedrop:

Prepare Configuration Files
---------------------------

Make sure you have the following information and files ready before
continuing:

-  the *Application Server* local IP address
-  the *Monitor Server* local IP address
-  the *Submission Public Key* (*generated earlier*)
-  the *Submission Key* fingerprint
-  the email address that will receive alerts from OSSEC
-  the GPG public key and fingerprint for the email address that will
   receive the alerts
-  connection information for the SMTP relay that handles OSSEC alerts
   (see the :doc:`OSSEC Alerts Guide <../maintenance/ossec_alerts>`)
-  the username of a journalist who will be using SecureDrop (you
   can add more later)
-  the username of the system admin

If configuring Daily Journalist Alert emails (this is optional and can be configured later), you will also need:
-  the *Journalist Alert Public Key*
-  the *Journalist Alert Public Key*  fingerprint
-  the email address that will receive the journalist alerts

Localization of the *Source Interface* and *Journalist Interface*
-----------------------------------------------------------------

The *Source Interface* and *Journalist Interface* are translated in the following
languages:

https://github.com/freedomofpress/securedrop/blob/develop/securedrop/i18n.rst

During the installation you will be given the opportunity to choose from a
list of supported languages to display using the codes shown in
parentheses.

.. note:: With a *Source Interface* displayed in French (for example), sources
          submitting documents are likely to expect a journalist fluent in
          French to be available to read the documents and follow up in that
          language.

OSSEC Alerts Public Key
-----------------------

Before proceeding, you will need to copy the *OSSEC Alert Public Key* public key to
``~/.config/securedrop-admin`` in the ``sd-admin`` VM.

If you don't have your GPG key ready, you can run GnuPG on the command line in
order to find, import, and export your public key. It's best to copy the key
from a trusted and verified source, but you can also request it from keyservers
using the known fingerprint. Looking it up by email address or a shorter key ID
format could cause you to obtain a wrong, malicious, or expired key. Instead, we
recommend you type out your fingerprint in groups of four (just like GPG prints
it) enclosed by double quotes.  The reason we suggest this formatting for the
fingerprint is simply because it's easiest to type and verify correctly. In the
code below simply replace ``<fingerprint>`` with your full, space-separated
fingerprint:

Download your key and import it into the local keyring: ::

    gpg --recv-key "<fingerprint>"

.. note:: It is important you type this out correctly. If you are not
          copy-pasting this command, we recommend you double-check you have
          entered it correctly before pressing enter.

Again, when passing the full public key fingerprint to the ``--recv-key`` command, GPG
will implicitly verify that the fingerprint of the key received matches the
argument passed.

.. caution:: If GPG warns you that the fingerprint of the key received
             does not match the one requested **do not** proceed with
             the installation. If this happens, please email us at
             securedrop@freedom.press.

Next we export the key to a local file. ::

    gpg --export -a "<fingerprint>" > ossec.pub


Copy the key to a directory where it's accessible by the SecureDrop
installation: ::

    cp ossec.pub ~/.config/securedrop-admin/

The fingerprint is a unique identifier for an encryption (public) key.  The
short and long key ids correspond to the last 8 and 16 hexadecimal digits of the
fingerprint, respectively, and are thus a subset of the fingerprint. The full fingerprint
must be the entire 40 hexadecimal digit GPG fingerprint for this same key, with all capital
letters and no spaces. The following command will retrieve and format the fingerprint per our requirements: ::

    gpg --with-colons --fingerprint "<fingerprint>" | grep "^fpr" | cut -d: -f10

The Postfix configuration enforces certificate verification, and
requires both a valid certificate and STARTTLS support on the SMTP
relay. By default the system CAs will be used for validating the relay
certificate. 

If you need to provide a custom CA to perform the
validation, copy the cert file to ``~/.config/securedrop-admin`` add a
new variable to ``~/.config/securedrop-admin/site-specific``: ::

    smtp_relay_cert_override_file: MyOrg.crt

where ``MyOrg.crt`` is the filename. The file will be copied to the
server in ``/etc/ssl/certs_local`` and the system CAs will be ignored
when validating the SMTP relay TLS certificate. Be sure to save 
``~/.config/securedrop-admin/site-specific`` when you are finished.

      
.. _ansible-site-specific:
    
Prepare SecureDrop server configuration
---------------------------------------

Open a terminal in ``sd-admin`` and run the following command, answering the prompts the the values that match your environment and SecureDrop installation: ::

    securedrop-admin sdconfig

The script will automatically validate the answers you provided and display
error messages if any problems are detected. The answers will be
written to the file ``~/.config/securedrop-admin/site-specific``.

Optional: Configuring fingerprint verification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you run your own mail server, you may wish to increase the security
level used by Postfix for sending mail to ``fingerprint``, rather than
``secure``. Doing so will require an exact match for the fingerprint of
TLS certificate on the SMTP relay. The advantage to fingerprint
verification is additional security, but the disadvantage is potential
maintenance cost if the fingerprint changes often. If you manage the
mail server and handle the certificate rotation, you should update the
SecureDrop configuration whenever the certificate changes, so that OSSEC
alerts continue to send. Using fingerprint verification does not work
well for popular mail relays such as smtp.gmail.com, as those
fingerprints can change frequently, due to load balancing or other
factors.

You can retrieve the fingerprint of your SMTP relay by running the
command below (all on one line). Please note that you will need to
replace ``smtp.gmail.com`` and ``587`` with the correct domain and port
for your SMTP relay. ::

    openssl s_client -connect smtp.gmail.com:587 -starttls smtp < /dev/null 2>/dev/null |
        openssl x509 -fingerprint -noout -in /dev/stdin | cut -d'=' -f2

If you are using Tails, you will not be able to connect directly with
``openssl s_client`` due to the default firewall rules. To get around
this, proxy the requests over Tor by adding ``torify`` at the beginning
of the command. The output of the command above should look like the
following:

::

    6D:87:EE:CB:D0:37:2F:88:B8:29:06:FB:35:F4:65:00:7F:FD:84:29

Finally, add a new variable to ``~/.config/securedrop-admin/site-specific`` as
``smtp_relay_fingerprint``, like so: ::

    smtp_relay_fingerprint: "6D:87:EE:CB:D0:37:2F:88:B8:29:06:FB:35:F4:65:00:7F:FD:84:29"

Specifying the fingerprint will configure Postfix to use it for
verification on the next playbook run. (To disable fingerprint
verification, simply delete the variable line you added, and rerun the
playbooks.) Save ``~/.config/securedrop-admin/site-specific`` and exit the editor.

.. _Install SecureDrop Servers:

Install SecureDrop Servers
--------------------------

Now you are ready to install! This process will configure
the servers and install SecureDrop and all of its dependencies on
the remote servers. In a terminal in ``sd-admin`` run the following command: ::

    securedrop-admin install

You will be prompted to enter the sudo passphrase for the *Application Server* and
*Monitor Server* (which should be the same).

The installation process will take some time. It will return you to the
terminal prompt when complete.

If any errors occur while running the install, carefully inspect the
error output. Considering saving any error messages for reference and
troubleshooting.

.. include:: ../../includes/rerun-install-is-safe.txt

If needed, make edits to the file located at
``~/.config/securedrop-admin/site-specific`` as
described :ref:`above<ansible-site-specific>`. If you continue to have
issues, please submit a detailed issue notice on `GitHub
<https://github.com/freedomofpress/securedrop/issues/new>`__ or send
an email to securedrop@freedom.press.

.. note:: The SecureDrop install process configures a custom Linux
          kernel hardened with the grsecurity patch set. Only binary
          images are hosted in the apt repo. For source packages, see
          the `Source Offer`_.

.. _`Source Offer`: https://github.com/freedomofpress/securedrop/blob/develop/SOURCE_OFFER

Once the installation is complete, addresses and credentials for each
onion service will be available in the following files under
``~/.config/securedrop-admin``:


V3 onion services
-----------------

- ``app-sourcev3-ths`` contains the v3 ``.onion`` address of the *Source
  Interface*.
- ``app-journalist.auth_private`` contains the ``onion`` address and private key
  providing access to the *Journalist Interface*.
- ``app-ssh.auth_private`` contains the ``onion`` address and private key
  providing SSH access to the *Application Server*.
- ``mon-ssh.auth_private`` contains the ``onion`` address and private key
  providing SSH access to the *Monitor Server*.
- ``tor_v3_keys.json`` contains the keypairs required for access to the
  *Journalist Interface* and SSH access to the servers - it is required for
  future runs of ``securedrop-admin install``.

.. warning:: The three ``.auth_private`` files and the ``tor_v3_keys.json`` file
             contain secret keys that should not be shared with third parties,
             or copied from the *Admin Workstation* for any purpose other than
             tasks such as performing backups or onboarding new users.

The dynamic inventory file will automatically read the ``onion`` addresses from
the ``app-ssh.auth_private`` and ``mon-ssh.auth_private`` files and use them to
connect to the servers over SSH during subsequent playbook runs.

