SecureDrop Workstation Introduction
===================================

What is Qubes OS?
-----------------

`Qubes OS`_ is an open source, security-focused
operating system. It is very different than operating systems you may be
familiar with already, because it consists of multiple
isolated virtual machines that allow you to separate more
trusted components, files, or programs on your computer from less trusted
components, files, or programs.

Broadly speaking, this means that even if files in one of your virtual machines
are exposed to malware, files in others still have some protection, which is
not true of other operating systems.

What is SecureDrop Workstation?
-------------------------------

SecureDrop Workstation is a project that uses Qubes to make
SecureDrop faster and simpler for journalists to use.

A key feature of SecureDrop is that journalists can receive submissions from
unknown sources without risking the security of their own machines and
networks. Previously, SecureDrop accomplished this by using a physical airgap
(the *Secure Viewing Station*), meaning that to view submissions, journalists
would have to download them, transfer them to an encrypted USB drive, and
physically take that drive to a separate, non-networked computer for decryption
and viewing. SecureDrop Workstation combines all of those steps
into one workflow on one machine: a Qubes computer that
combines the *Journalist Workstation* and the *Secure Viewing Station*.

Who is behind SecureDrop Workstation?
-------------------------------------
SecureDrop and SecureDrop Workstation are open source projects of
`Freedom of the Press Foundation (FPF) <https://freedom.press/>`_, a
US-based nonprofit organization. You can support our work
by `contributing to SecureDrop <https://developers.securedrop.org/en/latest/contributing.html>`_
and by making `a donation <https://freedom.press/donate>`_.

Our work would not be possible without the larger open source community.

We're deeply grateful to the SecureDrop volunteer community for translating
our software into many languages. Their work is enabled by `Weblate <https://weblate.org/>`_,
an open source platform for continuous localization. You can `make a donation <https://weblate.org/en/donate/>`_
to support Weblate development.

Translation of SecureDrop is supported by `Localization Lab <https://www.localizationlab.org/>`_. You can
`donate <https://www.localizationlab.org/donate>`_ to support their important
work to help bring open source software into many languages.

The backbone of SecureDrop Workstation is `Qubes OS`_.
FPF has directly sponsored Qubes OS development, and we encourage you to
`donate to Qubes OS <https://www.qubes-os.org/donate/>`_ as well.

We use the `Python <https://www.python.org/>`_ programming language and many tools in its
ecosystem, which you can support by `donating to the Python Software Foundation <https://www.python.org/psf/donations/>`_.

SecureDrop Workstation VMs are powered by `Debian <https://www.debian.org/>`_ and `Fedora <https://fedoraproject.org/>`_ both
of which rely on volunteer contributions and financial support. The `GNOME <https://www.gnome.org/>`_ project acts as an umbrella for many of the individual
software components we rely on.

Finally, SecureDrop Workstation relies on many other open source projects such as
`grsecurity <https://www.grsecurity.net>`_,  `GnuPG <https://gnupg.org/>`_,
`Sequoia <https://sequoia-pgp.org/>`_, `LibreOffice <https://www.libreoffice.org/>`_,
`Audacious <https://audacious-media-player.org/>`_, `OpenPrinting <https://openprinting.github.io/>`_
and others. These projects, in turn, are built on open source foundations. Please consider
directing time and financial support wherever it can make a positive difference.

For more information on SecureDrop Workstation, see our :doc:`FAQ <../journalist/faq>`.

.. _`Qubes OS`: https://www.qubes-os.org
