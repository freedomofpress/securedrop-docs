Troubleshooting OSSEC
---------------------

Some OSSEC alerts should begin to arrive as soon as the installation has
finished.

The easiest way to test that OSSEC is working is to SSH to the Monitor
Server and run ``systemctl restart ossec``. This will trigger an Alert
level 3 saying: "Ossec server started."

So you've finished installing SecureDrop, but you haven't received any
OSSEC alerts. First, check your spam/junk folder. If they're not in
there, then most likely there is a problem with the email configuration.
In order to find out what's wrong, you'll have to SSH to the Monitor
Server and take a look at the logs. To examine the mail log created by
Postfix, run the following command: ::

    tail /var/log/mail.log

The output will show you attempts to send the alerts and provide hints
as to what went wrong. Here's a few possibilities and how to fix them:

================================ ===================================================
Problem                          Solution
================================ ===================================================
Connection timed out             | Check that the hostname and port is correct
                                   in the relayhost line of
                                 | ``/etc/postfix/main.cf``
Server certificate not verified  | Check that the relay certificate is valid
                                   (for more detailed help, see `Troubleshooting
                                   SMTP TLS <#troubleshooting-smtp-tls>`_).
                                   Consider adding ``smtp_relay_cert_override_file``
                                 | to ``prod_specific.yml`` as described above.
Authentication failure           | Edit ``/etc/postfix/sasl_passwd`` and make
                                   sure the username, domain and password are
                                   correct. Run ``postmap /etc/postfix/sasl_passwd``
                                 | to update when finished.
================================ ===================================================

After making changes to the Postfix configuration, you should run
``systemctl reload postfix`` and test the new settings by restarting the
OSSEC service.

.. tip:: If you change the SMTP relay port after installation for any
         reason, you must update the SMTP relay port using
         ``securedrop-admin sdconfig`` and deploy using
         ``securedrop-admin install``.

Useful log files for OSSEC
~~~~~~~~~~~~~~~~~~~~~~~~~~

Other log files that may contain useful information:

/var/log/procmail.log
    Includes lines for sending mail containing OSSEC alerts.

/var/log/syslog
    Messages related to grsecurity, AppArmor and iptables.

/var/ossec/logs/ossec.log
    OSSEC's general operation is covered here.

/var/ossec/logs/alerts/alerts.log
    Contains details of every recent OSSEC alert.

.. tip:: Remember to encrypt any log files before sending via email,
         for example to securedrop@freedom.press, in order to protect
         security-related information about your organization's
         SecureDrop instance.

Not receiving emails
~~~~~~~~~~~~~~~~~~~~
Some mail servers require that the sending email address match the account
that authenticated to send mail. By default the *Monitor Server* will use
``ossec@ossec.server`` for the from line, but your mail provider may not support
the mismatch between the domain of that value and your real mail host.
If the Admin email address (configured as ``ossec_alert_email`` in
``~/.config/securedrop-admin/site-specific``) does not start receiving OSSEC alerts updates shortly
after the first playbook run, try setting ``ossec_from_address`` in
``~/.config/securedrop-admin/site-specific`` to the full email address used for sending the alerts,
then run the playbook again.

Message failed to encrypt
~~~~~~~~~~~~~~~~~~~~~~~~~
If OSSEC cannot encrypt the alert to the *OSSEC Alert Public Key* for the Admin
email address (configured as ``ossec_alert_email`` in ``~/.config/securedrop-admin/site-specific``),
the system will send a static message instead of the scheduled alert:

  Failed to encrypt OSSEC alert. Investigate the mailing configuration on the Monitor Server.

Check the GPG configuration vars in ``~/.config/securedrop-admin/site-specific``. In particular,
make sure the GPG fingerprint matches that of the public key file you
exported.

Troubleshooting SMTP TLS
~~~~~~~~~~~~~~~~~~~~~~~~

Your choice of SMTP relay server must support STARTTLS and have a valid
server certificate. By default, the *Monitor Server*'s Postfix
configuration will try to validate the server certificate using the
default root store (in Ubuntu, this is maintained in the
``ca-certificates`` package). You can override this by setting
``smtp_relay_cert_override_file`` as described earlier in this document.

In either situation, it can be helpful to use the ``openssl`` command
line tool to verify that you can successfully connect to your chosen
SMTP relay securely. We recommend doing this before running the
playbook, but it can also be useful as part of troubleshooting OSSEC
email send failures.

In either case, start by attempting to make a STARTTLS connection to
your chosen ``smtp_relay:smtp_relay_port`` (get the values from your
``group_vars/all/site-specific`` file). On a machine running Ubuntu, run the
following ``openssl`` command, replacing ``smtp_relay`` and
``smtp_relay_port`` with your specific values: ::

    openssl s_client -showcerts -starttls smtp -connect smtp_relay:smtp_relay_port < /dev/null 2> /dev/null

Note that you will not be able to run this command on the Application
Server because of the firewall rules. You can run it on the Monitor
Server, but you will need to run it as the Postfix user (again, due to
the firewall rules): ::

    sudo -u postfix openssl s_client -showcerts -starttls smtp -connect smtp.gmail.com:587 < /dev/null 2> /dev/null

If the command fails with "Could not connect" or a similar message, then
this mail server does not support STARTTLS. Verify that the values you
are using for ``smtp_relay`` and ``smtp_relay_port`` are correct. If
they are, you should contact the admin of that relay and talk to them
about supporting STARTTLS, or consider using another relay that already
has support.

If the command succeeds, the first line of the output should be
"CONNECTED" followed by a lot of diagnostic information about the
connection. You should look for the line that starts with "Verify return
code", which is usually one of the last lines of the output. Since we
did not give ``openssl`` any information about how to verify
certificates in the previous command, it should be a non-zero value
(indicating verification failed). In my case, it is
``Verify return code: 20 (unable to get local issuer certificate)``,
which indicates that openssl does not know how to build the certificate
chain to a trusted root.

If you are using the default verification setup, you can check whether
your cert is verifiable by the default root store with ``-CApath``: ::

    openssl s_client -CApath /etc/ssl/certs -showcerts -starttls smtp -connect smtp_relay:smtp_relay_port < /dev/null 2> /dev/null

For example, if I'm testing Gmail as my SMTP relay
(``smtp.gmail.com:587``), running the ``openssl`` with the default root
store results in ``Verify return code: 0 (ok)`` because their
certificate is valid and signed by one of the roots in the default
store. This indicates that can be successfully used to securely relay
email in the default configuration of the *Monitor Server*.

If your SMTP relay server does not successfully verify, you should use
the return code and its text description to help you diagnose the cause.
Your cert may be expired, in which case you should renew it. It may not
be signed by a trusted CA, in which case you should obtain a signature
from a trusted CA and install it on the mail server. It may not have the
right hostnames in the Common Name or Subject Alternative Names, in
which case you will need to generate a new CSR with the correct
hostnames and then obtain a new certificate and install it. Etc., etc.

If you are *not* using the default verification setup, and
intentionally do not want to use a certificate signed by one of the
default CA's in Ubuntu, you can still use ``openssl`` to test whether
you can successfully negotiate a secure connection. Begin by copying
your certificate file (``smtp_relay_cert_override_file`` from
``group_vars/all/site-specific``) to the computer you are using for testing. You
can use ``-CAfile`` to test if your connection will succeed using your
custom root certificate: ::

    openssl s_client -CAfile /path/to/smtp_relay_cert_override_file -showcerts -starttls smtp -connect smtp_relay:smtp_relay_port < /dev/null 2> /dev/null

Finally, if you have a specific server in mind but are not sure what
certificate you need to verify the connection, you can use the output of
``openssl s_client`` to figure it out. Since we have ``-showcerts``
turned on, ``openssl`` prints the entire certificate chain it receives
from the server. A properly configured server will provide all of the
certificates in the chain up to the root cert, which needs to be
identified as "trusted" for the verification to succeed. To see the
chain, find the part of the output that start with
``Certificate chain``. It will look something like this (example from
``smtp.gmail.com``, with certificate contents snipped for brevity): ::

    ---
    Certificate chain
    0 s:/C=US/ST=California/L=Mountain View/O=Google Inc/CN=smtp.gmail.com
    i:/C=US/O=Google Inc/CN=Google Internet Authority G2
    -----BEGIN CERTIFICATE-----
    <snip>
    -----END CERTIFICATE-----
    1 s:/C=US/O=Google Inc/CN=Google Internet Authority G2
    i:/C=US/O=GeoTrust Inc./CN=GeoTrust Global CA
    -----BEGIN CERTIFICATE-----
    <snip>
    -----END CERTIFICATE-----
    2 s:/C=US/O=GeoTrust Inc./CN=GeoTrust Global CA
    i:/C=US/O=Equifax/OU=Equifax Secure Certificate Authority
    -----BEGIN CERTIFICATE-----
    <snip>
    -----END CERTIFICATE-----
    ---

The certificates are in reverse order from leaf to root. ``openssl``
handily prints the Subject (``s:``) and Issuer (``i:``) information for
each cert. In order to find the root certificate, look at the Issuer of
the last certificate. In this case, that's
``Equifax Secure Certificate Authority``. This is the root certificate
that issued the first certificate in the chain, and it is what you need
to tell Postfix to use in order to trust the whole connection.

Actually obtaining this certificate and establishing trust in it is
beyond the scope of this document. Typically, if you are using your own
SMTP relay with a custom CA, you will be able to obtain this certificate
from an intranet portal or someone on your IT staff. For a well-known
global CA, you can obtain it from the CA's website. For example, a quick
search for "Equifax Secure Certificate Authority" finds the web page of
`GeoTrust's Root
Certificates <https://www.geotrust.com/resources/root-certificates/>`__,
which have accompanying background information and are available for
download.

Once you have the root certificate file, you can use ``-CAfile`` to test
that it will successfully verify the connection.
