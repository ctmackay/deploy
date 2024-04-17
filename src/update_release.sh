#!/bin/bash

cp ${GITHUB_WORKSPACE}/deploy/src/template.py ${GITHUB_WORKSPACE}/deploy/src/settings.py
sed -i 's/REPLACE_ME_GIT_TAG/${{ steps.extract_tag_name.outputs.tag_name }}/g' ${GITHUB_WORKSPACE}/deploy/src/settings.py
sed -i 's/REPLACE_ME_GIT_SHA/${{ steps.extract_sha.outputs.sha }}/g' ${GITHUB_WORKSPACE}/deploy/src/settings.py
sed -i 's/REPLACE_ME_CONFIG_FOLDER/logistics-core-early/g' ${GITHUB_WORKSPACE}/deploy/src/settings.py
sed -i 's/REPLACE_ME_SLS_FILENAME/prod_early_adopter.sls/g' ${GITHUB_WORKSPACE}/deploy/src/settings.py
