**************
Onboard users
**************

During the initial :doc:`installation</admin/installation/index>` of SecureDrop, only the first Administrator user is created. Additional Journalist and Administrators can be onboarded as needed. 

New user accounts
-----------------

:doc:`/admin/onboarding/add_user`

Every new Administrator or Journalist must have a new corresponding SecureDrop account created using the Admin Interface. Administrators use this account to log in to the Admin Interface, and Journalists use it to log in to the SecureDrop Inbox application.

Provision additional Workstations
---------------------------------

The need to provision additional Workstations for new users depends on the needs of your users and the capacity of your organization. Each new Workstation will be based on a Qubes-compatible laptop based on our :ref:`hardware requirements<hardware_recommendations_workstations>`. 

Adding Journalist Workstations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Within your organization, each Journalist may have their own individual :ref:`Journalist Workstation<glossary_journalist_workstation>`, multiple Journalists may share a single Workstation, or you may have a combination of shared and individual Journalist Workstations. 

:doc:`add_journalist_workstation`

Adding Admin Workstations
~~~~~~~~~~~~~~~~~~~~~~~~~~

Ideally, each Administrator should have their own :ref:`Admin Workstation<glossary_admin_workstation>`. However, there are special measures that must be taken to keep multiple Admin Workstations in sync. 

:doc:`add_admin_workstation`

Adding Combined Admin + Journalist Workstations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To accommodate newsrooms on a tighter budget, or situations where the same individual is both an Administrator and Journalist, SecureDrop supports a combined Admin + Journalist Workstation.

:doc:`add_combined_workstation`

Additional Workstation set up
-----------------------------

After provisioning a new Workstation, you may optionally configure inter-qube clipboard access.

:doc:`managing_clipboard`

Export Devices
--------------

In small organizations, a team of Journalists may want to share a single Export Device. In larger organizations, you may want to provision a personal Export Device for each Journalist who may need to :ref:`Export files and transcripts<exporting_export_device>` off their Journalist Workstation. 

:doc:`provisioning_usb`

Offboarding
-----------

Equally important to onboarding new users are the steps and procedures to follow when a user leaves your organization.

:doc:`offboarding`

.. toctree::
   :maxdepth: 1
   :hidden:

   provisioning_usb
   add_user
   add_journalist_workstation
   add_admin_workstation
   add_combined_workstation
   managing_clipboard
   offboarding
   
   
