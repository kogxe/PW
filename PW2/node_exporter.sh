#! /bin/bash

url=https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz

workdir=/opt/nodeexporter


mkdir $workdir && sleep 1

cd  $workdir

wget -e use_proxy=yes -e https_proxy=http://proxy-ams.ddos-guard.net:8118 $url && sleep 1

tar xvfz node_exporter-0.18.1.linux-amd64.tar.gz && sleep 1

mv $workdir/node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin

cat <<EOF > $workdir/node_exporter
OPTIONS=""
EOF


cat <<EOF > /usr/lib/systemd/system/node_exporter.service 
[Unit]
Description=Prometheus Node exporter for machine metrics
Documentation=https://github.com/prometheus/node_exporter

[Service]
Restart=always
User=root
EnvironmentFile=/opt/nodeexporter/node_exporter
ExecStart=/usr/local/bin/node_exporter \$OPTIONS
ExecReload=/bin/kill -HUP \$MAINPID
TimeoutStopSec=20s
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter


systemctl status node_exporter

rm $workdir/*.tar.gz
