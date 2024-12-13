#! /bin/bash

#source of this manual:https://www.dmosk.ru/instruktions.php?object=build-deb#description-rules



apt update && apt echo yes | apt install dpkg-dev devscripts equivs wget && sleep 1

echo yes | apt-get install libpcre3 libpcre3-dev

echo yes |apt-get install zlib1g zlib1g-dev

mkdir -p $(pwd)/nginxbuild/nginx-1.26.2/debian 

debpath=$(pwd)/nginxbuild/nginx-1.26.2/debian

cat << EOF > $debpath/control
Source:                 nginx
Section:                misc
Priority:               optional
Maintainer:             k.gryadunov
#Build-Depends:   	libpcre3
#                       zlib1g-dev (>= 14)
Standards-Version:      1.26.2
Homepage:               https://nginx.org

Package:                nginx
Architecture:           amd64
Provides:               nginx
Description: NGINX packages.
 The description can be written in several lines.
 Each line have to be 73 chars maximum.
EOF


cat << EOF > $debpath/changelog
nginx (1.26.2) stable; urgency=medium
  * Initial release
 -- Konstantin Gryadunov <k.gryadunov@example.com>  Tue, 03 Aug 2021 17:34:42 +0300
EOF



cat << EOF > $debpath/rules
#!/usr/bin/make -f
export DH_VERBOSE = 1

url='https://nginx.org/download/nginx-1.26.2.tar.gz'
build_dir='nginx'

override_dh_auto_clean:
	if [ ! -f \$(build_dir) ]; then rm -rf \$(build_dir); fi
	mkdir \$(build_dir)
	dh_auto_clean

override_dh_auto_configure:
	wget \$(url) -O \$(build_dir).tar.gz
	tar -xzf \$(build_dir).tar.gz -C \$(build_dir)/ --strip-components=1
	rm -f \$(build_dir).tar.gz
	cd \$(build_dir) && ./configure

override_dh_usrlocal:

%:
	dh \$@ --sourcedirectory=\$(build_dir)/
EOF

sleep 1
cat << EOF > $debpath/compat
12
EOF

cd $debpath


echo yes | mk-build-deps -ri && sleep 1

debuild -us -uc -b

