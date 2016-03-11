Setting up Encrypted Email
==========================

In order to use this encrypted email workflow, you need to:

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

Now, import the public key for our Redmine server into your local GPG
keyring. It is available on
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

.. |PGPicon| image:: images/pgp_icon.png
.. |PGPsettings| image:: images/pgp.png
