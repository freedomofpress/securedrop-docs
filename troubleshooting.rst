.. _Troubleshooting:

Troubleshooting
---------------

When you're replying to Redmine via e-mail, you **must use PGP/MIME**
instead of inline PGP. The default settings for the Enigmail plugin in
Thunderbird should work.

Also, be sure that you **always sign your e-mails**. Our system will
reject them if they don't have a valid signature.

To check these settings, go to Edit > Account Settings in Thunderbird.
Navigate to the "OpenPGP Security" tab of your e-mail account. Be sure
that "Use PGP/MIME by default" is checked. You may not want to enable
"Sign messages by default" for everything, so we encourage you to add a
per-recipient rule for support@freedom.press. T

To do this, go to Enigmail > Edit Per-Recipient Rules > click Add, enter
in support@freedom.press. Set to Apply rule if "Contains" the above
address, select our Key, change all of the defaults (Encryption,
Signing, PGP/MIME) to "Always", then Click OK, and OK again. The
per-recipient rule should look like this:

|Per-recipientRule|

If you'd rather not receive e-mails for your own comments on issues,
there's a setting for that. Go to the "My account" page, select " I
don't want to be notified of changes that I make myself" under "Email
notifications" and hit Save.

When responding to issues, you should only use the "Quote" button if you
want to make an inline reply. Otherwise, hit "Edit".

There's a shortcut in the main menu called "My page". Typically, this
starts out as a list of issues that are assigned to you and issues that
have been reported to you. However, it can be personalized further to
include stuff like Documents and the latest news from your project.
