# Windows mangler 

  * Does not support non-directory file bind-mounts
  * Secret files with custom targets are not directly bind-mounted into Windows containers
  * When creating a service the options to specify UID, GID, and mode are not supported for secrets.
  * Secrets are currently only accessible by administrators and users with system access within the container
  * No built-in driver for managing RAM disks, so within running Windows containers, secrets are persisted in clear text to the container’s root disk.
  * Does not support persisting a running container as an image using _docker commit_ or similar commands
  * Not be possible to attach to the X windows manager socket
