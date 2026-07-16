Frequently Asked Questions
==========================
.. _faq_physically_hosted:
Why must SecureDrop be physically hosted?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We are often asked if it is acceptable to run SecureDrop on
cloud servers (e.g. Amazon EC2, DigitalOcean, etc.) or on dedicated
servers in third-party datacenters instead of on dedicated hardware
hosted in the organization. This request is generally motivated by a
desire for cost savings and/or convenience. However: we consider it
**critical** to have dedicated physical machines hosted within the
organization for both technical and legal reasons:

* While the documents are stored encrypted at rest (via PGP) on the
  SecureDrop *Application Server*, the documents hit server memory
  unencrypted (unless the source used the GPG key provided to
  encrypt the documents first before submitting), and are then
  encrypted in server memory before being written to disk. If the
  machines are compromised then the security of source material
  uploaded from that point on cannot be assured. The machines are
  hardened to prevent compromise for this reason. However, if an
  attacker has physical access to the servers either because the
  dedicated servers are located in a datacenter or because the
  servers are not dedicated and may have another virtual machine
  co-located on the same server, then the attacker may be able to
  compromise the machines. In addition, cloud servers are trivially
  accessible and manipulable by the provider that operates them. In
  the context of SecureDrop, this means that the provider could
  access extremely sensitive information, such as the plaintext of
  submissions or the encryption keys used to identify and access
  the *Onion Services*.

* In addition, attackers with legal authority such as law
  enforcement agencies may (depending on the jurisdiction) be able
  to compel physical access, potentially with a gag order attached,
  meaning that the third party hosting your servers or VMs may be
  legally unable to tell you that law enforcement has been given
  access to your SecureDrop servers.

One of the core goals of SecureDrop is to avoid the potential
compromise of sources through the compromise of third-party
communications providers. Therefore, we consider the use of
virtualization for production instances of SecureDrop to be an
unacceptable compromise and do not support it. Instead, dedicated
servers should be hosted in a physically secure location in the
organization itself. While it is technically possible to modify
SecureDrop's automated installation process to work on virtualized
servers (for example, we do so to support our CI pipeline), doing so
in order to run it on cloud servers is at your own risk and without
our support or consent.
