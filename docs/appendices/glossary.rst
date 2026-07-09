Glossary
========

A number of terms used in this guide, and in the `SecureDrop workflow
diagram <what_is_securedrop>`, are specific to SecureDrop. 
The list below attempts to enumerate and define these terms.

.. _glossary_administrator:

Administrator
-------------

The Administrator installs, deploys, and maintains a SecureDrop instance. They connect to the Application and Monitor servers (using SSH) and to the Admin Interface (using Tor Browser) from an Admin Workstation. 

.. _glossary_admin_interface:

Admin Interface
---------------

The Admin Interface is the web-based interface Administrators use to add and manage SecureDrop users. It is hosted by the Application Server as an authenticated Onion Service. The Admin Interface is only accessed by an Administrator using Tor Browser on an Admin Workstation.

Please see the :doc:`relevant page</admin/reference/admin_interface>` for complete instructions on accessing and using the Admin Interface.

.. _glossary_admin_workstation:

Admin Workstation
-----------------

The Admin Workstation is a laptop running Qubes OS, initially configured as a SecureDrop Workstation but with additional tools and credentials added to allow an Administrator to install and maintain a SecureDrop instance, in particular the :doc:`securedrop-admin</admin/reference/securedrop_admin>` utility. An Admin Workstation is capable of connection to the web-based Admin Interface, and to the Application and Monitor servers using SSH.

.. _glossary_application_server:

Application Server
------------------

The Application Server is a physical computer housed on-premises running the SecureDrop server application. Based on our :doc:`recommendations</admin/installation/hardware>`, this is typically a NUC or similar Mini PC. The Application hosts
the website that Sources access (the Source Interface), the Admin Interface, and the API endpoint that SecureDrop Inbox connects to so Journalists may download and reply to submissions.

Instructions and tips for accessing the Application Server over SSH are on the :ref:`SSH access page<server SSH access>`.

.. _glossary_export_device:

Export Device
-------------

The Export Device is a physical USB flash drive used to transfer decrypted documents from a SecureDrop Workstation to a Journalist's everyday workstation, or to another computer for additional processing.

Please see the detailed security recommendations for the choice, configuration and use of your Export Device in the :doc:`journalist</journalist/journalist>` guide and in the :doc:`setup guide</admin/installation/provisioning_usb>`.

.. _glossary_journalist:

Journalist
----------

The Journalist uses SecureDrop to communicate with and download documents
submitted by the Source. Journalists do this by using SecureDrop
Inbox on a SecureDrop Workstation laptop to connect to the Application Server.

If a Journalist chooses to release any of these documents,
they can be prepared for publication on the SecureDrop Workstation before
being transferred to another computer.

Instructions for using SecureDrop as a Journalist are available in our
:doc:`Journalist Guide </journalist/journalist>`.

.. _glossary_journalist_alert_key:

Journalist Alert Key
--------------------

The Journalist Alert Public Key is used for encrypting the daily alert email
that notifies Journalists about whether or not there has been
submission activity in the past 24 hours. The Journalist uses an associated
Journalist Alert Private Key to decrypt the alerts.

.. _glossary_landing_page:

Landing Page
------------

The Landing Page is the public-facing webpage for a SecureDrop instance. This
page is hosted as a standard (i.e. non-Tor) webpage on the news organization's
website. It provides first instructions for potential Sources and includes
the the onion address for the instance's :ref:`Source Interface <glossary_source_interface>`.

.. _glossary_monitor_server:

Monitor Server
--------------

The Monitor Server is physical computer housed on-premises running the `OSSEC<https://www.ossec.net/>` intrusion detection software to monitor the Application Server and send out an email alert if something seems wrong. Like the Application server, it is typically a NUC or similar Mini PC. Only Administrators connect
to this server.

Instructions and tips for accessing the Monitor Server over SSH are on the :ref:`SSH access page<server SSH access>`.

.. _glossary_onion_service:

Onion Service
-------------

Tor Onion Services provide anonymous inbound connections to websites and other
servers exclusively over the Tor network. SecureDrop uses Onion
Services for the Admin Interface and Source Interface websites,
as well as for SSH access to the servers in SSH-over-Tor mode.

Onion Services can be only be accessed using Tor Browser. Rather than a traditional internet address, Onion Services are reached using a special onion address. For example,
``sdolvtfhatvsysc6l34d65ymdwxcujausv7k5jk4cy5ttzhjoi6fzvyd.onion`` is the onion
address for the Onion Service version of the SecureDrop website. 

Authenticated Onion Services require an additional authentication token be provided when connecting to the server. The Admin Interface, the API endpoint connected to by SecureDrop Inbox, and SSH access to the servers (in SSH-over-Tor mode) are all authenticated Onion Services.

Read more about `Onion Services in Tor's glossary
<https://support.torproject.org/onionservices/>`__.

.. _glossary_ossec_alert_key:

OSSEC Alert Key
---------------

The OSSEC Alert Public Key is the GPG key that the Monitor Server uses to encrypt e-mail alerts send to the Administrator. The Administrator uses an associated OSSEC Alert Private Key to decrypt the e-mails. 

.. _glossary_securedrop_inbox:

SecureDrop Inbox
----------------

SecureDrop Inbox is the central application on a SecureDrop Workstation. It allows Journalists to connect to their SecureDrop instance, download and decrypt messages from Sources, and compose and send replies. SecureDrop Inbox can only run on a SecureDrop Workstation.

Instructions for using SecureDrop Inbox appear in our
:doc:`Journalist Guide </journalist/journalist>`.


.. _glossary_securedrop_workstation:

SecureDrop Workstation
----------------------

The SecureDrop Workstation is a laptop running Qubes OS, with SecureDrop Inbox installed and configured to connect to a specific SecureDrop instance. It implements the unique features of Qubes OS to protect Journalists while handling submissions. Each Journalist may have their own SecureDrop Workstation, or one may be shared among several Journalists. 

Read more about :doc:`SecureDrop Workstation and Qubes OS</introduction/securedrop_workstation>`.

.. _glossary_source:

Source
------

The Source is the person who submits documents to an organization's SecureDrop and may use
SecureDrop to communicate with a Journalist. A Source will always
access SecureDrop through the Source Interface and must do so using Tor.

Instructions for using SecureDrop as a Source are available in our
:doc:`Source Guide </source/source>`.

.. _glossary_source_interface:

Source Interface
----------------

The Source Interface is the website that Sources will access to
submit documents and communicate with Journalists. This site is and Onion Service
hosted on the Application Server and can only be accessed through Tor.

Instructions for using the Source Interface are available in our :doc:`Source Guide </source/source>`.

.. _glossary_submission_key:

Submission Key
--------------

The Submission Key is the GPG keypair used to encrypt and decrypt messages and attachments sent to your SecureDrop. Because the public key and private key
must be treated very differently, we sometimes refer to them explicitly as the
Submission Public Key and the Submission Private Key.

The Submission Public Key is uploaded to your SecureDrop servers as part of
the installation process. Once your SecureDrop is online, anyone will be able
to download it.

The Submission Private Key is used to decrypt all submissions to your SecureDrop and *must be kept offline and safe*. It should only be kept in an offline virtual machine on a SecureDrop Workstation or on offline backup storage.
