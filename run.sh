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


echo "This is a script help you download the caffe alexnet model and transfer it into tensorflow models"
echo "Written by sileuszhi"
#  0. clone the caffe-tensorflow repo.

git clone https://github.com/silenuszhi/caffe-tensorflow
cd ./caffe-tensorflow
mkdir output
mkdir download
echo "Downloading Caffe AlexNet Model..."
curl http://dl.caffe.berkeleyvision.org/bvlc_alexnet.caffemodel -o ./download/bvlc_alexnet.caffemodel --progress
echo "Downloading Caffe AlexNet Deploy..."
curl https://raw.githubusercontent.com/BVLC/caffe/master/models/bvlc_alexnet/deploy.prototxt -o ./download/deploy.prototxt --progress

# 1. convert the model
~/anaconda2/envs/tf_alexnet/bin/python ./convert.py ./download/deploy.prototxt --caffemodel ./download/bvlc_alexnet.caffemodel --data-output-path ./output/bvlc_alexnet.npy

# 2. Download GroundTruthTable of ILSVRC2012 Validation Set in Caffe Order
# https://stackoverflow.com/questions/42537483/ilsvrc2012-validation-ground-truth-labels-index-not-matching-pretrained-networks
# https://github.com/BVLC/caffe/blob/master/data/ilsvrc12/get_ilsvrc_aux.sh

echo "This forks from https://github.com/BVLC/caffe/blob/master/data/ilsvrc12/get_ilsvrc_aux.sh"

echo "Downloading..."

curl http://dl.caffe.berkeleyvision.org/caffe_ilsvrc12.tar.gz -o ./output/caffe_ilsvrc12.tar.gz

echo "Unzipping..."

mkdir -p ./output/caffe_ilsvrc12 && tar -xf ./output/caffe_ilsvrc12.tar.gz -C  ./output/caffe_ilsvrc12 && rm -f ./output/caffe_ilsvrc12.tar.gz

echo "Done."

