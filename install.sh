#
# GCam-Services-Provider patch
# Patch by tdrkDev
#

ui_print "GCSP patch v1.0"
ui_print "---------------"

clean_and_exit() {
    ui_print "Cleaning and unmounting system..."
    umount $SYSDIR
    rm -rf $temp_dir
    exit $1
}

check_system() {
    if [ "$SYSDIR" = "/system_root" ]; then
        [ ! -f $SYSDIR/system/build.prop ] && echo false && return
    else
        [ ! -f $SYSDIR/build.prop ] && echo false && return
    fi
}

mount_system() {
    ui_print "Mounting system..."
    if [ ! -d /system_root ]; then
        mount -o rw /system
        SYSDIR="/system"
    else
        mount -o rw /system_root
        SYSDIR="/system_root"
    fi

    if [ ! -z "$(check_system)" ]; then
        ui_print "Failed to mount system!"
        exit 1
    fi
}

unpack_files() {
    ui_print "Unpacking GCSP..."

    unzip -o $zip 90-gcam.sh -d $temp_dir
    unzip -o $zip app-photos-debug.apk -d $temp_dir
}

install_files() {
    ui_print "Installing..."

    if [ "$SYSDIR" = "/system_root" ]; then
        cp -f $temp_dir/90-gcam.sh $SYSDIR/system/addon.d/90-gcam.sh
        mkdir $SYSDIR/system/app/GCSP
        cp -f $temp_dir/app-photos-debug.apk $SYSDIR/system/app/GCSP/GCSP.apk
    else
        cp -f $temp_dir/90-gcam.sh $SYSDIR/addon.d/90-gcam.sh
        mkdir $SYSDIR/app/GCSP
        cp -f $temp_dir/app-photos-debug.apk $SYSDIR/app/GCSP/GCSP.apk
    fi
}

mount_system
unpack_files
install_files

ui_print "Done!"

clean_and_exit 0
