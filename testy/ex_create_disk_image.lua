package.path = "../?.lua;"..package.path

-- Example showing how to create a disk image.
local ffi = require("ffi")

local gfs = require("lj2guestfs.guestfs_ffi")

local UINT64_C = ffi.typeof("uint64_t")
local int = ffi.typeof("int")

local function main (argc, argv)

  --size_t i;
  local g = gfs.guestfs_create ();
  assert(g~= NULL, "failed to create libguestfs handle");

 
  -- Set the trace flag so that we can see each libguestfs call.
  gfs.guestfs_set_trace (g, 1);
 
  -- Create a raw-format sparse disk image, 512 MB in size.
  if (gfs.guestfs_disk_create (g, "disk.img", "raw", UINT64_C(512)*1024*1024, int(-1)) == -1) then
     error()
  end

  -- Add the disk image to libguestfs.
  -- you must be very specific with the types of optional arguments
  if (gfs.guestfs_add_drive_opts (g, "disk.img",
                              int(gfs.GUESTFS_ADD_DRIVE_OPTS_FORMAT), ffi.cast("const char *","raw"), -- raw format
                              int(gfs.GUESTFS_ADD_DRIVE_OPTS_READONLY), int(0), -- for write
                              int(-1)) -- this marks end of optional arguments
       == -1) then
     error();
  end

  -- Run the libguestfs back-end.
  if (gfs.guestfs_launch (g) == -1) then
     error();
  end
 
  --[[ Get the list of devices.  Because we only added one drive
    * above, we expect that this list should contain a single
    * element.
  --]]
  local devices = gfs.guestfs_list_devices (g);
  if (devices == NULL) then
     error();
  end

  if (devices[0] == NULL or devices[1] ~= NULL) then
     io.write (io.stderr, string.format("error: expected a single device from list-devices\n"));
     error();
  end
 
  -- Partition the disk as one single MBR partition.
  if (gfs.guestfs_part_disk (g, devices[0], "mbr") == -1) then
    error();
  end
 
  --[[
   Get the list of partitions.  We expect a single element, which
    * is the partition we have just created.
  --]]

--[[
  char **partitions = guestfs_list_partitions (g);
   if (partitions == NULL)
     exit (EXIT_FAILURE);
   if (partitions[0] == NULL || partitions[1] != NULL) {
     fprintf (stderr, "error: expected a single partition from list-partitions\n");
     exit (EXIT_FAILURE);
   }
 
   /* Create a filesystem on the partition. */
   if (guestfs_mkfs (g, "ext4", partitions[0]) == -1)
     exit (EXIT_FAILURE);
 
   /* Now mount the filesystem so that we can add files. */
   if (guestfs_mount (g, partitions[0], "/") == -1)
     exit (EXIT_FAILURE);
 
   /* Create some files and directories. */
   if (guestfs_touch (g, "/empty") == -1)
     exit (EXIT_FAILURE);
   const char *message = "Hello, world\n";
   if (guestfs_write (g, "/hello", message, strlen (message)) == -1)
     exit (EXIT_FAILURE);
   if (guestfs_mkdir (g, "/foo") == -1)
     exit (EXIT_FAILURE);
 
   /* This one uploads the local file /etc/resolv.conf into
    * the disk image.
    */
   if (guestfs_upload (g, "/etc/resolv.conf", "/foo/resolv.conf") == -1)
     exit (EXIT_FAILURE);
--]]
  --[[
   Because we wrote to the disk and we want to detect write
    * errors, call guestfs_shutdown.  You don't need to do this:
    * guestfs_close will do it implicitly.
  --]]
  if (gfs.guestfs_shutdown (g) == -1) then
    error();
  end
 
  gfs.guestfs_close (g);

--[[
   /* Free up the lists. */
   for (i = 0; devices[i] != NULL; ++i)
     free (devices[i]);
   free (devices);
   for (i = 0; partitions[i] != NULL; ++i)
     free (partitions[i]);
   free (partitions);
--]] 
end


main(#arg, arg)

