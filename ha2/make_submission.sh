#!/bin/bash

files="dump1.txt file1.txt dump2.txt crack2.* readme2.txt file2.txt cookies3.txt readme3.txt readme4.txt comment5.html cookies5.txt readme5.txt crack6.* readme6.txt"

mkdir -p ha2
mv $files ha2/
tar czvf ha2.tar.gz ha2/
mv ha2/* .
rm -rf ha2
