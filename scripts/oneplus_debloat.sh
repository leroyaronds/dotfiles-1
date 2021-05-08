#!/bin/bash
#
adb shell <<EOF
pm disable-user --user 0 com.google.android.projection.gearhead # Android Car
pm disable-user --user 0 com.android.bips # Android Printer
pm disable-user --user 0 com.android.printspooler # Android Printer
pm disable-user --user 0 com.android.stk # Android SIM Toolkit
pm disable-user --user 0 com.android.providers.partnerbookmarks
pm disable-user --user 0 com.android.egg # Easter egg
pm disable-user --user 0 com.android.dreams.basic
pm disable-user --user 0 com.android.hotwordenrollment.xgoogle
pm disable-user --user 0 com.android.hotwordenrollment.okgoogle
pm disable-user --user 0 com.android.wallpaperbackup

pm disable-user --user 0 com.oneplus.gamespace # OnePlus Gamespace
pm disable-user --user 0 com.oneplus.filemanager # OnePlus File manager
pm disable-user --user 0 cn.oneplus.photos # OnePlus Photos
pm disable-user --user 0 com.oneplus.account # OnePlus Account
pm disable-user --user 0 com.oneplus.brickmode # OnePlus Zen mode
pm disable-user --user 0 com.oneplus.gallery # OnePlus Gallery
pm disable-user --user 0 com.oneplus.screenrecord # OnePlus Screen record
pm uninstall --user 0 com.oneplus.iconpack.onepluso2 # OnePlus Oxygen Icon Pack 
pm uninstall --user 0 com.oneplus.iconpack.oneplush2 # OnePlus Hydrogen Icon Pack
pm uninstall --user 0 com.oneplus.backuprestore # OnePlus Switch
pm uninstall --user 0 net.oneplus.widget # OnePlus Widget
pm disable-user --user 0 net.oneplus.odm
pm disable-user --user 0 net.oneplus.odm.provider
pm disable-user --user 0 com.tencent.soter.soterserver
pm disable-user --user 0 com.oneplus.wallpaper
pm disable-user --user 0 net.oneplus.push
pm disable-user --user 0 com.oneplus.diagnosemanager
pm uninstall --user 0 com.oneplus.note
pm uninstall --user 0 com.oneplus.twspods
pm uninstall --user 0 net.oneplus.forums
pm disable-user --user 0 com.oneplus.contacts
pm disable-user --user 0 com.oneplus.opbugreport
pm disable-user --user 0 com.oneplus.opbugreportlite
pm disable-user --user 0 net.oneplus.provider.appcategoryprovider

pm disable-user --user 0 com.android.chrome # Google Chrome
pm disable-user --user 0 com.google.android.youtube # Google Youtube
pm disable-user --user 0 com.google.android.apps.youtube.music # Google Youtube music
pm disable-user --user 0 com.google.android.calendar # Google Calendar
pm disable-user --user 0 com.google.android.gm # Google Gmail
pm disable-user --user 0 com.google.android.videos # Google Videos
pm disable-user --user 0 com.google.android.music # Google Music
pm disable-user --user 0 com.google.android.apps.messaging # Google Messenger
pm disable-user --user 0 com.google.android.apps.docs # Google Drive
pm disable-user --user 0 com.google.android.apps.maps # Google Maps
pm disable-user --user 0 com.google.android.apps.photos # Google Photos
pm disable-user --user 0 com.google.android.apps.googleassistant # Google Assistant
pm disable-user --user 0 com.google.android.apps.wellbeing # Google Wellbeing
pm uninstall --user 0 com.google.android.apps.tachyon # Google Duo
pm uninstall --user 0 com.google.android.syncadapters.contacts # Google Contacts Syns
pm disable-user --user 0 com.google.android.feedback
pm disable-user --user 0 com.google.android.googlequicksearchbox
pm disable-user --user 0 com.google.android.marvin.talkback
pm disable-user --user 0 com.google.android.tts
pm disable-user --user 0 com.google.ar.core
pm disable-user --user 0 com.google.android.printservice.recommendation

pm uninstall --user 0 com.netflix.mediaclient # Netflix media player
pm uninstall --user 0 com.netflix.partner.activation # Netflix partner activation
EOF