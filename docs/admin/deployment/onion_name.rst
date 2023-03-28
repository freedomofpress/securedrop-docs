Getting An Onion Name for Your SecureDrop
-----------------------------------------

What Are Onion Names?
^^^^^^^^^^^^^^^^^^^^^

Onion names are short, memorable addresses that visitors can use to access an 
onion service (e.g., a news organization's SecureDrop) using Tor Browser. 

Imagine a SecureDrop instance for a new organization called
*The New York World* with a .onion address like this:

`sdolvtfhatvsysc6l34d65ymdwxcujausv7k5jk4cy5ttzhjoi6fzvyd.onion`

An onion name for this SecureDrop instance could be:

`nyworld.securedrop.tor.onion`

The general format for a SecureDrop onion name is:

`<organization>.securedrop.tor.onion``

How They Work
^^^^^^^^^^^^^

Onion names are supported in the desktop version of Tor Browser (introduced 
in version 9.5). The mapping between onion names and the full-length .onion 
addresses is done using a custom, signed ruleset for SecureDrop instances
maintained by Freedom of the Press Foundation. The ruleset is updated
automatically by Tor Browser, and no information is sent to third party servers
when contacting a SecureDrop using an onion name.

Onion names are currently not supported by the mobile version of Tor Browser,
or by any other browser. (SecureDrop strongly recommends the use of the 
desktop version of Tor browser.)

The Tor project has committed to continued support of the onion name feature
in some form. The underlying implementation and the address format may change
in future iterations of this feature. To the extent that any changes are 
required, we will reach out to coordinate them with you.

Getting An Onion Name
^^^^^^^^^^^^^^^^^^^^^

Freedom of the Press Foundation maintains onion names for SecureDrop instances
which:

* are using v3 onion services
* are part of the SecureDrop Directory

We will generally approve onion names that meaningfully correspond to your name
or that of your organization. Please note that, to disambiguate organizations
in different countries with the same name, we may request the addition of a 
country code (e.g. `<organization>.<country code>.securedrop.tor.onion`).

If your SecureDrop instance is not part of the directory yet, you can 
:ref:`begin the process here<The SecureDrop Directory>`. In order to be
eligible for inclusion, your SecureDrop and its associated clearnet
landing page must be set up consistent with the best practices recommended
in our documentation.

If you are already part of the SecureDrop directory and would like an
Onion Name, :ref:`please contact us.<Getting Support>`

Does This Replace the Original Address?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

No, the onion name is only a human-friendly name for the full-length address.
The original v3 address can continue to be used like normal, this just gives
sources an easier to remember option for accessing your SecureDrop.

We recommend that you list both the onion name and the full v3 address on your
landing page. This allows sources to verify both addresses against the
information included in our directory, and also provides a fallback should
the onion name fail to load for any reason.

Please note that as of March 2021, sources need to use the desktop version
of Tor Browser to access onion names, which is also generally our security
recommendation.

Updating an Onion Name
^^^^^^^^^^^^^^^^^^^^^^

If you wish to change or retire your Onion Name, please reach out to the
SecureDrop Team. In the event that you wish to completely retire your
SecureDrop instance, we recommend that you contact us ahead of time if
possible, so we can schedule the Onion Name update on the same day.

In any event, we will attempt to respond to any update request within 2
business days.

Revoking Onion Names
^^^^^^^^^^^^^^^^^^^^

Onion names are tied to inclusion in the SecureDrop Directory. We may
remove SecureDrop instances from the directory at our discretion for
reasons including but not limited to:

* an instance is stuck on an old software version, and can no longer
  be considered secure;
* an instance is unreachable for extended periods of time;
* the configuration of an instance or the associated landing page
  differs substantially from our security recommendations in a manner
  that may put sources at risk.

Unless the removal is an emergency, we will attempt to offer a substantial
grace period prior to the revocation of an onion name, to ensure you can inform
your sources about the change to your .onion address.