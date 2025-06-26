How To Submit
=============

.. note::

   This guide provides an introduction to using SecureDrop as a source.
   It is not exhaustive, it does not address ethical or legal dimensions of
   whistleblowing, and it does not speak to other methods for confidentially
   communicating with journalists. Please proceed at your own risk. For additional
   background, also see the Freedom of the Press Foundation guide, `How to Share Sensitive
   Leaks With the Press <https://freedom.press/news/sharing-sensitive-leaks-press/>`__.


.. warning:: Freedom of the Press Foundation has no access to any other
   organization's SecureDrop instance, and cannot assist directly in your
   communications with them. If you plan to use SecureDrop to maintain your
   anonymity, you should not discuss your own use of it with others via unsafe
   methods, including email to Freedom of the Press Foundation.

Making Your First Submission
----------------------------

Open Tor Browser and navigate to the .onion address for the SecureDrop you wish
to make a submission to. The page will invite you to get started with your
first submission or to log in. It should have a logo specific to the organization
you are submitting to.

|Source Interface with JavaScript Disabled|

If this is the first time you're using Tor Browser, it's likely that you
have JavaScript enabled and that the Tor Browser's security level is set
to "Low". In this case, there will be a purple warning banner at the top of
the page that encourages you to disable JavaScript and change the security
level to "Safest".

|Source Interface Security Slider Warning|

Click the **Security Level** link in the warning banner, and a message bubble
will pop up explaining how to increase the security level to **Safest**.

|Fix JavaScript warning|

1. Click the shield icon in the toolbar
2. Click **Settings…**
3. If the current level is not already set to **Safest**, click **Change…**
4. Select **Safest**
5. Select **Save and restart** for the changes to take effect
6. Navigate back to the Source Interface for the SecureDrop for which you wish to submit

|Security Slider|

.. note::

   The "Safest" setting disables the use of JavaScript on every page you visit
   using Tor Browser, even after a browser restart. This may cause other
   websites you visit using Tor Browser to no longer work correctly, until
   you adjust the Security Level again. We recommend keeping the setting at
   "Safest" during the entirety of the session in which you access an
   organization's SecureDrop instance.

Once you return to the SecureDrop page, it should stop displaying
the warning. If this is the first time you are using SecureDrop,
click the **Get Started** button.

|Source Interface with JavaScript Disabled|

You should now see a screen that shows the unique codename that SecureDrop has
generated for you. Note that your codename will not be the same as the codename
shown in the image below. It is extremely important that you both remember this
code and keep it secret. After submitting documents, you will need to provide
this code to log back in and check for responses.

|Memorizing your codename|

The best way to protect your codename is to memorize it. If you cannot memorize
it right away, we recommend writing it down and keeping it in a safe place at
first, and gradually working to memorize it over time. Once you have memorized
it, you should destroy the written copy.

.. tip:: For detailed recommendations on best practices for managing your
   passphrase, check out :doc:`../passphrase_best_practices`.

Once you have generated a codename and put it somewhere safe, click
**Submit Documents**.

You will next be brought to the submission page, where you may
upload a document, enter a message to send to journalists, or both. You
can only submit one document at a time, so you may want to combine
several files into a ZIP archive if necessary. The maximum submission
size is currently 500MB. If the files you wish to upload are over that
limit, we recommend that you send a message to the journalist explaining
this, so that they can set up another method for transferring the
documents.

|Submit a document|

When your submission is ready, click **Submit**.

After clicking **Submit**, a confirmation page should appear, showing
that your message and/or documents have been sent successfully. On this
page you can make another submission or view responses to your previous
messages.

|Confirmation page|

Once you are finished submitting documents, be certain you have saved your
secret codename and then click the **Log out** button.

The final step to clearing your session is to restart Tor Browser for
optimal security. After logging out, you should see a new page recommending
you to click the **New Identity** button in the Tor Browser toolbar.

|Logout|

You can either close the browser entirely or follow the instructions on the page:

1. Click on the **New Identity** button in the Tor Browser toolbar
2. Click **Yes** in the dialog box that appears to confirm you'd like to restart Tor Browser

|Restart TBB|

.. |Source Interface Security Slider Warning| image:: ../images/manual/securedrop-security-slider-warning.png
   :alt: Warning banner: Your Tor Browser's Security Level is too low.
.. |Security Slider| image:: ../images/manual/source-turn-slider-to-high.png
   :alt: Advanced Security Settings in Tor Browser.
.. |Fix JavaScript warning| image:: ../images/manual/security-slider-high.png
   :alt: Example home page displaying instructions to increase Tor Browser's Security Level.
.. |Source Interface with JavaScript Disabled|
  image:: ../images/manual/screenshots/source-index.png
     :alt: Example home page of a SecureDrop instance.
.. |Memorizing your codename|
  image:: ../images/manual/screenshots/source-generate.png
     :alt: Example welcome page displaying a codename.
.. |Submit a document|
  image:: ../images/manual/screenshots/source-submission_entered_text.png
    :alt: Example submission page, where documents and messages can be submitted.
.. |Confirmation page|
  image:: ../images/manual/screenshots/source-lookup.png
    :alt: Example submission page, displaying a confirmation message after a submission was sent successfully.
.. |Logout|
  image:: ../images/manual/screenshots/source-logout_new_identity.png
   :alt: Page displaying instructions to clear your Tor Browser session by resetting your identity.
.. |Restart TBB| image:: ../images/manual/restart-tor-browser.png
   :alt: Dialog box asking for confirmation before Tor Browser is restarted.
