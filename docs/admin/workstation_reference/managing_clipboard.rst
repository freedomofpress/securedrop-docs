Managing Clipboard Access
=========================

Every VM in Qubes has its own clipboard, similar to the clipboard of a Mac, Windows or Linux computer. For example, if you used the default ``work`` VM to browse the web and wanted to copy text from one browser window to another, you would use the ``Ctrl+C`` and ``Ctrl+V`` keyboard shortcuts to copy and paste. This type of clipboard usage -- copy and paste in the same VM -- also works in all VMs that are part of SecureDrop Workstation.

In addition, Qubes supports copying information *between* VMs. This is done by using `special keyboard shortcuts <https://www.qubes-os.org/doc/copy-paste/>`_, ``Ctrl+Shift+C`` and ``Ctrl+Shift+V``, in a four-step process. By default, this is disabled for all VMs that are part of SecureDrop Workstation, consistent with the `principle of least privilege <https://en.wikipedia.org/wiki/Principle_of_least_privilege>`__.

As an administrator, you should be aware of the following risks related to clipboard access before changing the default configuration:

1. It is dangerous to copy untrusted, unsanitized content *into* a secure environment. What looks like plain text may contain character sequences that exploit security vulnerabilities in the target environment.
2. The four-step process described above can be difficult to follow, and it is easy to make an operational mistake, such as pasting a password into a message to a source, or into a window belonging to a VM with network access.
3. Like any other part of the operating system, the implementation of Qubes clipboard itself may contain undiscovered security vulnerabilities that an adversary could exploit in an attempt to exfiltrate information.

With these considerations in mind, there are use cases where clipboard access may be an important part of your regular use of SecureDrop Workstation. For example:

- You may want to copy passwords from a password manager to the SecureDrop App;
- You may want to copy a message you received via SecureDrop into a secure messaging app like Signal, to share it with another journalist.

To support these use cases, SecureDrop Workstation allows you to grant granular access to the ``sd-app`` clipboard (via the cross-VM clipboard) to selected VMs.

Configuring clipboard access to ``sd-app``
------------------------------------------

The process for permitting the one-directional copying of passwords from a password manager in ``vault`` to the SecureDrop App is :ref:`outlined in the installation docs <Password Management Section>`. In general, clipboard access to SecureDrop Workstation VMs is governed by *tags* that can be applied in ``dom0`` to selected VMs:

- the tag ``sd-send-app-clipboard`` can be used to tag a VM that should be able to send its clipboard contents *to* ``sd-app`` via the cross-VM clipboard;
- the tag ``sd-receive-app-clipboard`` can be used to tag a VM that should be able to receive its clipboard contents *from* ``sd-app`` via the cross-VM clipboard.

You can configure these tags for a given VM from the ``dom0`` terminal. Changes to tags take effect immediately, and any VM can have multiple tags.

.. important::

   Make sure you fully understand technical and operational security risks before permitting clipboard access to any VM. The "send" and "receive" tags are separate so you can set up only the clipboard direction you need to support a given use case.

   We recommend adding a note about any changes to the clipboard configuration to your internal documentation for SecureDrop. If you are unsure how to configure the clipboard to support a specific use case, please do not hesitate to contact us for assistance.

The general syntax for adding a tag is as follows, substituting ``<VM name>`` with the name of an existing VM in the system you want to grant access to the clipboard:

.. code-block:: sh

   qvm-tags <VM name> add <tag name>

Confirm that the command was successfully applied using the ``ls`` subcommand:

.. code-block:: sh

   qvm-tags <VM name> ls

The syntax for revoking a tag is as follows:

.. code-block:: sh

   qvm-tags <VM name> del <tag name>

As before, confirm the operation via the ``ls`` subcommand.

As an example, if you had a custom VM called ``work-signal`` that runs the Signal messenger, and you wanted to copy and paste messages from the SecureDrop App *into* Signal (and potentially other applications in that VM) but not *out* of Signal into the SecureDrop App, you would issue the following commands:

.. code-block:: sh

   qvm-tags work-signal add sd-receive-app-clipboard
   qvm-tags work-signal ls

To review current clipboard permissions, you can use ``qvm-ls`` to print out a list of VMs that can receive or send clipboard contents:

.. code-block:: sh

   qvm-ls --tags sd-receive-app-clipboard
   qvm-ls --tags sd-send-app-clipboard
