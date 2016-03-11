.. _Encrypted Email Workflow:

Encrypted Email Workflow
========================

One of Redmine's strengths as a ticketing system is its powerful support
for email-based workflow. You can use email to create new issues, reply
to existing issues, and be notified of updates to issues that are
relevant to you.

While many people find email-based workflows convenient, email is
unfortunately insecure by default. Freedom of the Press Foundation takes
the security of every SecureDrop instance seriously; therefore, we
require the use of encryption for support requests because they may
contain sensitive information about your SecureDrop instance.

The web interface workflow is automatically encrypted thanks to HTTPS.
Supporting a secure email-based workflow is more difficult because email
is unencrypted by default. Our solution is to combine Redmine's
excellent email-based workflow with OpenPGP encryption, which we already
use to communicate with many SecureDrop administrators and journalists.

What if I don't want to use encrypted email?
--------------------------------------------

That's fine! You can do everything through the web interface that you
can do through email.

If you don't do the setup process for receiving encrypted emails from
our support server, you will still receive email alerts for changes to
issues in your project, but the content of the email will not be
included. This is called a "filtered" email.

|FilteredEmail|

We encourage you to use these filtered emails as a reminder to login to
your Redmine account and check the content of the corresponding updates
to an issue through the web interface. We like to think of them as "poor
man's push notifications".

.. note:: We welcome feedback on how we could make notifications for
          this Redmine system more convenient for you.

Setup
-----

At a high level, in order to use this encrypted email workflow, you need
to:

1. Provide **your public key** to the support server
2. Import the **server's public key** into your local GPG keyring.

The following documentation explains how to perform these steps to get
the encrypted email workflow working. It assumes you have some
familiarity with the concepts used by PGP. It also assumes you are using
Thunderbird+Enigmail for OpenPGP-encrypted email.

Providing your public key
-------------------------

Start by navigating to
`support.freedom.press/pgp <https://support.freedom.press/pgp>`_ or
click the key icon in the upper right corner of the support window.

|PGPicon|

In the PGP management window you will see two columns: one for your
public key on the left, and one with the server's public key on the
right.

|PGPsettings|

To provide your public key, start by exporting an ASCII-armored copy of
your public key. Paste your armored public key into the empty text box
on the left and hit **Save**.

.. todo::  provide instructions for exporting ascii-armored copy, or provide
   link to instructions on another site

Importing the server's public key
---------------------------------

Now, import the public key for our Redmine server. It is available on
the right hand side of the page. Start by selecting the entire public
key and copying it to your clipboard.

.. todo::  Provide a variety of mechanisms for importing the public key, either
   described here or with links to external documentation.

and then in Thunderbird navigate to Enigmail menu > Key Management >
Edit > and select Import Keys from Clipboard. You may also use the
following command:

.. todo:: The following key is a testing key, so this command is only a
   placeholder until the transition to a live key. DO NOT upload this key to
   keyservers.

    gpg --keyserver keys.gnupg.net --recv-keys 
    5F7B9C54E9B27164909EDA6693359153A3BD4560

The key can be downloaded `at this
link <https://freedom.press/sites/default/files/redmine_key.asc>`_.

.. todo:: Add section on testing encrypted email after setting it up

.. |FilteredEmail| image:: images/filtered_email.png
.. |Per-recipientRule| image:: images/per_recipient_rule.png
.. |PGPicon| image:: images/pgp_icon.png
.. |PGPsettings| image:: images/pgp.png
