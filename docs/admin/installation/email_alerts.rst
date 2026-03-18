Prepare email accounts
======================

SecureDrop sends different alerts by PGP-encrypted email. Before installing SecureDrop, you must select or prepare the e-mail accounts where you would like these alerts to be sent. In the case of OSSEC alerts (which you must set up), configuring an SMTP relay is also required. 

.. _daily_journalist_alerts:

Optional: Daily Journalist alerts
-------------------------------------------

When a SecureDrop has little activity and receives only a few submissions every other week, checking daily only to find there is nothing is a burden. It is more convenient for journalists to be notified daily via encrypted email about whether or not there has been submission activity in the past 24 hours.

If the email shows submissions were received, the journalist can check their *Journalist Workstation*.

.. note::

   For security reasons, the email will be sent every 24 hours, regardless
   of whether there are new submissions or not. The notification is sent after
   the daily reboot of the *Application Server*. The subject of the email will
   always be "Submissions in the past 24h". To find out whether there were
   submissions or not, a journalist must decrypt the contents of the email.

In the simplest case a journalist will provides their email and GPG public key to
you, the admin. If a team of journalist wants to receive these daily alerts, they 
should share a GPG key and ask the admin to setup a mail alias
(SecureDrop does not provide that service) so they all receive the alerts and
are able to decrypt them.

It is not possible to specify multiple email addresses for email notifications. If there are multiple intended recipients, use an alias or mailing list. However, all subscribers must share the GPG private key, as it is not possible to specify multiple keys.

If you wish to enable this, you will need:

-  the email address that will receive the journalist alerts
-  the *Journalist Alert Public Key*
-  the *Journalist Alert Public Key* fingerprint

Daily Journalist Alerts can be configured during or after installation. 

.. _ossec_guide:

OSSEC alerts
-----------------------

OSSEC is an open source host-based intrusion detection system (IDS) that
SecureDrop uses to perform log analysis, file integrity checking, policy
monitoring, rootkit detection, and real-time alerting. It is installed on
the *Monitor Server* and constitutes that machine's main function. OSSEC
works in a server-agent scheme; that is, the OSSEC server extends its
existing functions to the *Application Server* through an agent installed
on that server, covering monitoring for both machines.

In order to receive email alerts from OSSEC, you need to supply several
settings during the SecureDrop server installation:

- The email address that will receive alerts from OSSEC
- The *OSSEC Alert Public Key* and its fingerprint
- The reachable hostname of your SMTP relay
- The secure SMTP port of your SMTP relay
  (typically 25, 587, or 465; must support TLS encryption)
- An email username to authenticate to the SMTP relay
- The domain name of the email used to send OSSEC alerts
- The password of the email used to send OSSEC alerts

Email address and public key
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must specify the email and GPG public key that you'll be using to receive alerts and decrypt the alert emails. You can use a pre-existing email and GPG key or create a new one specifically for receiving these alerts. 

This could be your work email, or an alias for a group of IT admins at your organization. It helps for your mail client to have the ability to filter the numerous messages from OSSEC into a separate folder.

SMTP Relay
~~~~~~~~~~

Receiving email alerts from OSSEC requires that you have an SMTP relay to route the emails. You can use an SMTP relay hosted internally, if one is available to you, or you can use a :ref:`third-party SMTP relay such as
Gmail<ossec_gmail>`. The SMTP relay does not have to be on the same domain as the destination email address, i.e. smtp.gmail.com can be the SMTP relay and the destination address can be securedrop@freedom.press.

While there are risks involved with receiving these alerts, such as
information leakage through metadata, we feel the benefit of knowing how
the SecureDrop servers are functioning is worth it. If a third-party
SMTP relay is used, that relay will be able to learn information such as
the IP address the alerts were sent from, the subject of the alerts, and
the destination email address the alerts were sent to. Only the body of
an alert email is encrypted with the recipient's GPG key. A third-party
SMTP relay could also prevent you from receiving any or specific alerts.

The SMTP relay that you use should support SASL authentication and SMTP
TLS protocols TLSv1.2, TLSv1.1, and TLSv1. Most enterprise email
solutions should be able to meet those requirements.

The SMTP relay mail server hostname is often, but not always,
different from the SASL domain, e.g. smtp.gmail.com and gmail.com.

The SMTP and SASL settings correspond to the *outgoing* e-mail address used to
send the alerts instead of where you're receiving them. If that e-mail
is ossec@news-org.com, the SASL Username would be ``ossec`` and
the SASL Domain would be ``news-org.com``.

The settings and credentials for your SMTP relay must be provided during the SecureDrop server installation. It is better to get these right the first time rather than changing them after SecureDrop is installed. If you're not sure of the correct SMTP relay port number, you can use a simple mail client such as Thunderbird to test different settings or a port scanning tool such as nmap to see what's open. You could also use telnet to make sure
you can connect to an SMTP server, which will always transmit a reply code of 220 meaning "Service ready" upon a successful connection.

In some cases, authentication or transport encryption mechanisms will
vary and you may require later edits to the Postfix configuration
(mainly /etc/postfix/main.cf) on the *Monitor Server* in order to get
alerts to work. You can consult `Postfix's official
documentation <https://www.postfix.org/documentation.html>`__ for help,
although we've described some common scenarios in the
:ref:`troubleshooting section <troubleshooting_ossec>`.

.. _ossec_gmail:

Using Gmail for OSSEC alerts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It's possible SecureDrop to use Google's servers to deliver the
alerts, but it's not ideal from a security perspective. This option
should be regarded as a backup plan. Keep in mind that you're leaking
metadata about the timing of alerts to a third party — the alerts are
encrypted and only readable to you, however that timing may prove useful
to an attacker.

First you should `sign up for a new
account <https://accounts.google.com/SignUp?service=mail>`__. While it's
technically possible to use an existing Gmail account, it's best to
compartmentalize these alerts from any of your other activities. Choose
a strong and random passphrase for the new account.

Next, enable `Google's 2-Step Verification
<https://safety.google/authentication/>`__. This is required in order to
use SMTP with a username and password, which is needed for SecureDrop.

After enabling 2-Step Verification, you'll then need to generate a new
app password to use exclusively with SecureDrop. To do so,
`open the app password settings <https://myaccount.google.com/apppasswords>`__.
From there, click "Select App", choose "Custom", assign it a name (such as
"SecureDrop"), then click "Generate."

This will provide you with a 16-character password that you will need to use
for the SMTP settings to enable OSSEC alerts.

.. tip:: SMTP through Gmail will only work with a generated app password.
         The password for the Gmail account itself is not sufficient, and will
         not allow mail to be sent. In order to be able to create an app
         password, you must have 2-Step Verification enabled on the Gmail account.

Once the account is created you can log out and use the SASL username as your new Gmail username (without the domain), the SASL domain to be either gmail.com or your custom Google Apps domain, and then finally your SASL password when installing SecureDrop on the servers. Remember to use the app password generated from the 2-step config, as the primary account password won't work. The SMTP relay will be smtp.gmail.com and the SMTP relay port is 587.