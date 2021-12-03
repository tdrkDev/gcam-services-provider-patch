#!/sbin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/90-gcam.sh
# addon.d script to back up GCam-Services-Provider
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GCSP/GCSP.apk
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac