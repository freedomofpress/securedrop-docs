Troubleshooting
===============

Always sign and encrypt your emails
-----------------------------------

To maintain the security of conversations around support requests, you
should always sign and encrypt your email to support@freedom.press if
you have a Redmine account.

Our server is configured to reject emails that do not have a valid
signature. We cannot reject unencrypted emails due to a limitation in
the Redmine-OpenPGP plugin we are using, but we are logging them and
will harangue you if you send us unencrypted email.

PGP/MIME vs. inline PGP
-----------------------

When you're replying to Redmine via email, you **must use PGP/MIME**
instead of inline PGP. The default settings for the Enigmail plugin in
Thunderbird should work.

Check your mail client and GPG integration tool's settings to ensure you
are using PGP/MIME. One notable exception to this is Mailvelope, which
cannot send PGP/MIME (you shouldn't be using Mailvelope anyway).

Per-recipient Rules
-------------------

You may not want to use these settings (PGP/MIME, always sign) for all
of your email. If not, most email clients support the concept of
"Per-recipient rules", which allow you to configure specific settings on
a per-recipient basis.

Below is an example of how to configure a per-recipient rule for
support@freedom.press in Thunderbird/Enigmail. If you are not using
Thunderbird/Enigmail, consult your mail client's documentation.

Thunderbird
^^^^^^^^^^^

To check your global settings, go to Edit > Account Settings in
Thunderbird. Navigate to the "OpenPGP Security" tab of the email account
you are using for your Redmine account. Be sure that "Use PGP/MIME by
default" is checked. If you do not want to enable "Sign messages by
default" for everything, you should add a per-recipient rule for
support@freedom.press.

To do so, go to Enigmail > Edit Per-Recipient Rules > Add, and enter
support@freedom.press. Set to Apply rule if "Contains" the above
address, select our key, change all of the defaults (Encryption,
Signing, PGP/MIME) to "Always", then click OK, and OK again. The
per-recipient rule should look like this:

|Per-recipientRule|

.. |Per-recipientRule| image:: images/per_recipient_rule.png
