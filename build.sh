#!/bin/bash

ZIPFILE=ofm_oud_generic_11.1.2.3.0_disk1_1of1.zip


if [ ! -e $ZIPFILE ]; then
  echo "Copy (or hard link) $ZIPFILE into this directory"
  exit -1
fi

docker build -t oracle/oud:11.1.2.3.0 .
