SecureDrop for Administrators
=============================

.. include:: ../../includes/provide-feedback.txt

SecureDrop servers are managed by a systems administrator.

For larger newsrooms, there may be a team of systems admins, but
at least one person within the organization will need to serve
as the administrator. In some situations, such as smaller news
organizations where a journalist has the technical capacity
to administer systems, one person can serve as both Journalist
and Administrator. When possible, we advise having a dedicated
staff member serving the role of SecureDrop Administrator.

The admin uses a dedicated *Admin Workstation* running 
`Tails <https://tails.boum.org>`__, connects to the *Application* and
*Monitor Servers* over `authenticated onion services
<https://tb-manual.torproject.org/onion-services/>`__, and manages them
using `Ansible <https://www.ansible.com/>`__.

This Admin Guide will walk you through the entire experience,
from planning to installation to deployment, and will also provide reference
materials to help ensure that your servers remain up-to-date and in
proper working order.