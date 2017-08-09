 --[[
 	Simplest example of trying to use the C interface of guestfs
 http://libguestfs.org/guestfs-examples.3.html
 --]]
 package.path = "../?.lua;"..package.path

 local gfs = require("lj2guestfs.guestfs_ffi")
 print("gfs: ", gfs)

-- first, create a guestfs context
local ctx = gfs.guestfs_create ();
print("ctx: ", ctx)

-- add a disk image to it
local res = gfs.guestfs_add_drive_ro (ctx, "disk.img");
print("add_drive_ro, res: ", res);

-- launch that disk image
gfs.guestfs_launch (ctx);
