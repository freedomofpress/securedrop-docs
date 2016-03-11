Troubleshooting
===============

.. todo:: Should some of this stuff go in the setup doc instead?

When you're replying to Redmine via email, you **must use PGP/MIME**
instead of inline PGP. The default settings for the Enigmail plugin in
Thunderbird should work.

Also, be sure that you **always sign your emails**. Our system will
reject them if they don't have a valid signature.

To check these settings, go to Edit > Account Settings in Thunderbird.
Navigate to the "OpenPGP Security" tab of your email account. Be sure
that "Use PGP/MIME by default" is checked. You may not want to enable
"Sign messages by default" for everything, so we encourage you to add a
per-recipient rule for support@freedom.press. T

To do this, go to Enigmail > Edit Per-Recipient Rules > click Add, enter
in support@freedom.press. Set to Apply rule if "Contains" the above
address, select our Key, change all of the defaults (Encryption,
Signing, PGP/MIME) to "Always", then Click OK, and OK again. The
per-recipient rule should look like this:

|Per-recipientRule|

.. |Per-recipientRule| image:: images/per_recipient_rule.png
