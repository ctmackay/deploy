#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
echo "tag name: $2" # ${{ steps.extract_tag_name.outputs.tag_name }}
echo "git sha: $3"  # ${{ steps.extract_sha.outputs.sha }}
case "$1" in
"early")
    echo "Updating early adopters."
    dest_file="settings_early.py"
    state_file="prod_early_adopter.sls"
    config_folder="logistics-core-early"
    var_name="PROD_EARLY_ADOPTER_SETTINGS"
    ;;
"release")
    echo "Updating release."
    dest_file=settings_release.py
    state_file=prod_early_adopter.sls
    config_folder=logistics-core-early
    var_name=RELEASE_ADOPTER_SETTINGS
    ;;
"prod")
    echo "Updating prod."
    dest_file=settings_prod.py
    state_file=prod_release.sls
    config_folder=logistics-core-prod
    var_name=PROD_ADOPTER_SETTINGS
    ;;
*)
    echo "Invalid argument: $1"
    exit 1
    return
    ;;
esac
cp template.py $dest_file
sed -i "s/REPLACE_ME_GIT_TAG/$2/g" $dest_file
sed -i "s/REPLACE_ME_GIT_SHA/$3/g" $dest_file
sed -i "s/REPLACE_ME_CONFIG_FOLDER/$config_folder/g" $dest_file
sed -i "s/REPLACE_ME_SLS_FILENAME/$state_file/g" $dest_file
sed -i "s/REPLACE_ME_EXPORT_VAR/$var_name/g" $dest_file
echo "done, output of file:"
cat $dest_file
