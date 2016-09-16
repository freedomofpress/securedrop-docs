.. Freedom of the Press Foundation's Redmine documentation master file, created by
   sphinx-quickstart on Wed Mar  9 12:37:53 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

SecureDrop Support Documentation
================================

Overview
--------

Freedom of the Press Foundation is transitioning to a Redmine-based
ticketing system for all support requests related to SecureDrop. All
current and future SecureDrop administrators are required to use the new
support system in order to receive support from FPF staff. From now on,
the best way to get in touch with us is through our new `support site
<https://support.freedom.press>`_ or by emailing support@freedom.press.

As a current SecureDrop administrator or journalist, you will need to
spend a little time setting up an account on the new support site. This
is quick and easy - get started by :doc:`creating_your_account`.

.. note:: We recently added the ability to reach our new support site
          through a Tor onion service. It's available at
          http://support6kv2242qx.onion/

First time contacting us?
-------------------------

If you've never contacted us before, and have questions about:

* Installing SecureDrop
* An existing SecureDrop installation that was set up without our involvement
* Inclusion in the `SecureDrop Directory <https://securedrop.org/directory>`_

then please contact us through the :doc:`general_support` channel.

Using the support site
----------------------

Once your account has been created, there are two workflows you can use:
a web-based workflow, and an email-based workflow. Either workflow may
be used interchangeably. We think most people will want to use the
web-based workflow, which is documented in :doc:`using_redmine`. You can
learn more about configuring and using the optional email-based workflow
in the :doc:`Encrypted Email Overview <encrypted_email_overview>`.

.. toctree::
   :caption: Web-based Workflow
   :name: Web-based Workflow

   creating_your_account
   using_redmine
   troubleshooting

.. toctree::
   :caption: Email-based Workflow
   :name: Email-based Workflow

   encrypted_email_overview
   encrypted_email_do_not_want
   encrypted_email_setup
   encrypted_email_troubleshooting

.. toctree::
   :caption: General Support
   :name: General Support
   :hidden:

   general_support

Motivation
----------

Our goal with this new support system is to simplify and centralize the
process of providing support to the administrators who maintain and the
journalists who use SecureDrop. Administering a SecureDrop instance is
hard work, and we hope that this new system will make us more effective
in providing help to you.

.. note:: Don't hesitate to let us know if you have any feedback on the
          new support system.

          If you already have an account on the support site, create a new issue
          in your project to provide feedback. Otherwise, use the
          :doc:`general_support` channel.
