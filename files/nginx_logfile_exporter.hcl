listen {
  port = 4040
}

namespace "nginx_reverseproxy" {
  source = {
    files = [
      "/var/log/nginx/*prometheus.log"
    ]
  }

  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" rt=$request_time uct=$upstream_connect_time uht=$upstream_header_time urt=$upstream_response_time sn=$servername"
  metrics_override = { prefix = "nginx_logfile" }
  namespace_label = "namespace"
  relabel "servername" { from = "servername" }
}

## Logformat for nginx.conf

#log_format prometheus '$remote_addr - $remote_user [$time_local] '
#                    '"$request" $status $body_bytes_sent '
#                    '"$http_referer" "$http_user_agent" '
#                    'rt=$request_time uct=$upstream_connect_time uht=$upstream_header_time urt=$upstream_response_time sn=$host';

## access_log format for vhost config (replace servername)
#server {
#    (...)
#    access_log   /var/log/nginx/servername.prometheus.log prometheus;
#    (...)
#}