local ffi = require("ffi")

--[[
#if GUESTFS_PRIVATE
/* Symbols protected by GUESTFS_PRIVATE are NOT part of the public,
 * stable API, and can change at any time!  We export them because
 * they are used by some of the language bindings.
 */
--]]

ffi.cdef[[
/* Private functions. */

extern  int guestfs_internal_autosync (guestfs_h *g);

extern  int guestfs_internal_exit (guestfs_h *g);

extern  int guestfs_internal_hot_add_drive (guestfs_h *g, const char *label);

extern  int guestfs_internal_hot_remove_drive (guestfs_h *g, const char *label);

extern  int guestfs_internal_hot_remove_drive_precheck (guestfs_h *g, const char *label);

extern  int guestfs_internal_journal_get (guestfs_h *g, const char *filename);

extern  struct guestfs_statns_list *guestfs_internal_lstatnslist (guestfs_h *g, const char *path, char *const *names);

extern  struct guestfs_xattr_list *guestfs_internal_lxattrlist (guestfs_h *g, const char *path, char *const *names);

extern  struct guestfs_internal_mountable *guestfs_internal_parse_mountable (guestfs_h *g, const char *mountable);

extern  char **guestfs_internal_readlinklist (guestfs_h *g, const char *path, char *const *names);

extern  int guestfs_internal_rhbz914931 (guestfs_h *g, const char *filename, int count);

extern  int guestfs_internal_test (guestfs_h *g, const char *str, const char *optstr, char *const *strlist, int b, int integer, int64_t integer64, const char *filein, const char *fileout, const char *bufferin, size_t bufferin_size, ...);
extern  int guestfs_internal_test_va (guestfs_h *g, const char *str, const char *optstr, char *const *strlist, int b, int integer, int64_t integer64, const char *filein, const char *fileout, const char *bufferin, size_t bufferin_size, va_list args);

struct guestfs_internal_test_argv {
  uint64_t bitmask;
  int obool;
  int oint;
  int64_t oint64;
  const char *ostring;
  char *const *ostringlist;
};

extern  int guestfs_internal_test_argv (guestfs_h *g, const char *str, const char *optstr, char *const *strlist, int b, int integer, int64_t integer64, const char *filein, const char *fileout, const char *bufferin, size_t bufferin_size, const struct guestfs_internal_test_argv *optargs);

extern  int guestfs_internal_test_63_optargs (guestfs_h *g, ...);
extern  int guestfs_internal_test_63_optargs_va (guestfs_h *g, va_list args);

struct guestfs_internal_test_63_optargs_argv {
  uint64_t bitmask;
  int opt1;
  int opt2;
  int opt3;
  int opt4;
  int opt5;
  int opt6;
  int opt7;
  int opt8;
  int opt9;
  int opt10;
  int opt11;
  int opt12;
  int opt13;
  int opt14;
  int opt15;
  int opt16;
  int opt17;
  int opt18;
  int opt19;
  int opt20;
  int opt21;
  int opt22;
  int opt23;
  int opt24;
  int opt25;
  int opt26;
  int opt27;
  int opt28;
  int opt29;
  int opt30;
  int opt31;
  int opt32;
  int opt33;
  int opt34;
  int opt35;
  int opt36;
  int opt37;
  int opt38;
  int opt39;
  int opt40;
  int opt41;
  int opt42;
  int opt43;
  int opt44;
  int opt45;
  int opt46;
  int opt47;
  int opt48;
  int opt49;
  int opt50;
  int opt51;
  int opt52;
  int opt53;
  int opt54;
  int opt55;
  int opt56;
  int opt57;
  int opt58;
  int opt59;
  int opt60;
  int opt61;
  int opt62;
  int opt63;
};

extern  int guestfs_internal_test_63_optargs_argv (guestfs_h *g, const struct guestfs_internal_test_63_optargs_argv *optargs);

extern  int guestfs_internal_test_close_output (guestfs_h *g);

extern  int guestfs_internal_test_only_optargs (guestfs_h *g, ...);
extern  int guestfs_internal_test_only_optargs_va (guestfs_h *g, va_list args);

struct guestfs_internal_test_only_optargs_argv {
  uint64_t bitmask;
  int test;
};

extern  int guestfs_internal_test_only_optargs_argv (guestfs_h *g, const struct guestfs_internal_test_only_optargs_argv *optargs);

extern  int guestfs_internal_test_rbool (guestfs_h *g, const char *val);

extern  int guestfs_internal_test_rboolerr (guestfs_h *g);

extern  char *guestfs_internal_test_rbufferout (guestfs_h *g, const char *val, size_t *size_r);

extern  char *guestfs_internal_test_rbufferouterr (guestfs_h *g, size_t *size_r);

extern  const char *guestfs_internal_test_rconstoptstring (guestfs_h *g, const char *val);

extern  const char *guestfs_internal_test_rconstoptstringerr (guestfs_h *g);

extern  const char *guestfs_internal_test_rconststring (guestfs_h *g, const char *val);

extern  const char *guestfs_internal_test_rconststringerr (guestfs_h *g);

extern  char **guestfs_internal_test_rhashtable (guestfs_h *g, const char *val);

extern  char **guestfs_internal_test_rhashtableerr (guestfs_h *g);

extern  int guestfs_internal_test_rint (guestfs_h *g, const char *val);

extern  int64_t guestfs_internal_test_rint64 (guestfs_h *g, const char *val);

extern  int64_t guestfs_internal_test_rint64err (guestfs_h *g);

extern  int guestfs_internal_test_rinterr (guestfs_h *g);

extern  char *guestfs_internal_test_rstring (guestfs_h *g, const char *val);

extern  char *guestfs_internal_test_rstringerr (guestfs_h *g);

extern  char **guestfs_internal_test_rstringlist (guestfs_h *g, const char *val);

extern  char **guestfs_internal_test_rstringlisterr (guestfs_h *g);

extern  struct guestfs_lvm_pv *guestfs_internal_test_rstruct (guestfs_h *g, const char *val);

extern  struct guestfs_lvm_pv *guestfs_internal_test_rstructerr (guestfs_h *g);

extern  struct guestfs_lvm_pv_list *guestfs_internal_test_rstructlist (guestfs_h *g, const char *val);

extern  struct guestfs_lvm_pv_list *guestfs_internal_test_rstructlisterr (guestfs_h *g);

extern  int guestfs_internal_test_set_output (guestfs_h *g, const char *filename);

extern  int guestfs_internal_upload (guestfs_h *g, const char *filename, const char *tmpname, int mode);

extern  int guestfs_internal_write (guestfs_h *g, const char *path, const char *content, size_t content_size);

extern  int guestfs_internal_write_append (guestfs_h *g, const char *path, const char *content, size_t content_size);
]]

ffi.cdef[[
/* Private structures. */

struct guestfs_internal_mountable {
  int32_t im_type;
  char *im_device;
  char *im_volume;
};

struct guestfs_internal_mountable_list {
  uint32_t len;
  struct guestfs_internal_mountable *val;
};

extern  int guestfs_compare_internal_mountable (const struct guestfs_internal_mountable *, const struct guestfs_internal_mountable *);
extern  int guestfs_compare_internal_mountable_list (const struct guestfs_internal_mountable_list *, const struct guestfs_internal_mountable_list *);

extern  struct guestfs_internal_mountable *guestfs_copy_internal_mountable (const struct guestfs_internal_mountable *);
extern  struct guestfs_internal_mountable_list *guestfs_copy_internal_mountable_list (const struct guestfs_internal_mountable_list *);

extern  void guestfs_free_internal_mountable (struct guestfs_internal_mountable *);
extern  void guestfs_free_internal_mountable_list (struct guestfs_internal_mountable_list *);

]]
