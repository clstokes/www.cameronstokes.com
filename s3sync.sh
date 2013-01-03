#!/bin/sh

s3cmd --config=/Users/clstokes/.s3cfg-cameronstokes.com --no-preserve sync public/* s3://www.cameronstokes.com/
