Tor Proof-of-Work Defense on the *Source Interface*
===================================================

The SecureDrop *Source Interface* is served as an onion service with an
``.onion`` URL, requiring Tor Browser to access it over the Tor network.  Tor is
sometimes targeted for denial-of-service (DoS) attacks that can `slow down the
Tor network as a whole <https://blog.torproject.org/tor-network-ddos-attack/>`_
as well as burden individual onion services, including SecureDrops.

Tor now includes a `proof-of-work (PoW) defense
<https://onionservices.torproject.org/technology/pow/#general-questions>`_
against denial-of-service attacks that can be turned on for individual onion
services.  As of SecureDrop 2.9.0, new SecureDrops have this feature enabled by
default, and we encourage all SecureDrop administrators to turn it on for their
instances.  While this measure can't speed up the Tor network as a whole if it's
slow, it can protect your SecureDrop from being attacked specifically; and more
onion services running with this feature helps improve the resilience of the Tor
network.


.. _enable_tor_pow:

Enabling the proof-of-work defense
----------------------------------

If you're :doc:`installing SecureDrop for the first time
<../installation/install>`, the proof-of-work defense will be enabled by
default, unless you :ref:`explicitly disable it <disable_tor_pow>`.

To enable it on an existing SecureDrop instance, on the *Admin Workstation*:

.. code:: sh

  securedrop-admin sdconfig

The prompts will include::

    Enable Tor's proof-of-work defense against denial-of-service attacks for the Source Interface?: yes

Type <Enter> to accept the new default ``yes`` value.  When you finish the
prompts, rerun the installation script::

    securedrop-admin install

The Tor configuration will be updated to enable the proof-of-work defense.  When
the script finishes, confirm that you can access the Source Interface.


.. _disable_tor_pow:

Disabling the proof-of-work-defense
-----------------------------------

Follow the instructions above for :ref:`enabling the proof-of-work defense
<enable_tor_pow>`, but answer ``no`` at the prompt::

    Enable Tor's proof-of-work defense against denial-of-service attacks for the Source Interface?: no