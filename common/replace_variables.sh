
HEX_TELEGRAM_DOMAIN=$(echo -n "$TELEGRAM_FAKE_TLS_DOMAIN"| xxd -ps | tr -d '\n')
CLOUD_PROVIDER=${CLOUD_PROVIDER:-$MAIN_DOMAIN}
GUID_SECRET="${USER_SECRET:0:8}-${USER_SECRET:8:4}-${USER_SECRET:12:4}-${USER_SECRET:16:4}-${USER_SECRET:20:12}"

# TEMP_LINK_VALID_TIME=$(date '+%Y-%m-%dT(%H|')$(printf "%02d)" $(($(date '10#+%H') +1)))
IP=$(curl -Lso- https://api.ipify.org);

for template_file in $(find . -name "*.template"); do
    out_file=${template_file/.template/}
    cp $template_file $out_file
    if [[ "$ENABLE_MONITORING" == "false" ]];then
        sed -i "s|access_log /opt/GITHUB_REPOSITORY/log/nginx.log proxy;|access_log off;|g"
    fi
    sed -i "s|TEMP_LINK_VALID_TIME|$TEMP_LINK_VALID_TIME|g" $out_file 
    sed -i "s|defaultusersecret|$USER_SECRET|g" $out_file 
    sed -i "s|defaultuserguidsecret|$GUID_SECRET|g" $out_file 
    sed -i "s|defaultcloudprovider|$CLOUD_PROVIDER|g" $out_file 
    sed -i "s|defaultserverip|$IP|g" $out_file 
    sed -i "s|defaultserverhost|$MAIN_DOMAIN|g" $out_file 
    sed -i "s|telegramadtag|$TELEGRAM_AD_TAG|g" $out_file 
    sed -i "s|telegramtlsdomain|$TELEGRAM_FAKE_TLS_DOMAIN|g" $out_file 
    sed -i "s|sstlsdomain|$SS_FAKE_TLS_DOMAIN|g" $out_file 
    sed -i "s|hextelegramdomain|$HEX_TELEGRAM_DOMAIN|g" $out_file 
    sed -i "s|CDN_NAME|$CDN_NAME|g" $out_file 
    sed -i "s|GITHUB_REPOSITORY|$GITHUB_REPOSITORY|g" $out_file 
    sed -i "s|GITHUB_USER|$GITHUB_USER|g" $out_file 
    sed -i "s|GITHUB_BRANCH_OR_TAG|$GITHUB_BRANCH_OR_TAG|g" $out_file 
    
    

done
