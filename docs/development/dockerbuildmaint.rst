.. _build_container:

Build container
===============
We use a Docker build container to build our debian packages for SecureDrop (via ``make build-debs``
in the ``securedrop`` Github repository root directory). We keep images of this our container in a
Docker repository at **quay.io/freedomofpress**. The images are organized by Ubuntu release
version. For instance, you can find the images for Xenial at
**quay.io/freedomofpress/sd-docker-builder-xenial** and, for Focal, at
**quay.io/freedomofpress/sd-docker-builder-focal**.

Maintaining images of our build container for each release is our way of recording the exact version
of each dependency used to build our production debian packages for SecureDrop.

Who can update the build container?
===================================
There are tight restrictions over who can make edits to our Docker repository. If you have
permissions to do so, you'll need to make sure your local Docker client has credentials to push.

* First login into your quay.io account via the web-portal at https://quay.io/
* Drill into your **Account settings** via the upper right drop-down (where your username is)
* Click **Generate Encrypted Password**
* From a command-line prompt type **docker login quay.io** with your username and credentials
  obtained from the previous step.
* Proceed with update instructions

Updating the build container
============================
We know the build container needs to be updated when **test_ensure_no_updates_avail** fails during
``make build-debs`` in the ``securedrop`` Github reprository root directory. This test fails if any
of the dependencies required to build the debian packages have security updates. If you have access
rights to push to quay.io, then you can build and push a new container to the Quay repository by
following the steps below.

.. note:: The reason we don't update the container at runtime is that we use the container image as
          a way of recording our build environment.

.. code:: sh

    cd molecule/builder/
    # Build a new container
    make build-container

Once the container is built, you can push the container to the registry.

.. code:: sh

    make push-container

You can now test the container by going back to the SecureDrop repository root:

.. code:: sh

    cd ../..
    make build-debs

Assuming no errors here, commit the changes in ``molecule/builder/image_hash`` in a branch containing the prefix ``update-builder-``.
