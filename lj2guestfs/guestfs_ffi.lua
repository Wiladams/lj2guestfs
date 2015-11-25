local ffi = require("ffi")

ffi.cdef[[
/* The handle. */
typedef struct guestfs_h guestfs_h;
]]

ffi.cdef[[
/* Connection management. */
extern  guestfs_h *guestfs_create (void);
extern  guestfs_h *guestfs_create_flags (unsigned flags, ...);
extern  void guestfs_close (guestfs_h *g);
]]

ffi.cdef[[
/* Error handling. */
extern  const char *guestfs_last_error (guestfs_h *g);
extern  int guestfs_last_errno (guestfs_h *g);

typedef void (*guestfs_error_handler_cb) (guestfs_h *g, void *opaque, const char *msg);

typedef void (*guestfs_abort_cb) (void) ;


extern  void guestfs_set_error_handler (guestfs_h *g, guestfs_error_handler_cb cb, void *opaque);
extern  guestfs_error_handler_cb guestfs_get_error_handler (guestfs_h *g, void **opaque_rtn);
extern  void guestfs_push_error_handler (guestfs_h *g, guestfs_error_handler_cb cb, void *opaque);
extern  void guestfs_pop_error_handler (guestfs_h *g);

extern  void guestfs_set_out_of_memory_handler (guestfs_h *g, guestfs_abort_cb);
extern  guestfs_abort_cb guestfs_get_out_of_memory_handler (guestfs_h *g);
]]

ffi.cdef[[
/* Events. */

typedef void (*guestfs_event_callback) (
                        guestfs_h *g,
                        void *opaque,
                        uint64_t event,
                        int event_handle,
                        int flags,
                        const char *buf, size_t buf_len,
                        const uint64_t *array, size_t array_len);


extern  int guestfs_set_event_callback (guestfs_h *g, guestfs_event_callback cb, uint64_t event_bitmask, int flags, void *opaque);
extern  void guestfs_delete_event_callback (guestfs_h *g, int event_handle);
extern  char *guestfs_event_to_string (uint64_t event);
]]

--[[
/* Old-style event handling. */
#ifndef GUESTFS_TYPEDEF_LOG_MESSAGE_CB
typedef void (*guestfs_log_message_cb) (guestfs_h *g, void *opaque, char *buf, int len);
#endif

#ifndef GUESTFS_TYPEDEF_SUBPROCESS_QUIT_CB
typedef void (*guestfs_subprocess_quit_cb) (guestfs_h *g, void *opaque);
#endif

#ifndef GUESTFS_TYPEDEF_LAUNCH_DONE_CB
typedef void (*guestfs_launch_done_cb) (guestfs_h *g, void *opaque);
#endif

#ifndef GUESTFS_TYPEDEF_CLOSE_CB
typedef void (*guestfs_close_cb) (guestfs_h *g, void *opaque);
#endif

#ifndef GUESTFS_TYPEDEF_PROGRESS_CB
typedef void (*guestfs_progress_cb) (guestfs_h *g, void *opaque, int proc_nr, int serial, uint64_t position, uint64_t total);
#endif
--]]

--[[
extern  void guestfs_set_log_message_callback (guestfs_h *g, guestfs_log_message_cb cb, void *opaque)
  GUESTFS_DEPRECATED_BY("set_event_callback");
extern  void guestfs_set_subprocess_quit_callback (guestfs_h *g, guestfs_subprocess_quit_cb cb, void *opaque)
  GUESTFS_DEPRECATED_BY("set_event_callback");
extern  void guestfs_set_launch_done_callback (guestfs_h *g, guestfs_launch_done_cb cb, void *opaque)
  GUESTFS_DEPRECATED_BY("set_event_callback");
extern  void guestfs_set_close_callback (guestfs_h *g, guestfs_close_cb cb, void *opaque)
  GUESTFS_DEPRECATED_BY("set_event_callback");
extern  void guestfs_set_progress_callback (guestfs_h *g, guestfs_progress_cb cb, void *opaque)
  GUESTFS_DEPRECATED_BY("set_event_callback");
--]]

ffi.cdef[[
/* Private data area. */
extern  void guestfs_set_private (guestfs_h *g, const char *key, void *data);
extern  void *guestfs_get_private (guestfs_h *g, const char *key);
extern  void *guestfs_first_private (guestfs_h *g, const char **key_rtn);
extern  void *guestfs_next_private (guestfs_h *g, const char **key_rtn);
]]

ffi.cdef[[
/* Structures. */
struct guestfs_application {
  char *app_name;
  char *app_display_name;
  int32_t app_epoch;
  char *app_version;
  char *app_release;
  char *app_install_path;
  char *app_trans_path;
  char *app_publisher;
  char *app_url;
  char *app_source_package;
  char *app_summary;
  char *app_description;
};

struct guestfs_application_list {
  uint32_t len;
  struct guestfs_application *val;
};

extern  int guestfs_compare_application (const struct guestfs_application *, const struct guestfs_application *);
extern  int guestfs_compare_application_list (const struct guestfs_application_list *, const struct guestfs_application_list *);

extern  struct guestfs_application *guestfs_copy_application (const struct guestfs_application *);
extern  struct guestfs_application_list *guestfs_copy_application_list (const struct guestfs_application_list *);

extern  void guestfs_free_application (struct guestfs_application *);
extern  void guestfs_free_application_list (struct guestfs_application_list *);

struct guestfs_application2 {
  char *app2_name;
  char *app2_display_name;
  int32_t app2_epoch;
  char *app2_version;
  char *app2_release;
  char *app2_arch;
  char *app2_install_path;
  char *app2_trans_path;
  char *app2_publisher;
  char *app2_url;
  char *app2_source_package;
  char *app2_summary;
  char *app2_description;
  char *app2_spare1;
  char *app2_spare2;
  char *app2_spare3;
  char *app2_spare4;
};

struct guestfs_application2_list {
  uint32_t len;
  struct guestfs_application2 *val;
};

extern  int guestfs_compare_application2 (const struct guestfs_application2 *, const struct guestfs_application2 *);
extern  int guestfs_compare_application2_list (const struct guestfs_application2_list *, const struct guestfs_application2_list *);

extern  struct guestfs_application2 *guestfs_copy_application2 (const struct guestfs_application2 *);
extern  struct guestfs_application2_list *guestfs_copy_application2_list (const struct guestfs_application2_list *);

extern  void guestfs_free_application2 (struct guestfs_application2 *);
extern  void guestfs_free_application2_list (struct guestfs_application2_list *);
]]

ffi.cdef[[
struct guestfs_btrfssubvolume {
  uint64_t btrfssubvolume_id;
  uint64_t btrfssubvolume_top_level_id;
  char *btrfssubvolume_path;
};

struct guestfs_btrfssubvolume_list {
  uint32_t len;
  struct guestfs_btrfssubvolume *val;
};

extern  int guestfs_compare_btrfssubvolume (const struct guestfs_btrfssubvolume *, const struct guestfs_btrfssubvolume *);
extern  int guestfs_compare_btrfssubvolume_list (const struct guestfs_btrfssubvolume_list *, const struct guestfs_btrfssubvolume_list *);

extern  struct guestfs_btrfssubvolume *guestfs_copy_btrfssubvolume (const struct guestfs_btrfssubvolume *);
extern  struct guestfs_btrfssubvolume_list *guestfs_copy_btrfssubvolume_list (const struct guestfs_btrfssubvolume_list *);

extern  void guestfs_free_btrfssubvolume (struct guestfs_btrfssubvolume *);
extern  void guestfs_free_btrfssubvolume_list (struct guestfs_btrfssubvolume_list *);

struct guestfs_dirent {
  int64_t ino;
  char ftyp;
  char *name;
};

struct guestfs_dirent_list {
  uint32_t len;
  struct guestfs_dirent *val;
};

extern  int guestfs_compare_dirent (const struct guestfs_dirent *, const struct guestfs_dirent *);
extern  int guestfs_compare_dirent_list (const struct guestfs_dirent_list *, const struct guestfs_dirent_list *);

extern  struct guestfs_dirent *guestfs_copy_dirent (const struct guestfs_dirent *);
extern  struct guestfs_dirent_list *guestfs_copy_dirent_list (const struct guestfs_dirent_list *);

extern  void guestfs_free_dirent (struct guestfs_dirent *);
extern  void guestfs_free_dirent_list (struct guestfs_dirent_list *);
]]

ffi.cdef[[
struct guestfs_hivex_node {
  int64_t hivex_node_h;
};

struct guestfs_hivex_node_list {
  uint32_t len;
  struct guestfs_hivex_node *val;
};

extern  int guestfs_compare_hivex_node (const struct guestfs_hivex_node *, const struct guestfs_hivex_node *);
extern  int guestfs_compare_hivex_node_list (const struct guestfs_hivex_node_list *, const struct guestfs_hivex_node_list *);

extern  struct guestfs_hivex_node *guestfs_copy_hivex_node (const struct guestfs_hivex_node *);
extern  struct guestfs_hivex_node_list *guestfs_copy_hivex_node_list (const struct guestfs_hivex_node_list *);

extern  void guestfs_free_hivex_node (struct guestfs_hivex_node *);
extern  void guestfs_free_hivex_node_list (struct guestfs_hivex_node_list *);

struct guestfs_hivex_value {
  int64_t hivex_value_h;
};

struct guestfs_hivex_value_list {
  uint32_t len;
  struct guestfs_hivex_value *val;
};

extern  int guestfs_compare_hivex_value (const struct guestfs_hivex_value *, const struct guestfs_hivex_value *);
extern  int guestfs_compare_hivex_value_list (const struct guestfs_hivex_value_list *, const struct guestfs_hivex_value_list *);

extern  struct guestfs_hivex_value *guestfs_copy_hivex_value (const struct guestfs_hivex_value *);
extern  struct guestfs_hivex_value_list *guestfs_copy_hivex_value_list (const struct guestfs_hivex_value_list *);

extern  void guestfs_free_hivex_value (struct guestfs_hivex_value *);
extern  void guestfs_free_hivex_value_list (struct guestfs_hivex_value_list *);
]]

ffi.cdef[[
struct guestfs_inotify_event {
  int64_t in_wd;
  uint32_t in_mask;
  uint32_t in_cookie;
  char *in_name;
};

struct guestfs_inotify_event_list {
  uint32_t len;
  struct guestfs_inotify_event *val;
};

extern  int guestfs_compare_inotify_event (const struct guestfs_inotify_event *, const struct guestfs_inotify_event *);
extern  int guestfs_compare_inotify_event_list (const struct guestfs_inotify_event_list *, const struct guestfs_inotify_event_list *);

extern  struct guestfs_inotify_event *guestfs_copy_inotify_event (const struct guestfs_inotify_event *);
extern  struct guestfs_inotify_event_list *guestfs_copy_inotify_event_list (const struct guestfs_inotify_event_list *);

extern  void guestfs_free_inotify_event (struct guestfs_inotify_event *);
extern  void guestfs_free_inotify_event_list (struct guestfs_inotify_event_list *);

struct guestfs_int_bool {
  int32_t i;
  int32_t b;
};

struct guestfs_int_bool_list {
  uint32_t len;
  struct guestfs_int_bool *val;
};

extern  int guestfs_compare_int_bool (const struct guestfs_int_bool *, const struct guestfs_int_bool *);
extern  int guestfs_compare_int_bool_list (const struct guestfs_int_bool_list *, const struct guestfs_int_bool_list *);

extern  struct guestfs_int_bool *guestfs_copy_int_bool (const struct guestfs_int_bool *);
extern  struct guestfs_int_bool_list *guestfs_copy_int_bool_list (const struct guestfs_int_bool_list *);

extern  void guestfs_free_int_bool (struct guestfs_int_bool *);
extern  void guestfs_free_int_bool_list (struct guestfs_int_bool_list *);

struct guestfs_isoinfo {
  char *iso_system_id;
  char *iso_volume_id;
  uint32_t iso_volume_space_size;
  uint32_t iso_volume_set_size;
  uint32_t iso_volume_sequence_number;
  uint32_t iso_logical_block_size;
  char *iso_volume_set_id;
  char *iso_publisher_id;
  char *iso_data_preparer_id;
  char *iso_application_id;
  char *iso_copyright_file_id;
  char *iso_abstract_file_id;
  char *iso_bibliographic_file_id;
  int64_t iso_volume_creation_t;
  int64_t iso_volume_modification_t;
  int64_t iso_volume_expiration_t;
  int64_t iso_volume_effective_t;
};

struct guestfs_isoinfo_list {
  uint32_t len;
  struct guestfs_isoinfo *val;
};

extern  int guestfs_compare_isoinfo (const struct guestfs_isoinfo *, const struct guestfs_isoinfo *);
extern  int guestfs_compare_isoinfo_list (const struct guestfs_isoinfo_list *, const struct guestfs_isoinfo_list *);

extern  struct guestfs_isoinfo *guestfs_copy_isoinfo (const struct guestfs_isoinfo *);
extern  struct guestfs_isoinfo_list *guestfs_copy_isoinfo_list (const struct guestfs_isoinfo_list *);

extern  void guestfs_free_isoinfo (struct guestfs_isoinfo *);
extern  void guestfs_free_isoinfo_list (struct guestfs_isoinfo_list *);

struct guestfs_lvm_lv {
  char *lv_name;
  char lv_uuid[32]; /* this is NOT nul-terminated, be careful when printing */
  char *lv_attr;
  int64_t lv_major;
  int64_t lv_minor;
  int64_t lv_kernel_major;
  int64_t lv_kernel_minor;
  uint64_t lv_size;
  int64_t seg_count;
  char *origin;
  float snap_percent; /* [0..100] or -1 */
  float copy_percent; /* [0..100] or -1 */
  char *move_pv;
  char *lv_tags;
  char *mirror_log;
  char *modules;
};

struct guestfs_lvm_lv_list {
  uint32_t len;
  struct guestfs_lvm_lv *val;
};

extern  int guestfs_compare_lvm_lv (const struct guestfs_lvm_lv *, const struct guestfs_lvm_lv *);
extern  int guestfs_compare_lvm_lv_list (const struct guestfs_lvm_lv_list *, const struct guestfs_lvm_lv_list *);

extern  struct guestfs_lvm_lv *guestfs_copy_lvm_lv (const struct guestfs_lvm_lv *);
extern  struct guestfs_lvm_lv_list *guestfs_copy_lvm_lv_list (const struct guestfs_lvm_lv_list *);

extern  void guestfs_free_lvm_lv (struct guestfs_lvm_lv *);
extern  void guestfs_free_lvm_lv_list (struct guestfs_lvm_lv_list *);

struct guestfs_lvm_pv {
  char *pv_name;
  char pv_uuid[32]; /* this is NOT nul-terminated, be careful when printing */
  char *pv_fmt;
  uint64_t pv_size;
  uint64_t dev_size;
  uint64_t pv_free;
  uint64_t pv_used;
  char *pv_attr;
  int64_t pv_pe_count;
  int64_t pv_pe_alloc_count;
  char *pv_tags;
  uint64_t pe_start;
  int64_t pv_mda_count;
  uint64_t pv_mda_free;
};

struct guestfs_lvm_pv_list {
  uint32_t len;
  struct guestfs_lvm_pv *val;
};

extern  int guestfs_compare_lvm_pv (const struct guestfs_lvm_pv *, const struct guestfs_lvm_pv *);
extern  int guestfs_compare_lvm_pv_list (const struct guestfs_lvm_pv_list *, const struct guestfs_lvm_pv_list *);

extern  struct guestfs_lvm_pv *guestfs_copy_lvm_pv (const struct guestfs_lvm_pv *);
extern  struct guestfs_lvm_pv_list *guestfs_copy_lvm_pv_list (const struct guestfs_lvm_pv_list *);

extern  void guestfs_free_lvm_pv (struct guestfs_lvm_pv *);
extern  void guestfs_free_lvm_pv_list (struct guestfs_lvm_pv_list *);

struct guestfs_lvm_vg {
  char *vg_name;
  char vg_uuid[32]; /* this is NOT nul-terminated, be careful when printing */
  char *vg_fmt;
  char *vg_attr;
  uint64_t vg_size;
  uint64_t vg_free;
  char *vg_sysid;
  uint64_t vg_extent_size;
  int64_t vg_extent_count;
  int64_t vg_free_count;
  int64_t max_lv;
  int64_t max_pv;
  int64_t pv_count;
  int64_t lv_count;
  int64_t snap_count;
  int64_t vg_seqno;
  char *vg_tags;
  int64_t vg_mda_count;
  uint64_t vg_mda_free;
};

struct guestfs_lvm_vg_list {
  uint32_t len;
  struct guestfs_lvm_vg *val;
};

extern  int guestfs_compare_lvm_vg (const struct guestfs_lvm_vg *, const struct guestfs_lvm_vg *);
extern  int guestfs_compare_lvm_vg_list (const struct guestfs_lvm_vg_list *, const struct guestfs_lvm_vg_list *);

extern  struct guestfs_lvm_vg *guestfs_copy_lvm_vg (const struct guestfs_lvm_vg *);
extern  struct guestfs_lvm_vg_list *guestfs_copy_lvm_vg_list (const struct guestfs_lvm_vg_list *);

extern  void guestfs_free_lvm_vg (struct guestfs_lvm_vg *);
extern  void guestfs_free_lvm_vg_list (struct guestfs_lvm_vg_list *);

struct guestfs_mdstat {
  char *mdstat_device;
  int32_t mdstat_index;
  char *mdstat_flags;
};

struct guestfs_mdstat_list {
  uint32_t len;
  struct guestfs_mdstat *val;
};

extern  int guestfs_compare_mdstat (const struct guestfs_mdstat *, const struct guestfs_mdstat *);
extern  int guestfs_compare_mdstat_list (const struct guestfs_mdstat_list *, const struct guestfs_mdstat_list *);

extern  struct guestfs_mdstat *guestfs_copy_mdstat (const struct guestfs_mdstat *);
extern  struct guestfs_mdstat_list *guestfs_copy_mdstat_list (const struct guestfs_mdstat_list *);

extern  void guestfs_free_mdstat (struct guestfs_mdstat *);
extern  void guestfs_free_mdstat_list (struct guestfs_mdstat_list *);

struct guestfs_partition {
  int32_t part_num;
  uint64_t part_start;
  uint64_t part_end;
  uint64_t part_size;
};

struct guestfs_partition_list {
  uint32_t len;
  struct guestfs_partition *val;
};

extern  int guestfs_compare_partition (const struct guestfs_partition *, const struct guestfs_partition *);
extern  int guestfs_compare_partition_list (const struct guestfs_partition_list *, const struct guestfs_partition_list *);

extern  struct guestfs_partition *guestfs_copy_partition (const struct guestfs_partition *);
extern  struct guestfs_partition_list *guestfs_copy_partition_list (const struct guestfs_partition_list *);

extern  void guestfs_free_partition (struct guestfs_partition *);
extern  void guestfs_free_partition_list (struct guestfs_partition_list *);

struct guestfs_stat {
  int64_t dev;
  int64_t ino;
  int64_t mode;
  int64_t nlink;
  int64_t uid;
  int64_t gid;
  int64_t rdev;
  int64_t size;
  int64_t blksize;
  int64_t blocks;
  int64_t atime;
  int64_t mtime;
  int64_t ctime;
};

struct guestfs_stat_list {
  uint32_t len;
  struct guestfs_stat *val;
};

extern  int guestfs_compare_stat (const struct guestfs_stat *, const struct guestfs_stat *);
extern  int guestfs_compare_stat_list (const struct guestfs_stat_list *, const struct guestfs_stat_list *);

extern  struct guestfs_stat *guestfs_copy_stat (const struct guestfs_stat *);
extern  struct guestfs_stat_list *guestfs_copy_stat_list (const struct guestfs_stat_list *);

extern  void guestfs_free_stat (struct guestfs_stat *);
extern  void guestfs_free_stat_list (struct guestfs_stat_list *);

struct guestfs_statns {
  int64_t st_dev;
  int64_t st_ino;
  int64_t st_mode;
  int64_t st_nlink;
  int64_t st_uid;
  int64_t st_gid;
  int64_t st_rdev;
  int64_t st_size;
  int64_t st_blksize;
  int64_t st_blocks;
  int64_t st_atime_sec;
  int64_t st_atime_nsec;
  int64_t st_mtime_sec;
  int64_t st_mtime_nsec;
  int64_t st_ctime_sec;
  int64_t st_ctime_nsec;
  int64_t st_spare1;
  int64_t st_spare2;
  int64_t st_spare3;
  int64_t st_spare4;
  int64_t st_spare5;
  int64_t st_spare6;
};

struct guestfs_statns_list {
  uint32_t len;
  struct guestfs_statns *val;
};

extern  int guestfs_compare_statns (const struct guestfs_statns *, const struct guestfs_statns *);
extern  int guestfs_compare_statns_list (const struct guestfs_statns_list *, const struct guestfs_statns_list *);

extern  struct guestfs_statns *guestfs_copy_statns (const struct guestfs_statns *);
extern  struct guestfs_statns_list *guestfs_copy_statns_list (const struct guestfs_statns_list *);

extern  void guestfs_free_statns (struct guestfs_statns *);
extern  void guestfs_free_statns_list (struct guestfs_statns_list *);

struct guestfs_statvfs {
  int64_t bsize;
  int64_t frsize;
  int64_t blocks;
  int64_t bfree;
  int64_t bavail;
  int64_t files;
  int64_t ffree;
  int64_t favail;
  int64_t fsid;
  int64_t flag;
  int64_t namemax;
};

struct guestfs_statvfs_list {
  uint32_t len;
  struct guestfs_statvfs *val;
};

extern  int guestfs_compare_statvfs (const struct guestfs_statvfs *, const struct guestfs_statvfs *);
extern  int guestfs_compare_statvfs_list (const struct guestfs_statvfs_list *, const struct guestfs_statvfs_list *);

extern  struct guestfs_statvfs *guestfs_copy_statvfs (const struct guestfs_statvfs *);
extern  struct guestfs_statvfs_list *guestfs_copy_statvfs_list (const struct guestfs_statvfs_list *);

extern  void guestfs_free_statvfs (struct guestfs_statvfs *);
extern  void guestfs_free_statvfs_list (struct guestfs_statvfs_list *);

struct guestfs_utsname {
  char *uts_sysname;
  char *uts_release;
  char *uts_version;
  char *uts_machine;
};

struct guestfs_utsname_list {
  uint32_t len;
  struct guestfs_utsname *val;
};

extern  int guestfs_compare_utsname (const struct guestfs_utsname *, const struct guestfs_utsname *);
extern  int guestfs_compare_utsname_list (const struct guestfs_utsname_list *, const struct guestfs_utsname_list *);

extern  struct guestfs_utsname *guestfs_copy_utsname (const struct guestfs_utsname *);
extern  struct guestfs_utsname_list *guestfs_copy_utsname_list (const struct guestfs_utsname_list *);

extern  void guestfs_free_utsname (struct guestfs_utsname *);
extern  void guestfs_free_utsname_list (struct guestfs_utsname_list *);

struct guestfs_version {
  int64_t major;
  int64_t minor;
  int64_t release;
  char *extra;
};

struct guestfs_version_list {
  uint32_t len;
  struct guestfs_version *val;
};

extern  int guestfs_compare_version (const struct guestfs_version *, const struct guestfs_version *);
extern  int guestfs_compare_version_list (const struct guestfs_version_list *, const struct guestfs_version_list *);

extern  struct guestfs_version *guestfs_copy_version (const struct guestfs_version *);
extern  struct guestfs_version_list *guestfs_copy_version_list (const struct guestfs_version_list *);

extern  void guestfs_free_version (struct guestfs_version *);
extern  void guestfs_free_version_list (struct guestfs_version_list *);

struct guestfs_xattr {
  char *attrname;
  uint32_t attrval_len;
  char *attrval;
};

struct guestfs_xattr_list {
  uint32_t len;
  struct guestfs_xattr *val;
};

extern  int guestfs_compare_xattr (const struct guestfs_xattr *, const struct guestfs_xattr *);
extern  int guestfs_compare_xattr_list (const struct guestfs_xattr_list *, const struct guestfs_xattr_list *);

extern  struct guestfs_xattr *guestfs_copy_xattr (const struct guestfs_xattr *);
extern  struct guestfs_xattr_list *guestfs_copy_xattr_list (const struct guestfs_xattr_list *);

extern  void guestfs_free_xattr (struct guestfs_xattr *);
extern  void guestfs_free_xattr_list (struct guestfs_xattr_list *);

struct guestfs_xfsinfo {
  char *xfs_mntpoint;
  uint32_t xfs_inodesize;
  uint32_t xfs_agcount;
  uint32_t xfs_agsize;
  uint32_t xfs_sectsize;
  uint32_t xfs_attr;
  uint32_t xfs_blocksize;
  uint64_t xfs_datablocks;
  uint32_t xfs_imaxpct;
  uint32_t xfs_sunit;
  uint32_t xfs_swidth;
  uint32_t xfs_dirversion;
  uint32_t xfs_dirblocksize;
  uint32_t xfs_cimode;
  char *xfs_logname;
  uint32_t xfs_logblocksize;
  uint32_t xfs_logblocks;
  uint32_t xfs_logversion;
  uint32_t xfs_logsectsize;
  uint32_t xfs_logsunit;
  uint32_t xfs_lazycount;
  char *xfs_rtname;
  uint32_t xfs_rtextsize;
  uint64_t xfs_rtblocks;
  uint64_t xfs_rtextents;
};

struct guestfs_xfsinfo_list {
  uint32_t len;
  struct guestfs_xfsinfo *val;
};

extern  int guestfs_compare_xfsinfo (const struct guestfs_xfsinfo *, const struct guestfs_xfsinfo *);
extern  int guestfs_compare_xfsinfo_list (const struct guestfs_xfsinfo_list *, const struct guestfs_xfsinfo_list *);

extern  struct guestfs_xfsinfo *guestfs_copy_xfsinfo (const struct guestfs_xfsinfo *);
extern  struct guestfs_xfsinfo_list *guestfs_copy_xfsinfo_list (const struct guestfs_xfsinfo_list *);

extern  void guestfs_free_xfsinfo (struct guestfs_xfsinfo *);
extern  void guestfs_free_xfsinfo_list (struct guestfs_xfsinfo_list *);

/* Actions. */
extern  int guestfs_acl_delete_def_file (guestfs_h *g, const char *dir);

extern  char *guestfs_acl_get_file (guestfs_h *g, const char *path, const char *acltype);

extern  int guestfs_acl_set_file (guestfs_h *g, const char *path, const char *acltype, const char *acl);
]]

--[[
extern  int guestfs_add_cdrom (guestfs_h *g, const char *filename)
  GUESTFS_DEPRECATED_BY ("add_drive_ro");
--]]

ffi.cdef[[
extern  int guestfs_add_domain (guestfs_h *g, const char *dom, ...);
extern  int guestfs_add_domain_va (guestfs_h *g, const char *dom, va_list args);

struct guestfs_add_domain_argv {
  uint64_t bitmask;
  const char *libvirturi;
  int readonly;
  const char *iface;
  int live;
  int allowuuid;
  const char *readonlydisk;
  const char *cachemode;
  const char *discard;
  int copyonread;
};

extern  int guestfs_add_domain_argv (guestfs_h *g, const char *dom, const struct guestfs_add_domain_argv *optargs);

extern  int guestfs_add_drive (guestfs_h *g, const char *filename);

extern  int guestfs_add_drive_opts (guestfs_h *g, const char *filename, ...);
extern  int guestfs_add_drive_opts_va (guestfs_h *g, const char *filename, va_list args);

struct guestfs_add_drive_opts_argv {
  uint64_t bitmask;
  int readonly;
  const char *format;
  const char *iface;
  const char *name;
  const char *label;
  const char *protocol;
  char *const *server;
  const char *username;
  const char *secret;
  const char *cachemode;
  const char *discard;
  int copyonread;
};

extern  int guestfs_add_drive_opts_argv (guestfs_h *g, const char *filename, const struct guestfs_add_drive_opts_argv *optargs);

extern  int guestfs_add_drive_ro (guestfs_h *g, const char *filename);
]]

--[[
extern  int guestfs_add_drive_ro_with_if (guestfs_h *g, const char *filename, const char *iface)
  GUESTFS_DEPRECATED_BY ("add_drive");
--]]

ffi.cdef[[
extern  int guestfs_add_drive_scratch (guestfs_h *g, int64_t size, ...);
extern  int guestfs_add_drive_scratch_va (guestfs_h *g, int64_t size, va_list args);

struct guestfs_add_drive_scratch_argv {
  uint64_t bitmask;
  const char *name;
  const char *label;
};

extern  int guestfs_add_drive_scratch_argv (guestfs_h *g, int64_t size, const struct guestfs_add_drive_scratch_argv *optargs);
]]

--[[
extern  int guestfs_add_drive_with_if (guestfs_h *g, const char *filename, const char *iface)
  GUESTFS_DEPRECATED_BY ("add_drive");
--]]

ffi.cdef[[
extern  int guestfs_aug_clear (guestfs_h *g, const char *augpath);

extern  int guestfs_aug_close (guestfs_h *g);

extern  struct guestfs_int_bool *guestfs_aug_defnode (guestfs_h *g, const char *name, const char *expr, const char *val);

extern  int guestfs_aug_defvar (guestfs_h *g, const char *name, const char *expr);

extern  char *guestfs_aug_get (guestfs_h *g, const char *augpath);

extern  int guestfs_aug_init (guestfs_h *g, const char *root, int flags);

extern  int guestfs_aug_insert (guestfs_h *g, const char *augpath, const char *label, int before);

extern  char *guestfs_aug_label (guestfs_h *g, const char *augpath);

extern  int guestfs_aug_load (guestfs_h *g);

extern  char **guestfs_aug_ls (guestfs_h *g, const char *augpath);

extern  char **guestfs_aug_match (guestfs_h *g, const char *augpath);

extern  int guestfs_aug_mv (guestfs_h *g, const char *src, const char *dest);

extern  int guestfs_aug_rm (guestfs_h *g, const char *augpath);

extern  int guestfs_aug_save (guestfs_h *g);

extern  int guestfs_aug_set (guestfs_h *g, const char *augpath, const char *val);

extern  int guestfs_aug_setm (guestfs_h *g, const char *base, const char *sub, const char *val);

extern  int guestfs_available (guestfs_h *g, char *const *groups);

extern  char **guestfs_available_all_groups (guestfs_h *g);

extern  int guestfs_base64_in (guestfs_h *g, const char *base64file, const char *filename);

extern  int guestfs_base64_out (guestfs_h *g, const char *filename, const char *base64file);

extern  int guestfs_blkdiscard (guestfs_h *g, const char *device);

extern  int guestfs_blkdiscardzeroes (guestfs_h *g, const char *device);

extern  char **guestfs_blkid (guestfs_h *g, const char *device);

extern  int guestfs_blockdev_flushbufs (guestfs_h *g, const char *device);

extern  int guestfs_blockdev_getbsz (guestfs_h *g, const char *device);

extern  int guestfs_blockdev_getro (guestfs_h *g, const char *device);

extern  int64_t guestfs_blockdev_getsize64 (guestfs_h *g, const char *device);

extern  int guestfs_blockdev_getss (guestfs_h *g, const char *device);

extern  int64_t guestfs_blockdev_getsz (guestfs_h *g, const char *device);

extern  int guestfs_blockdev_rereadpt (guestfs_h *g, const char *device);
]]

--[[
extern  int guestfs_blockdev_setbsz (guestfs_h *g, const char *device, int blocksize)
  GUESTFS_DEPRECATED_BY ("mkfs");
--]]

ffi.cdef[[
extern  int guestfs_blockdev_setro (guestfs_h *g, const char *device);

extern  int guestfs_blockdev_setrw (guestfs_h *g, const char *device);

extern  int guestfs_btrfs_device_add (guestfs_h *g, char *const *devices, const char *fs);

extern  int guestfs_btrfs_device_delete (guestfs_h *g, char *const *devices, const char *fs);

extern  int guestfs_btrfs_filesystem_balance (guestfs_h *g, const char *fs);

extern  int guestfs_btrfs_filesystem_resize (guestfs_h *g, const char *mountpoint, ...);
extern  int guestfs_btrfs_filesystem_resize_va (guestfs_h *g, const char *mountpoint, va_list args);

struct guestfs_btrfs_filesystem_resize_argv {
  uint64_t bitmask;
  int64_t size;
};

extern  int guestfs_btrfs_filesystem_resize_argv (guestfs_h *g, const char *mountpoint, const struct guestfs_btrfs_filesystem_resize_argv *optargs);

extern  int guestfs_btrfs_filesystem_sync (guestfs_h *g, const char *fs);

extern  int guestfs_btrfs_fsck (guestfs_h *g, const char *device, ...);
extern  int guestfs_btrfs_fsck_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_btrfs_fsck_argv {
  uint64_t bitmask;
  int64_t superblock;
  int repair;
};

extern  int guestfs_btrfs_fsck_argv (guestfs_h *g, const char *device, const struct guestfs_btrfs_fsck_argv *optargs);

extern  int guestfs_btrfs_set_seeding (guestfs_h *g, const char *device, int seeding);

extern  int guestfs_btrfs_subvolume_create (guestfs_h *g, const char *dest);

extern  int guestfs_btrfs_subvolume_delete (guestfs_h *g, const char *subvolume);

extern  struct guestfs_btrfssubvolume_list *guestfs_btrfs_subvolume_list (guestfs_h *g, const char *fs);

extern  int guestfs_btrfs_subvolume_set_default (guestfs_h *g, int64_t id, const char *fs);

extern  int guestfs_btrfs_subvolume_snapshot (guestfs_h *g, const char *source, const char *dest);

extern  int64_t guestfs_c_pointer (guestfs_h *g);

extern  char *guestfs_canonical_device_name (guestfs_h *g, const char *device);

extern  char *guestfs_cap_get_file (guestfs_h *g, const char *path);

extern  int guestfs_cap_set_file (guestfs_h *g, const char *path, const char *cap);

extern  char *guestfs_case_sensitive_path (guestfs_h *g, const char *path);

extern  char *guestfs_cat (guestfs_h *g, const char *path);

extern  char *guestfs_checksum (guestfs_h *g, const char *csumtype, const char *path);

extern  char *guestfs_checksum_device (guestfs_h *g, const char *csumtype, const char *device);

extern  int guestfs_checksums_out (guestfs_h *g, const char *csumtype, const char *directory, const char *sumsfile);

extern  int guestfs_chmod (guestfs_h *g, int mode, const char *path);

extern  int guestfs_chown (guestfs_h *g, int owner, int group, const char *path);

extern  int guestfs_clear_backend_setting (guestfs_h *g, const char *name);

extern  char *guestfs_command (guestfs_h *g, char *const *arguments);

extern  char **guestfs_command_lines (guestfs_h *g, char *const *arguments);

extern  int guestfs_compress_device_out (guestfs_h *g, const char *ctype, const char *device, const char *zdevice, ...);
extern  int guestfs_compress_device_out_va (guestfs_h *g, const char *ctype, const char *device, const char *zdevice, va_list args);

struct guestfs_compress_device_out_argv {
  uint64_t bitmask;
  int level;
};

extern  int guestfs_compress_device_out_argv (guestfs_h *g, const char *ctype, const char *device, const char *zdevice, const struct guestfs_compress_device_out_argv *optargs);

extern  int guestfs_compress_out (guestfs_h *g, const char *ctype, const char *file, const char *zfile, ...);
extern  int guestfs_compress_out_va (guestfs_h *g, const char *ctype, const char *file, const char *zfile, va_list args);

struct guestfs_compress_out_argv {
  uint64_t bitmask;
  int level;
};

extern  int guestfs_compress_out_argv (guestfs_h *g, const char *ctype, const char *file, const char *zfile, const struct guestfs_compress_out_argv *optargs);

extern  int guestfs_config (guestfs_h *g, const char *hvparam, const char *hvvalue);

extern  int guestfs_copy_attributes (guestfs_h *g, const char *src, const char *dest, ...);
extern  int guestfs_copy_attributes_va (guestfs_h *g, const char *src, const char *dest, va_list args);

struct guestfs_copy_attributes_argv {
  uint64_t bitmask;
  int all;
  int mode;
  int xattributes;
  int ownership;
};

extern  int guestfs_copy_attributes_argv (guestfs_h *g, const char *src, const char *dest, const struct guestfs_copy_attributes_argv *optargs);

extern  int guestfs_copy_device_to_device (guestfs_h *g, const char *src, const char *dest, ...);
extern  int guestfs_copy_device_to_device_va (guestfs_h *g, const char *src, const char *dest, va_list args);

struct guestfs_copy_device_to_device_argv {
  uint64_t bitmask;
  int64_t srcoffset;
  int64_t destoffset;
  int64_t size;
  int sparse;
};

extern  int guestfs_copy_device_to_device_argv (guestfs_h *g, const char *src, const char *dest, const struct guestfs_copy_device_to_device_argv *optargs);

extern  int guestfs_copy_device_to_file (guestfs_h *g, const char *src, const char *dest, ...);
extern  int guestfs_copy_device_to_file_va (guestfs_h *g, const char *src, const char *dest, va_list args);

struct guestfs_copy_device_to_file_argv {
  uint64_t bitmask;
  int64_t srcoffset;
  int64_t destoffset;
  int64_t size;
  int sparse;
};

extern  int guestfs_copy_device_to_file_argv (guestfs_h *g, const char *src, const char *dest, const struct guestfs_copy_device_to_file_argv *optargs);

extern  int guestfs_copy_file_to_device (guestfs_h *g, const char *src, const char *dest, ...);
extern  int guestfs_copy_file_to_device_va (guestfs_h *g, const char *src, const char *dest, va_list args);

struct guestfs_copy_file_to_device_argv {
  uint64_t bitmask;
  int64_t srcoffset;
  int64_t destoffset;
  int64_t size;
  int sparse;
};

extern  int guestfs_copy_file_to_device_argv (guestfs_h *g, const char *src, const char *dest, const struct guestfs_copy_file_to_device_argv *optargs);

extern  int guestfs_copy_file_to_file (guestfs_h *g, const char *src, const char *dest, ...);
extern  int guestfs_copy_file_to_file_va (guestfs_h *g, const char *src, const char *dest, va_list args);

struct guestfs_copy_file_to_file_argv {
  uint64_t bitmask;
  int64_t srcoffset;
  int64_t destoffset;
  int64_t size;
  int sparse;
};

extern  int guestfs_copy_file_to_file_argv (guestfs_h *g, const char *src, const char *dest, const struct guestfs_copy_file_to_file_argv *optargs);
]]

--[[
extern  int guestfs_copy_size (guestfs_h *g, const char *src, const char *dest, int64_t size)
  GUESTFS_DEPRECATED_BY ("copy_device_to_device");
--]]

ffi.cdef[[
extern  int guestfs_cp (guestfs_h *g, const char *src, const char *dest);

extern  int guestfs_cp_a (guestfs_h *g, const char *src, const char *dest);

extern  int guestfs_cp_r (guestfs_h *g, const char *src, const char *dest);

extern  int guestfs_cpio_out (guestfs_h *g, const char *directory, const char *cpiofile, ...);
extern  int guestfs_cpio_out_va (guestfs_h *g, const char *directory, const char *cpiofile, va_list args);

struct guestfs_cpio_out_argv {
  uint64_t bitmask;
  const char *format;
};

extern  int guestfs_cpio_out_argv (guestfs_h *g, const char *directory, const char *cpiofile, const struct guestfs_cpio_out_argv *optargs);
]]

--[[
extern  int guestfs_dd (guestfs_h *g, const char *src, const char *dest)
  GUESTFS_DEPRECATED_BY ("copy_device_to_device");
--]]

ffi.cdef[[
extern  char *guestfs_debug (guestfs_h *g, const char *subcmd, char *const *extraargs);

extern  char **guestfs_debug_drives (guestfs_h *g);

extern  int guestfs_debug_upload (guestfs_h *g, const char *filename, const char *tmpname, int mode);

extern  int guestfs_device_index (guestfs_h *g, const char *device);

extern  char *guestfs_df (guestfs_h *g);

extern  char *guestfs_df_h (guestfs_h *g);

extern  int guestfs_disk_create (guestfs_h *g, const char *filename, const char *format, int64_t size, ...);
extern  int guestfs_disk_create_va (guestfs_h *g, const char *filename, const char *format, int64_t size, va_list args);

struct guestfs_disk_create_argv {
  uint64_t bitmask;
  const char *backingfile;
  const char *backingformat;
  const char *preallocation;
  const char *compat;
  int clustersize;
};

extern  int guestfs_disk_create_argv (guestfs_h *g, const char *filename, const char *format, int64_t size, const struct guestfs_disk_create_argv *optargs);

extern  char *guestfs_disk_format (guestfs_h *g, const char *filename);

extern  int guestfs_disk_has_backing_file (guestfs_h *g, const char *filename);

extern  int64_t guestfs_disk_virtual_size (guestfs_h *g, const char *filename);

extern  char *guestfs_dmesg (guestfs_h *g);

extern  int guestfs_download (guestfs_h *g, const char *remotefilename, const char *filename);

extern  int guestfs_download_offset (guestfs_h *g, const char *remotefilename, const char *filename, int64_t offset, int64_t size);

extern  int guestfs_drop_caches (guestfs_h *g, int whattodrop);

extern  int64_t guestfs_du (guestfs_h *g, const char *path);

extern  int guestfs_e2fsck (guestfs_h *g, const char *device, ...);
extern  int guestfs_e2fsck_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_e2fsck_argv {
  uint64_t bitmask;
  int correct;
  int forceall;
};

extern  int guestfs_e2fsck_argv (guestfs_h *g, const char *device, const struct guestfs_e2fsck_argv *optargs);
]]

--[[
extern  int guestfs_e2fsck_f (guestfs_h *g, const char *device)
  GUESTFS_DEPRECATED_BY ("e2fsck");
--]]

ffi.cdef[[
extern  char *guestfs_echo_daemon (guestfs_h *g, char *const *words);
]]

--[[
extern  char **guestfs_egrep (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");

extern  char **guestfs_egrepi (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");
--]]

ffi.cdef[[
extern  int guestfs_equal (guestfs_h *g, const char *file1, const char *file2);

extern  int guestfs_exists (guestfs_h *g, const char *path);

extern  int guestfs_extlinux (guestfs_h *g, const char *directory);
]]

--[[
extern  int guestfs_fallocate (guestfs_h *g, const char *path, int len)
  GUESTFS_DEPRECATED_BY ("fallocate64");
--]]

ffi.cdef[[
extern  int guestfs_fallocate64 (guestfs_h *g, const char *path, int64_t len);

extern  int guestfs_feature_available (guestfs_h *g, char *const *groups);
]]

--[[
extern  char **guestfs_fgrep (guestfs_h *g, const char *pattern, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");

extern  char **guestfs_fgrepi (guestfs_h *g, const char *pattern, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");
--]]

ffi.cdef[[
extern  char *guestfs_file (guestfs_h *g, const char *path);

extern  char *guestfs_file_architecture (guestfs_h *g, const char *filename);

extern  int64_t guestfs_filesize (guestfs_h *g, const char *file);

extern  int guestfs_filesystem_available (guestfs_h *g, const char *filesystem);

extern  int guestfs_fill (guestfs_h *g, int c, int len, const char *path);

extern  int guestfs_fill_dir (guestfs_h *g, const char *dir, int nr);

extern  int guestfs_fill_pattern (guestfs_h *g, const char *pattern, int len, const char *path);

extern  char **guestfs_find (guestfs_h *g, const char *directory);

extern  int guestfs_find0 (guestfs_h *g, const char *directory, const char *files);

extern  char *guestfs_findfs_label (guestfs_h *g, const char *label);

extern  char *guestfs_findfs_uuid (guestfs_h *g, const char *uuid);

extern  int guestfs_fsck (guestfs_h *g, const char *fstype, const char *device);

extern  int guestfs_fstrim (guestfs_h *g, const char *mountpoint, ...);
extern  int guestfs_fstrim_va (guestfs_h *g, const char *mountpoint, va_list args);

struct guestfs_fstrim_argv {
  uint64_t bitmask;
  int64_t offset;
  int64_t length;
  int64_t minimumfreeextent;
};

extern  int guestfs_fstrim_argv (guestfs_h *g, const char *mountpoint, const struct guestfs_fstrim_argv *optargs);

extern  const char *guestfs_get_append (guestfs_h *g);
]]

--[[
extern  char *guestfs_get_attach_method (guestfs_h *g)
  GUESTFS_DEPRECATED_BY ("get_backend");
--]]

ffi.cdef[[
extern  int guestfs_get_autosync (guestfs_h *g);

extern  char *guestfs_get_backend (guestfs_h *g);

extern  char *guestfs_get_backend_setting (guestfs_h *g, const char *name);

extern  char **guestfs_get_backend_settings (guestfs_h *g);

extern  char *guestfs_get_cachedir (guestfs_h *g);

extern  int guestfs_get_direct (guestfs_h *g);

extern  char *guestfs_get_e2attrs (guestfs_h *g, const char *file);

extern  int64_t guestfs_get_e2generation (guestfs_h *g, const char *file);
]]

--[[
extern  char *guestfs_get_e2label (guestfs_h *g, const char *device)
  GUESTFS_DEPRECATED_BY ("vfs_label");

extern  char *guestfs_get_e2uuid (guestfs_h *g, const char *device)
  GUESTFS_DEPRECATED_BY ("vfs_uuid");
--]]

ffi.cdef[[
extern  char *guestfs_get_hv (guestfs_h *g);

extern  char *guestfs_get_libvirt_requested_credential_challenge (guestfs_h *g, int index);

extern  char *guestfs_get_libvirt_requested_credential_defresult (guestfs_h *g, int index);

extern  char *guestfs_get_libvirt_requested_credential_prompt (guestfs_h *g, int index);

extern  char **guestfs_get_libvirt_requested_credentials (guestfs_h *g);

extern  int guestfs_get_memsize (guestfs_h *g);

extern  int guestfs_get_network (guestfs_h *g);

extern  const char *guestfs_get_path (guestfs_h *g);

extern  int guestfs_get_pgroup (guestfs_h *g);

extern  int guestfs_get_pid (guestfs_h *g);

extern  const char *guestfs_get_program (guestfs_h *g);
]]

--[[
extern  const char *guestfs_get_qemu (guestfs_h *g)
  GUESTFS_DEPRECATED_BY ("get_hv");
--]]

ffi.cdef[[
extern  int guestfs_get_recovery_proc (guestfs_h *g);

extern  int guestfs_get_selinux (guestfs_h *g);

extern  int guestfs_get_smp (guestfs_h *g);

extern  int guestfs_get_state (guestfs_h *g);

extern  char *guestfs_get_tmpdir (guestfs_h *g);

extern  int guestfs_get_trace (guestfs_h *g);

extern  int guestfs_get_umask (guestfs_h *g);

extern  int guestfs_get_verbose (guestfs_h *g);

extern  char *guestfs_getcon (guestfs_h *g);

extern  char *guestfs_getxattr (guestfs_h *g, const char *path, const char *name, size_t *size_r);

extern  struct guestfs_xattr_list *guestfs_getxattrs (guestfs_h *g, const char *path);

extern  char **guestfs_glob_expand (guestfs_h *g, const char *pattern);

extern  char **guestfs_grep (guestfs_h *g, const char *regex, const char *path);

extern  char **guestfs_grep_opts (guestfs_h *g, const char *regex, const char *path, ...);
extern  char **guestfs_grep_opts_va (guestfs_h *g, const char *regex, const char *path, va_list args);

struct guestfs_grep_opts_argv {
  uint64_t bitmask;
  int extended;
  int fixed;
  int insensitive;
  int compressed;
};

extern  char **guestfs_grep_opts_argv (guestfs_h *g, const char *regex, const char *path, const struct guestfs_grep_opts_argv *optargs);
]]

--[[
extern  char **guestfs_grepi (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");
--]]

ffi.cdef[[
extern  int guestfs_grub_install (guestfs_h *g, const char *root, const char *device);

extern  char **guestfs_head (guestfs_h *g, const char *path);

extern  char **guestfs_head_n (guestfs_h *g, int nrlines, const char *path);

extern  char *guestfs_hexdump (guestfs_h *g, const char *path);

extern  int guestfs_hivex_close (guestfs_h *g);

extern  int guestfs_hivex_commit (guestfs_h *g, const char *filename);

extern  int64_t guestfs_hivex_node_add_child (guestfs_h *g, int64_t parent, const char *name);

extern  struct guestfs_hivex_node_list *guestfs_hivex_node_children (guestfs_h *g, int64_t nodeh);

extern  int guestfs_hivex_node_delete_child (guestfs_h *g, int64_t nodeh);

extern  int64_t guestfs_hivex_node_get_child (guestfs_h *g, int64_t nodeh, const char *name);

extern  int64_t guestfs_hivex_node_get_value (guestfs_h *g, int64_t nodeh, const char *key);

extern  char *guestfs_hivex_node_name (guestfs_h *g, int64_t nodeh);

extern  int64_t guestfs_hivex_node_parent (guestfs_h *g, int64_t nodeh);

extern  int guestfs_hivex_node_set_value (guestfs_h *g, int64_t nodeh, const char *key, int64_t t, const char *val, size_t val_size);

extern  struct guestfs_hivex_value_list *guestfs_hivex_node_values (guestfs_h *g, int64_t nodeh);

extern  int guestfs_hivex_open (guestfs_h *g, const char *filename, ...);
extern  int guestfs_hivex_open_va (guestfs_h *g, const char *filename, va_list args);

struct guestfs_hivex_open_argv {
  uint64_t bitmask;
  int verbose;
  int debug;
  int write;
};

extern  int guestfs_hivex_open_argv (guestfs_h *g, const char *filename, const struct guestfs_hivex_open_argv *optargs);

extern  int64_t guestfs_hivex_root (guestfs_h *g);

extern  char *guestfs_hivex_value_key (guestfs_h *g, int64_t valueh);

extern  int64_t guestfs_hivex_value_type (guestfs_h *g, int64_t valueh);

extern  char *guestfs_hivex_value_utf8 (guestfs_h *g, int64_t valueh);

extern  char *guestfs_hivex_value_value (guestfs_h *g, int64_t valueh, size_t *size_r);

extern  char *guestfs_initrd_cat (guestfs_h *g, const char *initrdpath, const char *filename, size_t *size_r);

extern  char **guestfs_initrd_list (guestfs_h *g, const char *path);

extern  int64_t guestfs_inotify_add_watch (guestfs_h *g, const char *path, int mask);

extern  int guestfs_inotify_close (guestfs_h *g);

extern  char **guestfs_inotify_files (guestfs_h *g);

extern  int guestfs_inotify_init (guestfs_h *g, int maxevents);

extern  struct guestfs_inotify_event_list *guestfs_inotify_read (guestfs_h *g);

extern  int guestfs_inotify_rm_watch (guestfs_h *g, int wd);

extern  char *guestfs_inspect_get_arch (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_distro (guestfs_h *g, const char *root);

extern  char **guestfs_inspect_get_drive_mappings (guestfs_h *g, const char *root);

extern  char **guestfs_inspect_get_filesystems (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_format (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_hostname (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_icon (guestfs_h *g, const char *root, size_t *size_r, ...);
extern  char *guestfs_inspect_get_icon_va (guestfs_h *g, const char *root, size_t *size_r, va_list args);

struct guestfs_inspect_get_icon_argv {
  uint64_t bitmask;
  int favicon;
  int highquality;
};

extern  char *guestfs_inspect_get_icon_argv (guestfs_h *g, const char *root, size_t *size_r, const struct guestfs_inspect_get_icon_argv *optargs);

extern  int guestfs_inspect_get_major_version (guestfs_h *g, const char *root);

extern  int guestfs_inspect_get_minor_version (guestfs_h *g, const char *root);

extern  char **guestfs_inspect_get_mountpoints (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_package_format (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_package_management (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_product_name (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_product_variant (guestfs_h *g, const char *root);

extern  char **guestfs_inspect_get_roots (guestfs_h *g);

extern  char *guestfs_inspect_get_type (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_windows_current_control_set (guestfs_h *g, const char *root);

extern  char *guestfs_inspect_get_windows_systemroot (guestfs_h *g, const char *root);

extern  int guestfs_inspect_is_live (guestfs_h *g, const char *root);

extern  int guestfs_inspect_is_multipart (guestfs_h *g, const char *root);

extern  int guestfs_inspect_is_netinst (guestfs_h *g, const char *root);
]]

--[[
extern  struct guestfs_application_list *guestfs_inspect_list_applications (guestfs_h *g, const char *root)
  GUESTFS_DEPRECATED_BY ("inspect_list_applications2");
--]]

ffi.cdef[[
extern  struct guestfs_application2_list *guestfs_inspect_list_applications2 (guestfs_h *g, const char *root);

extern  char **guestfs_inspect_os (guestfs_h *g);

extern  int guestfs_is_blockdev (guestfs_h *g, const char *path);

extern  int guestfs_is_blockdev_opts (guestfs_h *g, const char *path, ...);
extern  int guestfs_is_blockdev_opts_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_is_blockdev_opts_argv {
  uint64_t bitmask;
  int followsymlinks;
};

extern  int guestfs_is_blockdev_opts_argv (guestfs_h *g, const char *path, const struct guestfs_is_blockdev_opts_argv *optargs);

extern  int guestfs_is_busy (guestfs_h *g);

extern  int guestfs_is_chardev (guestfs_h *g, const char *path);

extern  int guestfs_is_chardev_opts (guestfs_h *g, const char *path, ...);
extern  int guestfs_is_chardev_opts_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_is_chardev_opts_argv {
  uint64_t bitmask;
  int followsymlinks;
};

extern  int guestfs_is_chardev_opts_argv (guestfs_h *g, const char *path, const struct guestfs_is_chardev_opts_argv *optargs);

extern  int guestfs_is_config (guestfs_h *g);

extern  int guestfs_is_dir (guestfs_h *g, const char *path);

extern  int guestfs_is_dir_opts (guestfs_h *g, const char *path, ...);
extern  int guestfs_is_dir_opts_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_is_dir_opts_argv {
  uint64_t bitmask;
  int followsymlinks;
};

extern  int guestfs_is_dir_opts_argv (guestfs_h *g, const char *path, const struct guestfs_is_dir_opts_argv *optargs);

extern  int guestfs_is_fifo (guestfs_h *g, const char *path);

extern  int guestfs_is_fifo_opts (guestfs_h *g, const char *path, ...);
extern  int guestfs_is_fifo_opts_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_is_fifo_opts_argv {
  uint64_t bitmask;
  int followsymlinks;
};

extern  int guestfs_is_fifo_opts_argv (guestfs_h *g, const char *path, const struct guestfs_is_fifo_opts_argv *optargs);

extern  int guestfs_is_file (guestfs_h *g, const char *path);

extern  int guestfs_is_file_opts (guestfs_h *g, const char *path, ...);
extern  int guestfs_is_file_opts_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_is_file_opts_argv {
  uint64_t bitmask;
  int followsymlinks;
};

extern  int guestfs_is_file_opts_argv (guestfs_h *g, const char *path, const struct guestfs_is_file_opts_argv *optargs);

extern  int guestfs_is_launching (guestfs_h *g);

extern  int guestfs_is_lv (guestfs_h *g, const char *device);

extern  int guestfs_is_ready (guestfs_h *g);

extern  int guestfs_is_socket (guestfs_h *g, const char *path);

extern  int guestfs_is_socket_opts (guestfs_h *g, const char *path, ...);
extern  int guestfs_is_socket_opts_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_is_socket_opts_argv {
  uint64_t bitmask;
  int followsymlinks;
};

extern  int guestfs_is_socket_opts_argv (guestfs_h *g, const char *path, const struct guestfs_is_socket_opts_argv *optargs);

extern  int guestfs_is_symlink (guestfs_h *g, const char *path);

extern  int guestfs_is_whole_device (guestfs_h *g, const char *device);

extern  int guestfs_is_zero (guestfs_h *g, const char *path);

extern  int guestfs_is_zero_device (guestfs_h *g, const char *device);

extern  struct guestfs_isoinfo *guestfs_isoinfo (guestfs_h *g, const char *isofile);

extern  struct guestfs_isoinfo *guestfs_isoinfo_device (guestfs_h *g, const char *device);

extern  int guestfs_journal_close (guestfs_h *g);

extern  struct guestfs_xattr_list *guestfs_journal_get (guestfs_h *g);

extern  int64_t guestfs_journal_get_data_threshold (guestfs_h *g);

extern  int64_t guestfs_journal_get_realtime_usec (guestfs_h *g);

extern  int guestfs_journal_next (guestfs_h *g);

extern  int guestfs_journal_open (guestfs_h *g, const char *directory);

extern  int guestfs_journal_set_data_threshold (guestfs_h *g, int64_t threshold);

extern  int64_t guestfs_journal_skip (guestfs_h *g, int64_t skip);
]]

--[[
extern  int guestfs_kill_subprocess (guestfs_h *g)
  GUESTFS_DEPRECATED_BY ("shutdown");
--]]

ffi.cdef[[
extern  int guestfs_launch (guestfs_h *g);

extern  int guestfs_lchown (guestfs_h *g, int owner, int group, const char *path);

extern  int guestfs_ldmtool_create_all (guestfs_h *g);

extern  char **guestfs_ldmtool_diskgroup_disks (guestfs_h *g, const char *diskgroup);

extern  char *guestfs_ldmtool_diskgroup_name (guestfs_h *g, const char *diskgroup);

extern  char **guestfs_ldmtool_diskgroup_volumes (guestfs_h *g, const char *diskgroup);

extern  int guestfs_ldmtool_remove_all (guestfs_h *g);

extern  char **guestfs_ldmtool_scan (guestfs_h *g);

extern  char **guestfs_ldmtool_scan_devices (guestfs_h *g, char *const *devices);

extern  char *guestfs_ldmtool_volume_hint (guestfs_h *g, const char *diskgroup, const char *volume);

extern  char **guestfs_ldmtool_volume_partitions (guestfs_h *g, const char *diskgroup, const char *volume);

extern  char *guestfs_ldmtool_volume_type (guestfs_h *g, const char *diskgroup, const char *volume);

extern  char *guestfs_lgetxattr (guestfs_h *g, const char *path, const char *name, size_t *size_r);

extern  struct guestfs_xattr_list *guestfs_lgetxattrs (guestfs_h *g, const char *path);

extern  char **guestfs_list_9p (guestfs_h *g);

extern  char **guestfs_list_devices (guestfs_h *g);

extern  char **guestfs_list_disk_labels (guestfs_h *g);

extern  char **guestfs_list_dm_devices (guestfs_h *g);

extern  char **guestfs_list_filesystems (guestfs_h *g);

extern  char **guestfs_list_ldm_partitions (guestfs_h *g);

extern  char **guestfs_list_ldm_volumes (guestfs_h *g);

extern  char **guestfs_list_md_devices (guestfs_h *g);

extern  char **guestfs_list_partitions (guestfs_h *g);

extern  char *guestfs_ll (guestfs_h *g, const char *directory);

extern  char *guestfs_llz (guestfs_h *g, const char *directory);

extern  int guestfs_ln (guestfs_h *g, const char *target, const char *linkname);

extern  int guestfs_ln_f (guestfs_h *g, const char *target, const char *linkname);

extern  int guestfs_ln_s (guestfs_h *g, const char *target, const char *linkname);

extern  int guestfs_ln_sf (guestfs_h *g, const char *target, const char *linkname);

extern  int guestfs_lremovexattr (guestfs_h *g, const char *xattr, const char *path);

extern  char **guestfs_ls (guestfs_h *g, const char *directory);

extern  int guestfs_ls0 (guestfs_h *g, const char *dir, const char *filenames);

extern  int guestfs_lsetxattr (guestfs_h *g, const char *xattr, const char *val, int vallen, const char *path);
]]

--[[
extern  struct guestfs_stat *guestfs_lstat (guestfs_h *g, const char *path)
  GUESTFS_DEPRECATED_BY ("lstatns");

extern  struct guestfs_stat_list *guestfs_lstatlist (guestfs_h *g, const char *path, char *const *names)
  GUESTFS_DEPRECATED_BY ("lstatnslist");
--]]

ffi.cdef[[
extern  struct guestfs_statns *guestfs_lstatns (guestfs_h *g, const char *path);

extern  struct guestfs_statns_list *guestfs_lstatnslist (guestfs_h *g, const char *path, char *const *names);

extern  int guestfs_luks_add_key (guestfs_h *g, const char *device, const char *key, const char *newkey, int keyslot);

extern  int guestfs_luks_close (guestfs_h *g, const char *device);

extern  int guestfs_luks_format (guestfs_h *g, const char *device, const char *key, int keyslot);

extern  int guestfs_luks_format_cipher (guestfs_h *g, const char *device, const char *key, int keyslot, const char *cipher);

extern  int guestfs_luks_kill_slot (guestfs_h *g, const char *device, const char *key, int keyslot);

extern  int guestfs_luks_open (guestfs_h *g, const char *device, const char *key, const char *mapname);

extern  int guestfs_luks_open_ro (guestfs_h *g, const char *device, const char *key, const char *mapname);

extern  int guestfs_lvcreate (guestfs_h *g, const char *logvol, const char *volgroup, int mbytes);

extern  int guestfs_lvcreate_free (guestfs_h *g, const char *logvol, const char *volgroup, int percent);

extern  char *guestfs_lvm_canonical_lv_name (guestfs_h *g, const char *lvname);

extern  int guestfs_lvm_clear_filter (guestfs_h *g);

extern  int guestfs_lvm_remove_all (guestfs_h *g);

extern  int guestfs_lvm_set_filter (guestfs_h *g, char *const *devices);

extern  int guestfs_lvremove (guestfs_h *g, const char *device);

extern  int guestfs_lvrename (guestfs_h *g, const char *logvol, const char *newlogvol);

extern  int guestfs_lvresize (guestfs_h *g, const char *device, int mbytes);

extern  int guestfs_lvresize_free (guestfs_h *g, const char *lv, int percent);

extern  char **guestfs_lvs (guestfs_h *g);

extern  struct guestfs_lvm_lv_list *guestfs_lvs_full (guestfs_h *g);

extern  char *guestfs_lvuuid (guestfs_h *g, const char *device);

extern  struct guestfs_xattr_list *guestfs_lxattrlist (guestfs_h *g, const char *path, char *const *names);

extern  int guestfs_max_disks (guestfs_h *g);

extern  int guestfs_md_create (guestfs_h *g, const char *name, char *const *devices, ...);
extern  int guestfs_md_create_va (guestfs_h *g, const char *name, char *const *devices, va_list args);

struct guestfs_md_create_argv {
  uint64_t bitmask;
  int64_t missingbitmap;
  int nrdevices;
  int spare;
  int64_t chunk;
  const char *level;
};

extern  int guestfs_md_create_argv (guestfs_h *g, const char *name, char *const *devices, const struct guestfs_md_create_argv *optargs);

extern  char **guestfs_md_detail (guestfs_h *g, const char *md);

extern  struct guestfs_mdstat_list *guestfs_md_stat (guestfs_h *g, const char *md);

extern  int guestfs_md_stop (guestfs_h *g, const char *md);

extern  int guestfs_mkdir (guestfs_h *g, const char *path);

extern  int guestfs_mkdir_mode (guestfs_h *g, const char *path, int mode);

extern  int guestfs_mkdir_p (guestfs_h *g, const char *path);

extern  char *guestfs_mkdtemp (guestfs_h *g, const char *tmpl);

extern  int guestfs_mke2fs (guestfs_h *g, const char *device, ...);
extern  int guestfs_mke2fs_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_mke2fs_argv {
  uint64_t bitmask;
  int64_t blockscount;
  int64_t blocksize;
  int64_t fragsize;
  int64_t blockspergroup;
  int64_t numberofgroups;
  int64_t bytesperinode;
  int64_t inodesize;
  int64_t journalsize;
  int64_t numberofinodes;
  int64_t stridesize;
  int64_t stripewidth;
  int64_t maxonlineresize;
  int reservedblockspercentage;
  int mmpupdateinterval;
  const char *journaldevice;
  const char *label;
  const char *lastmounteddir;
  const char *creatoros;
  const char *fstype;
  const char *usagetype;
  const char *uuid;
  int forcecreate;
  int writesbandgrouponly;
  int lazyitableinit;
  int lazyjournalinit;
  int testfs;
  int discard;
  int quotatype;
  int extent;
  int filetype;
  int flexbg;
  int hasjournal;
  int journaldev;
  int largefile;
  int quota;
  int resizeinode;
  int sparsesuper;
  int uninitbg;
};

extern  int guestfs_mke2fs_argv (guestfs_h *g, const char *device, const struct guestfs_mke2fs_argv *optargs);
]]

--[[
extern  int guestfs_mke2fs_J (guestfs_h *g, const char *fstype, int blocksize, const char *device, const char *journal)
  GUESTFS_DEPRECATED_BY ("mke2fs");

extern  int guestfs_mke2fs_JL (guestfs_h *g, const char *fstype, int blocksize, const char *device, const char *label)
  GUESTFS_DEPRECATED_BY ("mke2fs");

extern  int guestfs_mke2fs_JU (guestfs_h *g, const char *fstype, int blocksize, const char *device, const char *uuid)
  GUESTFS_DEPRECATED_BY ("mke2fs");

extern  int guestfs_mke2journal (guestfs_h *g, int blocksize, const char *device)
  GUESTFS_DEPRECATED_BY ("mke2fs");

extern  int guestfs_mke2journal_L (guestfs_h *g, int blocksize, const char *label, const char *device)
  GUESTFS_DEPRECATED_BY ("mke2fs");

extern  int guestfs_mke2journal_U (guestfs_h *g, int blocksize, const char *uuid, const char *device)
  GUESTFS_DEPRECATED_BY ("mke2fs");
--]]

ffi.cdef[[
extern  int guestfs_mkfifo (guestfs_h *g, int mode, const char *path);

extern  int guestfs_mkfs (guestfs_h *g, const char *fstype, const char *device);

extern  int guestfs_mkfs_opts (guestfs_h *g, const char *fstype, const char *device, ...);
extern  int guestfs_mkfs_opts_va (guestfs_h *g, const char *fstype, const char *device, va_list args);

struct guestfs_mkfs_opts_argv {
  uint64_t bitmask;
  int blocksize;
  const char *features;
  int inode;
  int sectorsize;
};

extern  int guestfs_mkfs_opts_argv (guestfs_h *g, const char *fstype, const char *device, const struct guestfs_mkfs_opts_argv *optargs);
]]

--[[
extern  int guestfs_mkfs_b (guestfs_h *g, const char *fstype, int blocksize, const char *device)
  GUESTFS_DEPRECATED_BY ("mkfs");
--]]

ffi.cdef[[
extern  int guestfs_mkfs_btrfs (guestfs_h *g, char *const *devices, ...);
extern  int guestfs_mkfs_btrfs_va (guestfs_h *g, char *const *devices, va_list args);

struct guestfs_mkfs_btrfs_argv {
  uint64_t bitmask;
  int64_t allocstart;
  int64_t bytecount;
  const char *datatype;
  int leafsize;
  const char *label;
  const char *metadata;
  int nodesize;
  int sectorsize;
};

extern  int guestfs_mkfs_btrfs_argv (guestfs_h *g, char *const *devices, const struct guestfs_mkfs_btrfs_argv *optargs);

extern  int guestfs_mklost_and_found (guestfs_h *g, const char *mountpoint);

extern  int guestfs_mkmountpoint (guestfs_h *g, const char *exemptpath);

extern  int guestfs_mknod (guestfs_h *g, int mode, int devmajor, int devminor, const char *path);

extern  int guestfs_mknod_b (guestfs_h *g, int mode, int devmajor, int devminor, const char *path);

extern  int guestfs_mknod_c (guestfs_h *g, int mode, int devmajor, int devminor, const char *path);

extern  int guestfs_mkswap (guestfs_h *g, const char *device);

extern  int guestfs_mkswap_opts (guestfs_h *g, const char *device, ...);
extern  int guestfs_mkswap_opts_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_mkswap_opts_argv {
  uint64_t bitmask;
  const char *label;
  const char *uuid;
};

extern  int guestfs_mkswap_opts_argv (guestfs_h *g, const char *device, const struct guestfs_mkswap_opts_argv *optargs);
]]

--[[
extern  int guestfs_mkswap_L (guestfs_h *g, const char *label, const char *device)
  GUESTFS_DEPRECATED_BY ("mkswap");

extern  int guestfs_mkswap_U (guestfs_h *g, const char *uuid, const char *device)
  GUESTFS_DEPRECATED_BY ("mkswap");
--]]

ffi.cdef[[
extern  int guestfs_mkswap_file (guestfs_h *g, const char *path);

extern  char *guestfs_mktemp (guestfs_h *g, const char *tmpl, ...);
extern  char *guestfs_mktemp_va (guestfs_h *g, const char *tmpl, va_list args);

struct guestfs_mktemp_argv {
  uint64_t bitmask;
  const char *suffix;
};

extern  char *guestfs_mktemp_argv (guestfs_h *g, const char *tmpl, const struct guestfs_mktemp_argv *optargs);

extern  int guestfs_modprobe (guestfs_h *g, const char *modulename);

extern  int guestfs_mount (guestfs_h *g, const char *mountable, const char *mountpoint);

extern  int guestfs_mount_9p (guestfs_h *g, const char *mounttag, const char *mountpoint, ...);
extern  int guestfs_mount_9p_va (guestfs_h *g, const char *mounttag, const char *mountpoint, va_list args);

struct guestfs_mount_9p_argv {
  uint64_t bitmask;
  const char *options;
};

extern  int guestfs_mount_9p_argv (guestfs_h *g, const char *mounttag, const char *mountpoint, const struct guestfs_mount_9p_argv *optargs);

extern  int guestfs_mount_local (guestfs_h *g, const char *localmountpoint, ...);
extern  int guestfs_mount_local_va (guestfs_h *g, const char *localmountpoint, va_list args);

struct guestfs_mount_local_argv {
  uint64_t bitmask;
  int readonly;
  const char *options;
  int cachetimeout;
  int debugcalls;
};

extern  int guestfs_mount_local_argv (guestfs_h *g, const char *localmountpoint, const struct guestfs_mount_local_argv *optargs);

extern  int guestfs_mount_local_run (guestfs_h *g);

extern  int guestfs_mount_loop (guestfs_h *g, const char *file, const char *mountpoint);

extern  int guestfs_mount_options (guestfs_h *g, const char *options, const char *mountable, const char *mountpoint);

extern  int guestfs_mount_ro (guestfs_h *g, const char *mountable, const char *mountpoint);

extern  int guestfs_mount_vfs (guestfs_h *g, const char *options, const char *vfstype, const char *mountable, const char *mountpoint);

extern  char **guestfs_mountpoints (guestfs_h *g);

extern  char **guestfs_mounts (guestfs_h *g);

extern  int guestfs_mv (guestfs_h *g, const char *src, const char *dest);

extern  int guestfs_nr_devices (guestfs_h *g);

extern  int guestfs_ntfs_3g_probe (guestfs_h *g, int rw, const char *device);

extern  int guestfs_ntfsclone_in (guestfs_h *g, const char *backupfile, const char *device);

extern  int guestfs_ntfsclone_out (guestfs_h *g, const char *device, const char *backupfile, ...);
extern  int guestfs_ntfsclone_out_va (guestfs_h *g, const char *device, const char *backupfile, va_list args);

struct guestfs_ntfsclone_out_argv {
  uint64_t bitmask;
  int metadataonly;
  int rescue;
  int ignorefscheck;
  int preservetimestamps;
  int force;
};

extern  int guestfs_ntfsclone_out_argv (guestfs_h *g, const char *device, const char *backupfile, const struct guestfs_ntfsclone_out_argv *optargs);

extern  int guestfs_ntfsfix (guestfs_h *g, const char *device, ...);
extern  int guestfs_ntfsfix_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_ntfsfix_argv {
  uint64_t bitmask;
  int clearbadsectors;
};

extern  int guestfs_ntfsfix_argv (guestfs_h *g, const char *device, const struct guestfs_ntfsfix_argv *optargs);

extern  int guestfs_ntfsresize (guestfs_h *g, const char *device);

extern  int guestfs_ntfsresize_opts (guestfs_h *g, const char *device, ...);
extern  int guestfs_ntfsresize_opts_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_ntfsresize_opts_argv {
  uint64_t bitmask;
  int64_t size;
  int force;
};

extern  int guestfs_ntfsresize_opts_argv (guestfs_h *g, const char *device, const struct guestfs_ntfsresize_opts_argv *optargs);
]]

--[[
extern  int guestfs_ntfsresize_size (guestfs_h *g, const char *device, int64_t size)
  GUESTFS_DEPRECATED_BY ("ntfsresize");
--]]

ffi.cdef[[
extern  int guestfs_parse_environment (guestfs_h *g);

extern  int guestfs_parse_environment_list (guestfs_h *g, char *const *environment);

extern  int guestfs_part_add (guestfs_h *g, const char *device, const char *prlogex, int64_t startsect, int64_t endsect);

extern  int guestfs_part_del (guestfs_h *g, const char *device, int partnum);

extern  int guestfs_part_disk (guestfs_h *g, const char *device, const char *parttype);

extern  int guestfs_part_get_bootable (guestfs_h *g, const char *device, int partnum);

extern  char *guestfs_part_get_gpt_type (guestfs_h *g, const char *device, int partnum);

extern  int guestfs_part_get_mbr_id (guestfs_h *g, const char *device, int partnum);

extern  char *guestfs_part_get_name (guestfs_h *g, const char *device, int partnum);

extern  char *guestfs_part_get_parttype (guestfs_h *g, const char *device);

extern  int guestfs_part_init (guestfs_h *g, const char *device, const char *parttype);

extern  struct guestfs_partition_list *guestfs_part_list (guestfs_h *g, const char *device);

extern  int guestfs_part_set_bootable (guestfs_h *g, const char *device, int partnum, int bootable);

extern  int guestfs_part_set_gpt_type (guestfs_h *g, const char *device, int partnum, const char *guid);

extern  int guestfs_part_set_mbr_id (guestfs_h *g, const char *device, int partnum, int idbyte);

extern  int guestfs_part_set_name (guestfs_h *g, const char *device, int partnum, const char *name);

extern  char *guestfs_part_to_dev (guestfs_h *g, const char *partition);

extern  int guestfs_part_to_partnum (guestfs_h *g, const char *partition);

extern  int guestfs_ping_daemon (guestfs_h *g);

extern  char *guestfs_pread (guestfs_h *g, const char *path, int count, int64_t offset, size_t *size_r);

extern  char *guestfs_pread_device (guestfs_h *g, const char *device, int count, int64_t offset, size_t *size_r);

extern  int guestfs_pvchange_uuid (guestfs_h *g, const char *device);

extern  int guestfs_pvchange_uuid_all (guestfs_h *g);

extern  int guestfs_pvcreate (guestfs_h *g, const char *device);

extern  int guestfs_pvremove (guestfs_h *g, const char *device);

extern  int guestfs_pvresize (guestfs_h *g, const char *device);

extern  int guestfs_pvresize_size (guestfs_h *g, const char *device, int64_t size);

extern  char **guestfs_pvs (guestfs_h *g);

extern  struct guestfs_lvm_pv_list *guestfs_pvs_full (guestfs_h *g);

extern  char *guestfs_pvuuid (guestfs_h *g, const char *device);

extern  int guestfs_pwrite (guestfs_h *g, const char *path, const char *content, size_t content_size, int64_t offset);

extern  int guestfs_pwrite_device (guestfs_h *g, const char *device, const char *content, size_t content_size, int64_t offset);

extern  char *guestfs_read_file (guestfs_h *g, const char *path, size_t *size_r);

extern  char **guestfs_read_lines (guestfs_h *g, const char *path);

extern  struct guestfs_dirent_list *guestfs_readdir (guestfs_h *g, const char *dir);

extern  char *guestfs_readlink (guestfs_h *g, const char *path);

extern  char **guestfs_readlinklist (guestfs_h *g, const char *path, char *const *names);

extern  char *guestfs_realpath (guestfs_h *g, const char *path);

extern  int guestfs_remount (guestfs_h *g, const char *mountpoint, ...);
extern  int guestfs_remount_va (guestfs_h *g, const char *mountpoint, va_list args);

struct guestfs_remount_argv {
  uint64_t bitmask;
  int rw;
};

extern  int guestfs_remount_argv (guestfs_h *g, const char *mountpoint, const struct guestfs_remount_argv *optargs);

extern  int guestfs_remove_drive (guestfs_h *g, const char *label);

extern  int guestfs_removexattr (guestfs_h *g, const char *xattr, const char *path);

extern  int guestfs_rename (guestfs_h *g, const char *oldpath, const char *newpath);

extern  int guestfs_resize2fs (guestfs_h *g, const char *device);

extern  int guestfs_resize2fs_M (guestfs_h *g, const char *device);

extern  int guestfs_resize2fs_size (guestfs_h *g, const char *device, int64_t size);

extern  int guestfs_rm (guestfs_h *g, const char *path);

extern  int guestfs_rm_f (guestfs_h *g, const char *path);

extern  int guestfs_rm_rf (guestfs_h *g, const char *path);

extern  int guestfs_rmdir (guestfs_h *g, const char *path);

extern  int guestfs_rmmountpoint (guestfs_h *g, const char *exemptpath);

extern  int guestfs_rsync (guestfs_h *g, const char *src, const char *dest, ...);
extern  int guestfs_rsync_va (guestfs_h *g, const char *src, const char *dest, va_list args);

struct guestfs_rsync_argv {
  uint64_t bitmask;
  int archive;
  int deletedest;
};

extern  int guestfs_rsync_argv (guestfs_h *g, const char *src, const char *dest, const struct guestfs_rsync_argv *optargs);

extern  int guestfs_rsync_in (guestfs_h *g, const char *remote, const char *dest, ...);
extern  int guestfs_rsync_in_va (guestfs_h *g, const char *remote, const char *dest, va_list args);

struct guestfs_rsync_in_argv {
  uint64_t bitmask;
  int archive;
  int deletedest;
};

extern  int guestfs_rsync_in_argv (guestfs_h *g, const char *remote, const char *dest, const struct guestfs_rsync_in_argv *optargs);

extern  int guestfs_rsync_out (guestfs_h *g, const char *src, const char *remote, ...);
extern  int guestfs_rsync_out_va (guestfs_h *g, const char *src, const char *remote, va_list args);

struct guestfs_rsync_out_argv {
  uint64_t bitmask;
  int archive;
  int deletedest;
};

extern  int guestfs_rsync_out_argv (guestfs_h *g, const char *src, const char *remote, const struct guestfs_rsync_out_argv *optargs);

extern  int guestfs_scrub_device (guestfs_h *g, const char *device);

extern  int guestfs_scrub_file (guestfs_h *g, const char *file);

extern  int guestfs_scrub_freespace (guestfs_h *g, const char *dir);

extern  int guestfs_set_append (guestfs_h *g, const char *append);
]]

--[[
extern  int guestfs_set_attach_method (guestfs_h *g, const char *backend)
  GUESTFS_DEPRECATED_BY ("set_backend");
--]]

ffi.cdef[[
extern  int guestfs_set_autosync (guestfs_h *g, int autosync);

extern  int guestfs_set_backend (guestfs_h *g, const char *backend);

extern  int guestfs_set_backend_setting (guestfs_h *g, const char *name, const char *val);

extern  int guestfs_set_backend_settings (guestfs_h *g, char *const *settings);

extern  int guestfs_set_cachedir (guestfs_h *g, const char *cachedir);

extern  int guestfs_set_direct (guestfs_h *g, int direct);

extern  int guestfs_set_e2attrs (guestfs_h *g, const char *file, const char *attrs, ...);
extern  int guestfs_set_e2attrs_va (guestfs_h *g, const char *file, const char *attrs, va_list args);

struct guestfs_set_e2attrs_argv {
  uint64_t bitmask;
  int clear;
};

extern  int guestfs_set_e2attrs_argv (guestfs_h *g, const char *file, const char *attrs, const struct guestfs_set_e2attrs_argv *optargs);

extern  int guestfs_set_e2generation (guestfs_h *g, const char *file, int64_t generation);
]]

--[[
extern  int guestfs_set_e2label (guestfs_h *g, const char *device, const char *label)
  GUESTFS_DEPRECATED_BY ("set_label");

extern  int guestfs_set_e2uuid (guestfs_h *g, const char *device, const char *uuid)
  GUESTFS_DEPRECATED_BY ("set_uuid");
--]]

ffi.cdef[[
extern  int guestfs_set_hv (guestfs_h *g, const char *hv);

extern  int guestfs_set_label (guestfs_h *g, const char *mountable, const char *label);

extern  int guestfs_set_libvirt_requested_credential (guestfs_h *g, int index, const char *cred, size_t cred_size);

extern  int guestfs_set_libvirt_supported_credentials (guestfs_h *g, char *const *creds);

extern  int guestfs_set_memsize (guestfs_h *g, int memsize);

extern  int guestfs_set_network (guestfs_h *g, int network);

extern  int guestfs_set_path (guestfs_h *g, const char *searchpath);

extern  int guestfs_set_pgroup (guestfs_h *g, int pgroup);

extern  int guestfs_set_program (guestfs_h *g, const char *program);
]]

--[[
extern  int guestfs_set_qemu (guestfs_h *g, const char *hv)
  GUESTFS_DEPRECATED_BY ("set_hv");
--]]

ffi.cdef[[
extern  int guestfs_set_recovery_proc (guestfs_h *g, int recoveryproc);

extern  int guestfs_set_selinux (guestfs_h *g, int selinux);

extern  int guestfs_set_smp (guestfs_h *g, int smp);

extern  int guestfs_set_tmpdir (guestfs_h *g, const char *tmpdir);

extern  int guestfs_set_trace (guestfs_h *g, int trace);

extern  int guestfs_set_uuid (guestfs_h *g, const char *device, const char *uuid);

extern  int guestfs_set_verbose (guestfs_h *g, int verbose);

extern  int guestfs_setcon (guestfs_h *g, const char *context);

extern  int guestfs_setxattr (guestfs_h *g, const char *xattr, const char *val, int vallen, const char *path);
]]

--[[
extern  int guestfs_sfdisk (guestfs_h *g, const char *device, int cyls, int heads, int sectors, char *const *lines)
  GUESTFS_DEPRECATED_BY ("part_add");

extern  int guestfs_sfdiskM (guestfs_h *g, const char *device, char *const *lines)
  GUESTFS_DEPRECATED_BY ("part_add");

extern  int guestfs_sfdisk_N (guestfs_h *g, const char *device, int partnum, int cyls, int heads, int sectors, const char *line)
  GUESTFS_DEPRECATED_BY ("part_add");
--]]

ffi.cdef[[
extern  char *guestfs_sfdisk_disk_geometry (guestfs_h *g, const char *device);

extern  char *guestfs_sfdisk_kernel_geometry (guestfs_h *g, const char *device);
]]

--[[
extern  char *guestfs_sfdisk_l (guestfs_h *g, const char *device)
  GUESTFS_DEPRECATED_BY ("part_list");
--]]

ffi.cdef[[
extern  char *guestfs_sh (guestfs_h *g, const char *command);

extern  char **guestfs_sh_lines (guestfs_h *g, const char *command);

extern  int guestfs_shutdown (guestfs_h *g);

extern  int guestfs_sleep (guestfs_h *g, int secs);
]]

--[[
extern  struct guestfs_stat *guestfs_stat (guestfs_h *g, const char *path)
  GUESTFS_DEPRECATED_BY ("statns");
--]]

ffi.cdef[[
extern  struct guestfs_statns *guestfs_statns (guestfs_h *g, const char *path);

extern  struct guestfs_statvfs *guestfs_statvfs (guestfs_h *g, const char *path);

extern  char **guestfs_strings (guestfs_h *g, const char *path);

extern  char **guestfs_strings_e (guestfs_h *g, const char *encoding, const char *path);

extern  int guestfs_swapoff_device (guestfs_h *g, const char *device);

extern  int guestfs_swapoff_file (guestfs_h *g, const char *file);

extern  int guestfs_swapoff_label (guestfs_h *g, const char *label);

extern  int guestfs_swapoff_uuid (guestfs_h *g, const char *uuid);

extern  int guestfs_swapon_device (guestfs_h *g, const char *device);

extern  int guestfs_swapon_file (guestfs_h *g, const char *file);

extern  int guestfs_swapon_label (guestfs_h *g, const char *label);

extern  int guestfs_swapon_uuid (guestfs_h *g, const char *uuid);

extern  int guestfs_sync (guestfs_h *g);

extern  int guestfs_syslinux (guestfs_h *g, const char *device, ...);
extern  int guestfs_syslinux_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_syslinux_argv {
  uint64_t bitmask;
  const char *directory;
};

extern  int guestfs_syslinux_argv (guestfs_h *g, const char *device, const struct guestfs_syslinux_argv *optargs);

extern  char **guestfs_tail (guestfs_h *g, const char *path);

extern  char **guestfs_tail_n (guestfs_h *g, int nrlines, const char *path);

extern  int guestfs_tar_in (guestfs_h *g, const char *tarfile, const char *directory);

extern  int guestfs_tar_in_opts (guestfs_h *g, const char *tarfile, const char *directory, ...);
extern  int guestfs_tar_in_opts_va (guestfs_h *g, const char *tarfile, const char *directory, va_list args);

struct guestfs_tar_in_opts_argv {
  uint64_t bitmask;
  const char *compress;
};

extern  int guestfs_tar_in_opts_argv (guestfs_h *g, const char *tarfile, const char *directory, const struct guestfs_tar_in_opts_argv *optargs);

extern  int guestfs_tar_out (guestfs_h *g, const char *directory, const char *tarfile);

extern  int guestfs_tar_out_opts (guestfs_h *g, const char *directory, const char *tarfile, ...);
extern  int guestfs_tar_out_opts_va (guestfs_h *g, const char *directory, const char *tarfile, va_list args);

struct guestfs_tar_out_opts_argv {
  uint64_t bitmask;
  const char *compress;
  int numericowner;
  char *const *excludes;
};

extern  int guestfs_tar_out_opts_argv (guestfs_h *g, const char *directory, const char *tarfile, const struct guestfs_tar_out_opts_argv *optargs);
]]

--[[
extern  int guestfs_tgz_in (guestfs_h *g, const char *tarball, const char *directory)
  GUESTFS_DEPRECATED_BY ("tar_in");

extern  int guestfs_tgz_out (guestfs_h *g, const char *directory, const char *tarball)
  GUESTFS_DEPRECATED_BY ("tar_out");
--]]

ffi.cdef[[
extern  int guestfs_touch (guestfs_h *g, const char *path);

extern  int guestfs_truncate (guestfs_h *g, const char *path);

extern  int guestfs_truncate_size (guestfs_h *g, const char *path, int64_t size);

extern  int guestfs_tune2fs (guestfs_h *g, const char *device, ...);
extern  int guestfs_tune2fs_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_tune2fs_argv {
  uint64_t bitmask;
  int force;
  int maxmountcount;
  int mountcount;
  const char *errorbehavior;
  int64_t group;
  int intervalbetweenchecks;
  int reservedblockspercentage;
  const char *lastmounteddirectory;
  int64_t reservedblockscount;
  int64_t user;
};

extern  int guestfs_tune2fs_argv (guestfs_h *g, const char *device, const struct guestfs_tune2fs_argv *optargs);

extern  char **guestfs_tune2fs_l (guestfs_h *g, const char *device);
]]

--[[
extern  int guestfs_txz_in (guestfs_h *g, const char *tarball, const char *directory)
  GUESTFS_DEPRECATED_BY ("tar_in");

extern  int guestfs_txz_out (guestfs_h *g, const char *directory, const char *tarball)
  GUESTFS_DEPRECATED_BY ("tar_out");
--]]

ffi.cdef[[
extern  int guestfs_umask (guestfs_h *g, int mask);

extern  int guestfs_umount (guestfs_h *g, const char *pathordevice);

extern  int guestfs_umount_opts (guestfs_h *g, const char *pathordevice, ...);
extern  int guestfs_umount_opts_va (guestfs_h *g, const char *pathordevice, va_list args);

struct guestfs_umount_opts_argv {
  uint64_t bitmask;
  int force;
  int lazyunmount;
};

extern  int guestfs_umount_opts_argv (guestfs_h *g, const char *pathordevice, const struct guestfs_umount_opts_argv *optargs);

extern  int guestfs_umount_all (guestfs_h *g);

extern  int guestfs_umount_local (guestfs_h *g, ...);
extern  int guestfs_umount_local_va (guestfs_h *g, va_list args);

struct guestfs_umount_local_argv {
  uint64_t bitmask;
  int retry;
};

extern  int guestfs_umount_local_argv (guestfs_h *g, const struct guestfs_umount_local_argv *optargs);

extern  int guestfs_upload (guestfs_h *g, const char *filename, const char *remotefilename);

extern  int guestfs_upload_offset (guestfs_h *g, const char *filename, const char *remotefilename, int64_t offset);

extern  int guestfs_user_cancel (guestfs_h *g);

extern  int guestfs_utimens (guestfs_h *g, const char *path, int64_t atsecs, int64_t atnsecs, int64_t mtsecs, int64_t mtnsecs);

extern  struct guestfs_utsname *guestfs_utsname (guestfs_h *g);

extern  struct guestfs_version *guestfs_version (guestfs_h *g);

extern  char *guestfs_vfs_label (guestfs_h *g, const char *mountable);

extern  char *guestfs_vfs_type (guestfs_h *g, const char *mountable);

extern  char *guestfs_vfs_uuid (guestfs_h *g, const char *mountable);

extern  int guestfs_vg_activate (guestfs_h *g, int activate, char *const *volgroups);

extern  int guestfs_vg_activate_all (guestfs_h *g, int activate);

extern  int guestfs_vgchange_uuid (guestfs_h *g, const char *vg);

extern  int guestfs_vgchange_uuid_all (guestfs_h *g);

extern  int guestfs_vgcreate (guestfs_h *g, const char *volgroup, char *const *physvols);

extern  char **guestfs_vglvuuids (guestfs_h *g, const char *vgname);

extern  char *guestfs_vgmeta (guestfs_h *g, const char *vgname, size_t *size_r);

extern  char **guestfs_vgpvuuids (guestfs_h *g, const char *vgname);

extern  int guestfs_vgremove (guestfs_h *g, const char *vgname);

extern  int guestfs_vgrename (guestfs_h *g, const char *volgroup, const char *newvolgroup);

extern  char **guestfs_vgs (guestfs_h *g);

extern  struct guestfs_lvm_vg_list *guestfs_vgs_full (guestfs_h *g);

extern  int guestfs_vgscan (guestfs_h *g);

extern  char *guestfs_vguuid (guestfs_h *g, const char *vgname);
]]

--[[
extern  int guestfs_wait_ready (guestfs_h *g)
  GUESTFS_DEPRECATED_BY ("launch");
--]]

ffi.cdef[[
extern  int guestfs_wc_c (guestfs_h *g, const char *path);

extern  int guestfs_wc_l (guestfs_h *g, const char *path);

extern  int guestfs_wc_w (guestfs_h *g, const char *path);

extern  int guestfs_wipefs (guestfs_h *g, const char *device);

extern  int guestfs_write (guestfs_h *g, const char *path, const char *content, size_t content_size);

extern  int guestfs_write_append (guestfs_h *g, const char *path, const char *content, size_t content_size);
]]

--[[
extern  int guestfs_write_file (guestfs_h *g, const char *path, const char *content, int size)
  GUESTFS_DEPRECATED_BY ("write");
--]]

ffi.cdef[[
extern  int guestfs_xfs_admin (guestfs_h *g, const char *device, ...);
extern  int guestfs_xfs_admin_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_xfs_admin_argv {
  uint64_t bitmask;
  int extunwritten;
  int imgfile;
  int v2log;
  int projid32bit;
  int lazycounter;
  const char *label;
  const char *uuid;
};

extern  int guestfs_xfs_admin_argv (guestfs_h *g, const char *device, const struct guestfs_xfs_admin_argv *optargs);

extern  int guestfs_xfs_growfs (guestfs_h *g, const char *path, ...);
extern  int guestfs_xfs_growfs_va (guestfs_h *g, const char *path, va_list args);

struct guestfs_xfs_growfs_argv {
  uint64_t bitmask;
  int datasec;
  int logsec;
  int rtsec;
  int64_t datasize;
  int64_t logsize;
  int64_t rtsize;
  int64_t rtextsize;
  int maxpct;
};

extern  int guestfs_xfs_growfs_argv (guestfs_h *g, const char *path, const struct guestfs_xfs_growfs_argv *optargs);

extern  struct guestfs_xfsinfo *guestfs_xfs_info (guestfs_h *g, const char *pathordevice);

extern  int guestfs_xfs_repair (guestfs_h *g, const char *device, ...);
extern  int guestfs_xfs_repair_va (guestfs_h *g, const char *device, va_list args);

struct guestfs_xfs_repair_argv {
  uint64_t bitmask;
  int forcelogzero;
  int nomodify;
  int noprefetch;
  int forcegeometry;
  int64_t maxmem;
  int64_t ihashsize;
  int64_t bhashsize;
  int64_t agstride;
  const char *logdev;
  const char *rtdev;
};

extern  int guestfs_xfs_repair_argv (guestfs_h *g, const char *device, const struct guestfs_xfs_repair_argv *optargs);
]]

--[[
extern  char **guestfs_zegrep (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");

extern  char **guestfs_zegrepi (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");
--]]

ffi.cdef[[
extern  int guestfs_zero (guestfs_h *g, const char *device);

extern  int guestfs_zero_device (guestfs_h *g, const char *device);

extern  int guestfs_zero_free_space (guestfs_h *g, const char *directory);

extern  int guestfs_zerofree (guestfs_h *g, const char *device);
]]

--[[
extern  char **guestfs_zfgrep (guestfs_h *g, const char *pattern, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");

extern  char **guestfs_zfgrepi (guestfs_h *g, const char *pattern, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");

extern  char *guestfs_zfile (guestfs_h *g, const char *meth, const char *path)
  GUESTFS_DEPRECATED_BY ("file");

extern  char **guestfs_zgrep (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");

extern  char **guestfs_zgrepi (guestfs_h *g, const char *regex, const char *path)
  GUESTFS_DEPRECATED_BY ("grep");
--]]

local Lib_guestfs = ffi.load("guestfs", true)

local exports = {
  Lib_guestfs = Lib_guestfs;


}
setmetatable(exports, {
  __index = function(self, key)
    local value = nil;
    local success = false;


    -- try looking in the library for a function
    success, value = pcall(function() return Lib_guestfs[key] end)
    if success then
      rawset(self, key, value);
      return value;
    end

    -- try looking in the ffi.C namespace, for constants
    -- and enums
    success, value = pcall(function() return ffi.C[key] end)
    if success then
      rawset(self, key, value);
      return value;
    end

    -- Or maybe it's a type
    success, value = pcall(function() return ffi.typeof(key) end)
    if success then
      rawset(self, key, value);
      return value;
    end

    return nil;
  end,

})

return exports
