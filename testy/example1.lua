 --[[
 	Simplest example of trying to use the C interface of guestfs
 http://libguestfs.org/guestfs-examples.3.html
 --]]
 package.path = "../?.lua;"..package.path

 local gfs = require("lj2guestfs.guestfs_ffi")
 
-- first, create a guestfs context
local ctx = gfs.guestfs_create ();

-- add a disk image to it
gfs.guestfs_add_drive_ro (ctx, "disk.img");

-- launch that disk image
gfs.guestfs_launch (ctx);
