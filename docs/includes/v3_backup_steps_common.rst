#. :ref:`Back up the existing installation <backing_up>`.

#. **Preserve configuration files**: Rename the 
   SecureDrop project root directory to ``securedrop.old``.
   Specifc files from this directory will be uses 
   during the new installation.

#. **Remove SSH known_hosts file**: The SSH host key fingerprints
   of the SecureDrop servers will change during this process. To
   avoid integrity-checking failures, run

    .. code:: sh
      
        mv ~/.ssh/known_hosts ~/.ssh/known_hosts.old   
   
#. **Reinstall SecureDrop:** Re-clone the SecureDrop repository
   into the ``~/Persistent`` directory. Copy the following files from 
   ``securedrop.old/install_files/ansible-base`` into the 
   new ``securedrop/install_files/ansible-base`` directory:

    - ``tor_v3_keys.json`` 
    - All ``.asc`` files (these correspond to your *Submission Public Key*, 
      your OSSEC alerts public key, and, if configured, your Journalist Alerts 
      public key)
    - The file ``securedrop.old/install_files/ansible-base/group-vars/all/site-specific`` 
      (copy into the new ``securedrop`` directory in the same location).

   Prepare the new :doc:`servers <../servers>` (or, if performing an operating
   system upgrade, you may be performing these steps on your current hardware). 
   Then, :doc:`reinstall SecureDrop <../install>`. During the configuration 
   stage (``./securedrop-admin sdconfig``), press 
   "Enter" to use the values that are populated for you. Proceed through the 
   installation, finishing with ``./securedrop-admin tailsconfig``.

   If SSH-over-Tor is configured, run ``ssh app`` and ``ssh mon`` to add the
   new onion URLs to your ``known_hosts`` file. 

#. **Restore the backup**: Copy the backup archive (located in 
   ``securedrop.old/install_files/ansible-base``) into the 
   ``install_files/ansible-base`` directory, and run

   .. code:: sh
            
       ./securedrop-admin restore sd-backup-<your_backup_file>.tar.gz  

   The restore task will proceed for some time, and then will fail with the
   message ``ssh_exchange_identification: Connection closed by remote host``   
   during the ``Wait for Tor to reload`` task. This is expected; during the 
   restoration process, the *Application Server*'s onion URL changed, causing it
   to be unreachable.

   Reboot the *Application Server*, or log in via the console and issue the
   command ``sudo service tor reload`` to restart the Tor service.
