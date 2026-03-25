What Is SecureDrop?
===================

SecureDrop is an open-source whistleblower submission system that media
organizations can use to securely accept documents from and communicate with
anonymous sources.

Purpose
-------

In many of the recent leak prosecutions in the United States, sources have been
investigated because authorities are able to retrieve both metadata and content
of communications from third parties like email and phone providers in secret. 
SecureDrop attempts to completely eliminate third parties from the equation so
that news organizations can challenge any legal orders before handing over any 
data.

SecureDrop also substantially limits the metadata trail that may exist from 
journalist-source communications in the first place. In addition, it attempts
to provide a safer environment for those communications than regular corporate
news networks, which may be compromised.

Another key feature of SecureDrop is that journalists can receive submissions from unknown sources without risking the security of their own machines and
networks.

How It Works
------------

Sources and journalists connect to SecureDrop using the Tor network. The SecureDrop software is running on premises on dedicated infrastructure (two physical servers and a firewall).

The following steps describe how a SecureDrop submission is submitted,
received and reviewed:

1. A source uploads a submission to the news
   organization using `Tor Browser <https://www.torproject.org/>`__.

2. A journalist connects to SecureDrop using their *SecureDrop
   Workstation*, where journalists can view the document,
   process it (e.g., to remove metadata or potential malware), print it, or
   export it to a dedicated device.

.. seealso:: Check out
          :doc:`What makes SecureDrop Unique </introduction/what_makes_securedrop_unique>`
          to read more about SecureDrop's approach to keeping sources safe.

User Roles
--------------

There are three main user roles that interact with a SecureDrop instance:

:doc:`Sources </source/source>`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A source submits documents and messages by using Tor Browser (or Tails) to access
the *Source Interface*: a public onion service. Submissions are encrypted
in place on the *Application Server* as they are uploaded.

:doc:`Journalists </journalist/journalist>`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Journalists working in the newsroom use a *SecureDrop Workstation* to connect
to their SecureDrop to communicate with Sources. Journalists
download `GPG <https://www.gnupg.org/>`__-encrypted submissions.
Apart from those deliberately published, decrypted documents are never
accessed in an Internet-connected environment.

:doc:`Admins </admin/installation/intro_for_admins>`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The SecureDrop servers are managed by a systems admin; for larger
newsrooms, there may be a team of systems admins. The admin
connects to the *Application* and *Monitor Servers* over  `authenticated onion services <https://tb-manual.torproject.org/onion-services/>`__, and manages them
using `Ansible <https://www.ansible.com/>`__.

Project History
---------------

The web application, which was originally called DeadDrop, was developed by
`Aaron Swartz <https://github.com/aaronsw>`_ 
in 2012 before his tragic death. The hardening guide and security
environment was architected by 
`James Dolan <https://github.com/dolanjs>`_. 
Investigative journalist
`Kevin Poulsen <https://github.com/klpwired>`_ 
originally managed the project. The New Yorker launched the first
implementation and branded their version StrongBox in May 2013.

In October 2013, Freedom of the Press Foundation took over management and
development of the open source project and re-named it SecureDrop. In the
project's early years at FPF, development was driven by James Dolan and
`Garrett Robinson <https://github.com/garrettr>`_. 
Today, SecureDrop is maintained by a small full-time development team at
FPF and a growing volunteer community.

Technology and Contributions
----------------------------

SecureDrop and SecureDrop Workstation are open source projects of
`Freedom of the Press Foundation (FPF) <https://freedom.press/>`_, a
US-based nonprofit organization. You can support our work
by `contributing to SecureDrop <https://developers.securedrop.org/en/latest/contributing.html>`_ and by making `a donation <https://freedom.press/donate>`_.

Our work would not be possible without the larger open source community.

`Tor <https://www.torproject.org/?>`_ provides the foundation for the the anonymizing network that allows Sources, Journalists, and Administrators to maintain their privacy while connecting to SecureDrop.

We're deeply grateful to the SecureDrop volunteer community for translating
our software into many languages. Their work is enabled by `Weblate <https://weblate.org/>`_, an open source platform for continuous localization. You can `make a donation <https://weblate.org/en/donate/>`_
to support Weblate development.

Translation of SecureDrop is supported by `Localization Lab <https://www.localizationlab.org/>`_. You can `donate <https://www.localizationlab.org/donate>`_ to support their important work to help bring open source software into many languages.

The backbone of SecureDrop Workstation is `Qubes OS <https://www.qubes-os.org>`_. FPF has directly sponsored Qubes OS development, and we encourage you to `donate to Qubes OS <https://www.qubes-os.org/donate/>`_ as well.

We use the `Python <https://www.python.org/>`_ programming language and many tools in its ecosystem, which you can support by `donating to the Python Software Foundation <https://www.python.org/psf/donations/>`_.

SecureDrop Workstation VMs are powered by `Debian <https://www.debian.org/>`_ and `Fedora <https://fedoraproject.org/>`_ both of which rely on volunteer contributions and financial support. The `GNOME <https://www.gnome.org/>`_ project acts as an umbrella for many of the individual software components we rely on.

Finally, SecureDrop Workstation relies on many other open source projects such as
`Ubuntu Server <https://www.ubuntu.com/server>`_, `grsecurity <https://www.grsecurity.net>`_, `GnuPG <https://gnupg.org/>`_,
`Sequoia <https://sequoia-pgp.org/>`_, `LibreOffice <https://www.libreoffice.org/>`_, `Audacious <https://audacious-media-player.org/>`_, `OpenPrinting <https://openprinting.github.io/>`_, `Apache <https://httpd.apache.org/>`_, `OSSEC <https://ossec.github.io/>`_, and others. These projects, in turn, are built on open source foundations. Please consider directing time and financial support wherever it can make a positive difference.

Privacy
-------

The SecureDrop application does not record your IP address, information about
your browser, computer, or operating system. Furthermore, the SecureDrop pages
do not embed third-party content or deliver persistent cookies to your browser.
The server will only store the date and time of the newest message sent from
each source. Once you send a new message, the time and date of your previous
message is automatically deleted.

Journalists are also encouraged to regularly delete all information from the
SecureDrop server and store anything they would like saved in offline storage
to minimize risk. More detailed information can be found in our
:ref:`sample privacy policy <Sample Privacy Policy>`, which we encourage news organizations using SecureDrop to adopt from when creating their own. Make sure to also follow our :ref:`best practices for creating the SecureDrop landing page <Landing Page>` so that it logs as little information as possible as well.

Security
--------

While we can't guarantee 100% security (no organization or product can), the
goal of SecureDrop is to create a significantly more secure environment for sources to share information than exists through normal digital channels. Of course, there are always risks. That said, each release of SecureDrop with major architectural changes goes through a security audit by a reputable third party security firm.

Audits
------

Before major code changes are shipped, our policy is to have SecureDrop
audited by a professional, third-party security firm. You can find a
`list of all audits <https://securedrop.org/research/#audits>`__ completed so far.

In addition to these audits, we also have a
`bug bounty program <https://bugcrowd.com/freedomofpress>`__ hosted by Bugcrowd.

Cost
----

SecureDrop is a free and open source application that costs nothing to install.
However, the application does require hardware that news organizations must
purchase, including two servers, several USB sticks, an air-gapped computer,
and a firewall.

We have created a :doc:`recommended hardware guide; </admin/installation/hardware>` following these recommendations wherever possible will minimize incompatibility risks. We are aiming to offer a set of recommendations that work for organizations at different scales.

**It is critical that the hardware is owned by the media organization and stored
on its premises in a secure space.**

The total cost of the hardware we recommend is $2,200 to $2,400, though it can
be done for less if you are willing to sacrifice size and speed on the servers
or are able to use recycled machines sourced from within your organization.

As part of priority support agreements and on a pro-bono basis for smaller news
organizations, Freedom of the Press Foundation will visit your offices, help
set up SecureDrop and train journalists to use it. (For pro-bono support, we
request that our travel costs are covered.)

Environment Overview
--------------------

Server Infrastructure
~~~~~~~~~~~~~~~~~~~~~

At SecureDrop's heart is a pair of servers: the *Application (“App”) Server*,
which runs the core SecureDrop software, and the *Monitor (“Mon”) Server*,
which keeps track of the *Application Server* and sends out alerts if there's a
problem. These two servers run on dedicated hardware connected to a dedicated
firewall appliance. They are typically located physically inside the newsroom,
and must be physically located on-site within your organization's premises.

- *Application Server*:
   An Ubuntu server running two segmented Tor hidden
   services. The source connects to the *Source Interface*, a public-facing Tor
   Onion Service, to send messages and documents to the journalist. The
   journalist connects to the *Journalist Interface*, an `authenticated Tor
   Onion Service
   <https://community.torproject.org/onion-services/advanced/client-auth/>`__, to
   download encrypted documents and respond to sources.
- *Monitor Server*:
   An Ubuntu server that monitors the *Application Server*
   with `OSSEC <https://www.ossec.net/>`__ and sends email alerts.

The servers connect to the network via a dedicated hardware firewall.

Application Environment
~~~~~~~~~~~~~~~~~~~~~~~

The SecureDrop application environment consists of at least one laptop,
in addition to the servers described above:

- *SecureDrop Workstation:*
   The laptop used by Journalists to download encrypted documents
   and respond to sources, and used by Administrators to perform maintenance on the servers. 

Operation
---------

Planning & Preparation
~~~~~~~~~~~~~~~~~~~~~~

Setting up SecureDrop is a multi-step process. Before getting started, you
should make sure that you're prepared to operate and maintain it. You'll need
a systems admin who's familiar with Linux, the GNU utilities, and the
Bash shell. You'll need the :doc:`hardware </admin/installation/hardware>` 
on which SecureDrop runs — this will normally cost $2000-$3000. The journalists
in your organization will need to be trained in the operation of SecureDrop,
and you'll need to publish and promote your new SecureDrop instance afterwards —
using your existing websites, mailing lists, and social media.

It is recommended that you have all of this planned out before you get started.
If you need help, contact the `Freedom of the Press Foundation
<https://securedrop.org/help>`__ who will be glad to help walk you through
the process and make sure that you're ready to proceed.

Technical Setup
~~~~~~~~~~~~~~~

Once you are familiar with the architecture and have all the hardware,
:doc:`setting up SecureDrop </admin/installation/install>` will take at
least a day's work for your admin. We recommend that you set aside at least
a week to :ref:`complete and test <Deployment>` your setup.

Provisioning & Training
~~~~~~~~~~~~~~~~~~~~~~~

Once SecureDrop is installed, journalists will need to be provided with
accounts, two-factor credentials, workstations, and so on — and then
:doc:`trained </appendices/training_schedule>` to use these tools safely and reliably. You will probably also need to train additional backup admins so that you can be sure that your SecureDrop setup keeps running even when your main admin is on holiday.

Introducing staff to SecureDrop takes half a day. Training a group to use
SecureDrop proficiently takes at least a day — and a single trainer can only
work with so many people at once. You will probably need to run several
training sessions to instruct an entire newsroom. Depending on staff
availability, training and provisioning may take a week or more. If you have
multiple offices, training will need to happen at each location. Again, the
`Freedom of the Press Foundation <https://securedrop.org/help>`__ are happy to
help you plan and train your team.

Going Public
~~~~~~~~~~~~

Once you have a SecureDrop instance and your team knows how to use it, you
should test it thoroughly and then tell the world. The `Freedom of the Press
Foundation <https://securedrop.org/help>`__ are happy to help you check that
your SecureDrop setup is up-to-code and properly grounded. After that you'll want
to check out the :ref:`best practices <Landing Page>` for your
SecureDrop *Landing Page* and our guide to
:doc:`promoting your SecureDrop instance </admin/deployment/getting_the_most_out_of_securedrop>`.

.. |SecureDrop architecture highlevel overview diagram| image:: /diagrams/securedrop_overview_highlevel.png
  :width: 100%

Sharing Access
--------------

With Other Journalists In Your Organization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
While SecureDrop supports having multiple journalist accounts for the document
interface, all accounts will access the same inbox. To avoid confusion, we
recommend news organizations assign 1-3 journalists to regularly check
SecureDrop and make sure that they all are in contact as to who is responsible
for responding to each source. 

With Other Organizations
~~~~~~~~~~~~~~~~~~~~~~~~

Currently you cannot use SecureDrop with multiple organizations for security
reasons. One of the benefits of SecureDrop is that it completely eliminates
third parties from your communication channel. The media organization owns and
operates the server that both the source and journalist connect to.

Any legal request or order has to be served on the media organization operating
the SecureDrop server, giving them a chance to challenge it before handing over
any data. If a third party operated a SecureDrop server which multiple
organizations used, a legal order could be served on the operator without the
media organizations knowing.
