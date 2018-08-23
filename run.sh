#!/bin/sh

#  run.sh
#  
#
#  Created by silenuszhi on 2018/8/23.
#  
#  This script will download the necessery file from
#  https://github.com/BVLC/caffe/tree/master/models/bvlc_alexnet
#  and
#  https://github.com/ethereon/caffe-tensorflow
#
#  Then produce a tensorflow format weights in output directory.

#  This is for linux only.

#  Todo: fix this
#  prerequisite  : git curl
#  you have to have the proper permission in work folder.

#  Todo: fix anaconda dependent

#  0. clone the caffe-tensorflow repo.
git clone https://github.com/silenuszhi/caffe-tensorflow
cd ./caffe-tensorflow
mkdir output
mkdir download
curl http://dl.caffe.berkeleyvision.org/bvlc_alexnet.caffemodel ./download/bvlc_alexnet.caffemodel
curl https://raw.githubusercontent.com/BVLC/caffe/master/models/bvlc_alexnet/deploy.prototxt ./download/deploy.prototxt

bash ./convert.py def_path ./download/bvlc_alexnet.caffemodel --caffemodel ./download/deploy.prototxt 
