.. _Getting Support:

Getting Support
===============

There are a several support options available if you need help installing
SecureDrop, or are looking for help with your existing SecureDrop instance.

.. note::

   If your installation is up and running, we recommend that you
   `submit your SecureDrop to the SecureDrop directory <https://securedrop.org/directory/submit/>`__.
   This also serves as a first introduction to the SecureDrop team.

.. _using_redmine:

Support Portal
^^^^^^^^^^^^^^

Because of the sensitive nature of SecureDrop-related communications, we
recommend that you request an account on the support portal at
https://support.freedom.press/.

As a member of the support portal, you will receive notifications regarding
SecureDrop releases and security advisories, and you will be able to open
tickets to request technical support.

Membership in the support portal is free of charge and granted at Freedom of
the Press Foundation's sole discretion. To reach out regarding a membership
request, please use the `contact form <https://securedrop.org/help/>`__.

While we will provide technical assistance within reason and at our discretion, we
encourage you to consider a paid support agreement to receive priority support,
staff training, or installation help. Visit the
`Priority Support <https://securedrop.org/priority-support/>`_
and `Training <https://securedrop.org/training/>`_ pages on the SecureDrop website
for more information.

Initial onboarding
------------------

Please start by submitting a request through the `SecureDrop Contact Form`_.

.. _SecureDrop Contact Form: https://securedrop.org/help

Please provide an email address so we can reply back to you. We'll review your
request and decide how to respond. If we decide to offer you support, we will
send you instructions for onboarding you into our support system.

Once you are initially onboarded, we will assign you to a project called
"Support Triage" where you will be able open new issues. Any issues that you
create will only be visible to Freedom of the Press Foundation staff and you.

Creating your Account
---------------------

To get started, register your account on the `Registration Page`_.

Make sure you

* Choose a strong passphrase;
* Use an email address that you check frequently;
* Pick a username that helps us identify you at a glance. We recommend using
  your first initial and your last name (e.g. "jsmith" for John Smith).

.. _Registration Page: https://support.freedom.press/account/register

|Registration|

We manually confirm each new account. After submitting your registration, it
will be reviewed by our team. When approved, you will receive an email
notification stating that your account has been activated.

|Activation|

After your account is activated, you can login and continue to the next step.

.. |Registration| image:: images/support/register.png
.. |Activation| image:: images/support/activated.png

.. _Logging In:

Logging In
----------

Once your account has been activated, go to the `Support Page`_ and log
in with your new account.

.. _Support Page: https://support.freedom.press

|Login|

After logging in, you will be be taken to the Home page. In the top
menu bar, you will see helpful links to a variety of resources. The most
important links are:

* **Projects**: The list of projects you have access to.
* **My Page**: An overview of the open issues that were either created
  by you or are assigned to you.

|Home|

Click on **Projects** in the top menu bar. You'll see a project for your
SecureDrop instance listed underneath the parent SecureDrop project.
Only Freedom of the Press Foundation staff and people within your
organization have access to your instance's project.

|Projects|

Click on the project link. You'll be shown an **Overview** of the project and
all of its issues.

|Overview|

To view the list of open issues, click the **Issues** button to open the issues
pane.

|Issues|

.. |Login| image:: images/support/login.png
.. |Home| image:: images/support/home.png
.. |Projects| image:: images/support/projects.png
.. |Overview| image:: images/support/overview.png
.. |Issues| image:: images/support/issues.png


Onboarding Issue
----------------

By the time you log in, we'll have created an initial issue for
onboarding, called "Onboarding Verification". Please write a reply on
this issue, which will let us know that you succeeded in logging in and
finding your project page.

|OnboardingIssue|

To write a reply, click **Edit** button at the top of the issue.
Write your reply in the Notes text box, then click **Submit**.

|EditIssue1|

We'll reply to the issue and start a little exchange to explain some
features of the platform and answer any questions you might have. The
goal here is to make sure you're comfortable and confident using the new
Support site.

|EditIssue2|

Once we're satisfied you're ready to use the new site, we'll close the
issue.

Once we're finished with the onboarding issue, you're ready to use the Support
site. If you want to additionally set up encrypted email notifications, head
over to the :ref:`Encrypted Email Overview <encrypted_email_overview>`.

The rest of this documentation is for your reference.

.. |OnboardingIssue| image:: images/support/onboarding_issue.png
.. |EditIssue1| image:: images/support/edit_issue_1.png
.. |EditIssue2| image:: images/support/edit_issue_2.png

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

.. _encrypted_email_overview:

Encrypted Email
---------------

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

.. |FilteredEmail| image:: images/support/filtered_email.png

Setting up Encrypted Email
~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to use this encrypted email workflow, you need to:

1. Provide **your public key** to the support server
2. Import the **server's public key** into your local GPG keyring.

The following documentation explains how to perform these steps to get
the encrypted email workflow working. This documentation assumes you are
familiar with PGP/GPG. We encourage you to use your preferred GPG key
management tool and email client.

If you do not know how to do things like import and export GPG keys,
the encrypted email workflow is not for you. We recommend you stick to
the :ref:`web-based workflow <using_redmine>`.

Providing your public key
~~~~~~~~~~~~~~~~~~~~~~~~~

Start by navigating to
`support.freedom.press/pgp <https://support.freedom.press/pgp>`_ or
click on the "PGP" menu option in the upper right corner of the support window.

|PGPMenu|

In the PGP management window you will see two columns: one for your
public key on the left, and one with the server's public key on the
right.

|PGPUpload|

To provide your public key, start by exporting an ASCII-armored copy of
your public key. Paste your armored public key into the empty text box
on the left and hit **Save**.

|PGPSave|

Importing the server's public key
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now, import the public key for our Redmine server into your local GPG
keyring. It is available on the right hand side of the page in the
column with the heading "Redmine Server (support@freedom.press)", in the
text box labeled "Public PGP key".

Select the entire public key and copy it to your clipboard. Import the
copied public key into your local GPG keyring.

You can `download the key <https://freedom.press/documents/37/redmine_public_key.asc>`_ 
or fetch it from a `keyserver <https://keys.openpgp.org/vks/v1/by-fingerprint/D0E0B2F2B71BA4E48278037D9EA33029E9FBBA2E>`_ (fingerprint:
``D0E0B2F2B71BA4E48278037D9EA33029E9FBBA2E``).


.. todo:: Add section on testing encrypted email after setting it up

.. |PGPMenu| image:: images/support/pgp_menu.png
.. |PGPUpload| image:: images/support/pgp_upload.png
.. |PGPSave| image:: images/support/pgp_save.png


Community Based Support
^^^^^^^^^^^^^^^^^^^^^^^

The `SecureDrop forum <https://forum.securedrop.org/>`_ is a good place to
discuss SecureDrop and to get help from the international community of
SecureDrop users and developers.

You can also connect directly with the SecureDrop development team and the larger
SecureDrop community using the
`SecureDrop Gitter channel <https://gitter.im/freedomofpress/securedrop>`_ .

.. warning::

   Remember that both the SecureDrop forum and the Gitter channel are
   public. **Do not post any sensitive information through public channels.**

Troubleshooting
^^^^^^^^^^^^^^^

Creating a new issue
--------------------

To create a new issue, click **New issue** and fill out the Subject and
Description fields. All other fields can be left blank, although you can
assign a priority if you want. When we see the issue, we will respond
and assign it to the appropriate person. If we're waiting for a reply
from someone in your organization, we may assign it back to you.

|NewIssue|

.. |NewIssue| image:: images/support/new_issue.png

Creating a new issue via email
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sending an email to support@freedom.press will automatically create a
new issue in your project, using the subject line of the email for the
Subject and the body of the email for the Description.

Enabling two-factor authentication
----------------------------------
Two-factor authentication (2FA) protects your account in the event that your
passphrase is compromised. Once enabled, you will be prompted to provide a
one-time six digit code every time you log into the support portal, in addition
to your passphrase.

To enable 2FA:

1. Choose an application to generate two-factor codes. We recommend the
   `FreeOTP app <https://freeotp.github.io/>`__ for Android or iOS, but any
   app that implements the Time-based One Time Password (TOTP) algorithm
   should work.
2. If you are not already logged in, log into the support portal.
3. Click **My account** in the top right corner to navigate to your
   account settings. On the settings page, click **Enable authenticator app**.

   |2FA setting|

4. You will see a page that shows a QR code, similar to the one below.
   Use your 2FA app's QR code scanning function to scan the code on the page,
   or manually enter the 2FA secret (called a "plain text key" here) in the 
   app.

   |2FA example|

5. Select the account you have just added to your 2FA app, and generate a new
   one-time token using the app. Enter it on the webpage and click 
   **Activate**.
6. You should see a success message like the one below. Follow the 
   recommendation and click **generate backup codes**.

   |2FA success|

7. You will see a list of codes like the one below. Each code 
   (e.g., ``ec96 a5d7 c678``) can be used once *instead of* a 2FA code
   during the login sequence. Store these codes securely and separately
   from your passphrase. The recommended method is to keep a printout of
   the recovery codes in a secure location.

   |2FA backup codes|

8. Log out of your account and attempt to log in again. After entering your
   passphrase, you will additionally be prompted for a two-factor code, which
   you can generate using your 2FA app.

If you have to reset your 2FA settings at any time, you can use a recovery 
code. Once you are logged in, disable and then re-enable 2FA from your account
settings.

Please do not hesitate to open a ticket or email us at
securedrop@freedom.press (`GPG-encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__)
if you encounter difficulties using 2FA on the support portal.

.. |2FA setting| image:: images/support/account_settings_with_2fa_highlighted.png
.. |2FA example| image:: images/support/qr_code_example.png
.. |2FA success| image:: images/support/2fa_success.png
.. |2FA backup codes| image:: images/support/2fa_backup_codes.png

Other account settings
----------------------
In addition to two-factor authentication, you can also configure your local
time zone in the account settings.

We encourage you to leave the notification setting as the default:
"For any event on all my projects".

|Account settings|

.. |Account settings| image:: images/support/account_settings.png

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
-----------

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

.. |Per-recipientRule| image:: images/support/per_recipient_rule.png


Additional Documentation
------------------------

For more information on using Redmine, consult their `User Guide
<https://www.redmine.org/projects/redmine/wiki/User_Guide>`_.