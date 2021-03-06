#!/bin/bash

set -e


# ----------------------------------------------------------------------------
# TPP
# https://www.labkey.org/wiki/home/Documentation/page.view?name=thirdPartyCode
# ----------------------------------------------------------------------------


#  * Perl, version 5.8 or newer.  You may also need to install the
#    IO::Uncompress::Gunzip package.
#
#  * GNUPlot - As of Nov 2014 we recommend version 4.6 or higher, earlier
#    versions may not work.
#
#  * The following additional C/C++ libraries:
#
#      libgd2   www.libgd.org
#      libpng   www.libpng.org
#      zlib     www.gzip.org/zlib
#      libbz2   www.bzip.org
#

yum -y install bzip2 patch perl-XML-Parser perl-CGI perl-IO-Compress

curl --location \
     --output TPP_4.8.0-src.tgz \
     "http://downloads.sourceforge.net/project/sashimi/Trans-Proteomic Pipeline (TPP)/TPP v4.8 (philae) rev 0/TPP_4.8.0-src.tgz?r=https://sourceforge.net/projects/sashimi/&ts=`date +\"%s\"`&use_mirror=iweb"

tar --gzip --extract --verbose --file TPP_4.8.0-src.tgz
cd  TPP-4.8.0/trans_proteomic_pipeline/src

cat > Makefile.config.incl << EOT
TPP_ROOT = /usr/local/tpp/
XML_ONLY = 1
EOT
make all install

cat > /etc/profile.d/tpp.sh << EOT
export PATH=/usr/local/tpp/bin:\$PATH
EOT

cd ../../..
rm --recursive --force TPP-4.8.0 TPP_4.8.0-src.tgz
