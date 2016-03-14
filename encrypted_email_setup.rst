Setting up Encrypted Email
==========================

In order to use this encrypted email workflow, you need to:

1. Provide **your public key** to the support server
2. Import the **server's public key** into your local GPG keyring.

The following documentation explains how to perform these steps to get
the encrypted email workflow working. This documentation assumes you are
familiar with PGP/GPG. We encourage you to use your preferred GPG key
management tool and email client.

If you do not know how to do things like import and export GPG keys,
the encrypted email workflow is not for you. We recommend you stick to
the :doc:`web-based workflow <using_redmine>`.

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

Importing the server's public key
---------------------------------

Now, import the public key for our Redmine server into your local GPG
keyring. It is available on the right hand side of the page in the
column with the heading "Redmine Server (support@freedom.press)", in the
text box labeled "Public PGP key".

Select the entire public key and copy it to your clipboard. Import the
copied public key into your local GPG keyring.

The key is also available on the keyservers (fingerprint:
``5F7B9C54E9B27164909EDA6693359153A3BD4560``), or you can download it
`here <https://freedom.press/sites/default/files/redmine_key.asc>`_.

.. todo:: The following key is a testing key, so this command is only a
   placeholder until the transition to a live key. DO NOT upload this key to
   keyservers.

.. todo:: Add section on testing encrypted email after setting it up

.. |PGPicon| image:: images/pgp_icon.png
.. |PGPsettings| image:: images/pgp.png
