echo Starting linux application: {{app_name}}_{{app_id}}
cd /home/{{ansible_ssh_user}}/{{nas_env}}
PIDS=$(ps -wwfe | grep dk.netarkivet.harvester.heritrix3.HarvestControllerApplication | grep -v grep | grep /home/netarkdv/SystemTest/conf/settings_{{app_name}}_{{app_id}}.xml | awk "{print \$2}")
if [ -n "$PIDS" ] ; then
    echo Application already running.
else
    export CLASSPATH=/home/{{ansible_ssh_user}}/{{nas_env}}/lib/netarchivesuite-monitor-core.jar:/home/{ansible_ssh_user}}/{{nas_env}}/lib/netarchivesuite-heritrix3-controller.jar:$CLASSPATH;
    java -Xmx1024m  -Ddk.netarkivet.settings.file=/home/{ansible_ssh_user}}/{{nas_env}}/conf/settings_{{app_name}}_{{app_id}}.xml -Dlogback.configurationFile=/home/{{ansible_ssh_user}}/{{nas_env}}/conf/logback_{{app_name}}_{{app_id}}.xml dk.netarkivet.harvester.heritrix3.{{app_name}} < /dev/null > start_{{app_name}}_{{app_id}}.log 2>&1 &
fi