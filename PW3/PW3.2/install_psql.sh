#! /bin/bash

apt update && sleep 1

echo yes |apt install postgresql postgresql-contrib

systemctl start postgresql.service


systemctl status postgresql.service

