#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource "CSNotificationView/CSNotificationView/CSNotificationView.xcassets/CSNotificationView_checkmarkIcon.imageset/CSNotificationView_checkmarkIcon.png"
install_resource "CSNotificationView/CSNotificationView/CSNotificationView.xcassets/CSNotificationView_checkmarkIcon.imageset/CSNotificationView_checkmarkIcon@2x.png"
install_resource "CSNotificationView/CSNotificationView/CSNotificationView.xcassets/CSNotificationView_exclamationMarkIcon.imageset/CSNotificationView_exclamationMarkIcon.png"
install_resource "CSNotificationView/CSNotificationView/CSNotificationView.xcassets/CSNotificationView_exclamationMarkIcon.imageset/CSNotificationView_exclamationMarkIcon@2x.png"
install_resource "CocoaSoundCloudUI/SoundCloud.bundle"
install_resource "FlatUIKit/Resources/Lato-Black.ttf"
install_resource "FlatUIKit/Resources/Lato-BlackItalic.ttf"
install_resource "FlatUIKit/Resources/Lato-Bold.ttf"
install_resource "FlatUIKit/Resources/Lato-BoldItalic.ttf"
install_resource "FlatUIKit/Resources/Lato-Hairline.ttf"
install_resource "FlatUIKit/Resources/Lato-HairlineItalic.ttf"
install_resource "FlatUIKit/Resources/Lato-Italic.ttf"
install_resource "FlatUIKit/Resources/Lato-Light.ttf"
install_resource "FlatUIKit/Resources/Lato-LightItalic.ttf"
install_resource "FlatUIKit/Resources/Lato-Regular.ttf"
install_resource "TMTumblrSDK/TMTumblrSDK/Activity/UIActivityTumblr.png"
install_resource "TMTumblrSDK/TMTumblrSDK/Activity/UIActivityTumblr@2x.png"
install_resource "TMTumblrSDK/TMTumblrSDK/Activity/UIActivityTumblr@2x~ipad.png"
install_resource "TMTumblrSDK/TMTumblrSDK/Activity/UIActivityTumblr~ipad.png"

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"
