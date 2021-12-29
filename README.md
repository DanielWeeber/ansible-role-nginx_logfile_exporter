[![CI](https://github.com/DanielWeeber/ansible-role-nginx_logfile_exporter/actions/workflows/release.yml/badge.svg?branch=master)](https://github.com/DanielWeeber/ansible-role-nginx_logfile_exporter/actions/workflows/release.yml)

# Ansible Role: Apache exporter

This role installs Prometheus' [Nginx logfile exporter](https://github.com/martin-helmich/prometheus-nginxlog-exporter) on Nginx hosts.

## Requirements

Add this to nginx.conf

    log_format prometheus '$remote_addr - $remote_user [$time_local] '
                        '"$request" $status $body_bytes_sent '
                        '"$http_referer" "$http_user_agent" '
                        'rt=$request_time uct=$upstream_connect_time uht=$upstream_header_time urt=$upstream_response_time sn=$host';

Add this to the server block of your vhost. You can use `access_log` multiple times.

    access_log   /var/log/nginx/servername.prometheus.log prometheus;

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    nginx_logfile_exporter_version: '1.9.2'

The version of Nginx Logfile exporter to install. Available releases can be found on the [tags](https://github.com/martin-helmich/prometheus-nginxlog-exporter/tags) listing in the Nginx Logfile exporter repository. Drop the `v` off the tag.

If you change the version, the `nginx_logfile_exporter` binary will be replaced with the updated version, and the service will be restarted.

    nginx_logfile_exporter_arch: 'amd64'
    nginx_logfile_exporter_download_url: https://github.com/Lusitaniae/nginx_logfile_exporter/releases/download/v{{ nginx_logfile_exporter_version }}/nginx_logfile_exporter-{{ nginx_logfile_exporter_version }}-{{ nginx_logfile_exporter_arch }}.tar.gz

The path where the `nginx_logfile_exporter` binary will be downloaded and installed from.

    nginx_logfile_exporter_options: ''

Any additional options to pass to `nginx_logfile_exporter` when it starts.

    nginx_logfile_exporter_state: started
    nginx_logfile_exporter_enabled: true

Controls for the `nginx_logfile_exporter` service.

## Dependencies

None.

## Example Playbook

    - hosts: all
      roles:
        - role: ansible-role-nginx_logfile_exporter

## License

MIT / BSD

## Author Information

This role was created in 2021 by [Daniel Weeber](https://github.com/DanielWeeber). Heavily inspired and forked from [Jeff Geerling](https://www.jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).
