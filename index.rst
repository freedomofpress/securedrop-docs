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
support system in order to receive support from FPF staff.

From now on, the best way to get in touch with us is through our new
`support site <https://support.freedom.press>`_ or by emailing
support@freedom.press.

As a current SecureDrop administrator or journalist, you will need to
spend a little time setting up an account on the new support site. This
process is quick and easy. Get started by :ref:`Creating your Account`.

Once your account has been created, there are two workflows you can use:
a web-based workflow, and an email-based workflow. Either workflow may
be used interchangeably. We think most people will want to use the
web-based workflow, which is documented in :ref:`Using Redmine`. You can
learn more about configuring and using the optional email-based workflow
in :ref:`Encrypted Email Workflow`.

.. toctree::
   :caption: Getting Started
   :name: Getting Started

   creating_your_account
   logging_in
   onboarding_issue
   key_features
   encrypted_email_workflow
   troubleshooting

First time contacting us?
-------------------------

If you've never contacted us before, and have questions about:

* Installing SecureDrop
* An existing SecureDrop installation that was set up without our involvement
* Inclusion in the `SecureDrop Directory <https://securedrop.org/directory>`_

then please contact us through the :ref:`General Support` channel.

.. toctree::
   :caption: General Support
   :name: General Support

   general_support

Motivation for the new support system
-------------------------------------

Our goal with this new system is to simplify and centralize the process
of providing support to the administrators who maintain and the
journalists who use SecureDrop.

Previously, we had asked people to use encrypted email to send us
support requests us. This system rapidly fell apart as we began to
support an increasing number of SecureDrop installations. The email
threads were often difficult to follow and were not searchable due to
encryption. It was difficult for all parties involved to keep the right
people cc'ed, and looping in additional recipients often lead to
headaches in terms of GPG key management. It was often a challenge to
find the information we were looking for, or remember where the
conversation left off, especially when conversation threads also spread
out across other encrypted communications channels, like OTR or Signal.

By moving support requests into Redmine issues, we can keep much better
track of the status of an issue, the person responsible for it, and make
sure everyone is appraised of the discussion who needs to be. Reviewing
an issue's history allows someone to quickly gain a full understanding
of the problem. We can collect all of the information relevant to your
organization's deployment in one place, and it's more efficient and less
confusing for us when we're dealing with multiple conversations
simultaneously across several SecureDrop instances.

Administering a SecureDrop instance is hard work, and we hope that this
new system will make us more effective in providing help to you. Don't
hesitate to let us know if you have any feedback on the new support
system.
