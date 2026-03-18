Configuring OSSEC fingerprint verification
==========================================

If you run your own mail server, you may wish to increase the security level used by Postfix for sending mail to ``fingerprint``, rather than ``secure``. Doing so will require an exact match for the fingerprint of TLS certificate on the SMTP relay. The advantage to fingerprint verification is additional security, but the disadvantage is potential maintenance cost if the fingerprint changes often. If you manage the
mail server and handle the certificate rotation, you should update the SecureDrop configuration whenever the certificate changes, so that OSSEC alerts continue to send. Using fingerprint verification does not work well for popular mail relays such as smtp.gmail.com, as those fingerprints can change frequently, due to load balancing or other factors.

You can retrieve the fingerprint of your SMTP relay by running the command below (all on one line).  Please note that you will need to replace ``smtp.gmail.com`` and ``587`` with the correct domain and port
for your SMTP relay. ::

    openssl s_client -connect smtp.gmail.com:587 -starttls smtp < /dev/null 2>/dev/null |
        openssl x509 -fingerprint -noout -in /dev/stdin | cut -d'=' -f2

If you are using Tails, you will not be able to connect directly with ``openssl s_client`` due to the default firewall rules. To get around this, proxy the requests over Tor by adding ``torify`` at the beginning of the command. The output of the command above should look like the following:

::

    6D:87:EE:CB:D0:37:2F:88:B8:29:06:FB:35:F4:65:00:7F:FD:84:29

Finally, add a new variable to ``~/.config/securedrop-admin/site-specific`` as ``smtp_relay_fingerprint``, like so: ::

    smtp_relay_fingerprint: "6D:87:EE:CB:D0:37:2F:88:B8:29:06:FB:35:F4:65:00:7F:FD:84:29"

Specifying the fingerprint will configure Postfix to use it for verification on the next playbook run. To apply the configuration, use ``securedrop-admin`` to :ref:`update the server configuration<update-system-configuration>`. 

To disable the fingerprint verification, simply delete the ``smtp_relay_fingerprint`` line and update the server configuration.
