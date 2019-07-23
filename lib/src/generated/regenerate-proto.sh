#!/bin/sh 

DIR="$(dirname $BASH_SOURCE)"

# Do a quick validation that we have the protoc plugin in PATH.
PROTOC_PLUGIN=$(which protoc-gen-dart)
if [ ! -f "$PROTOC_PLUGIN" ]; then
  echo -en "Could not find Dart plugin for protoc! \nMake sure \$PATH includes "
  echo     "the protoc compiler plugin for Dart (named \"protoc-gen-dart\")!"
  exit 1
fi

function run {
  echo "Running $@"
  $@

  EXITCODE=$?
  if [ $EXITCODE -ne 0 ]; then
    echo "  -> Command failed with exitcode $EXITCODE. Aborting ..."
    exit $EXITCODE
  fi
}


# Retrieve updated protobuf for rethinkdb's wire protocol.
# See https://www.rethinkdb.com/docs/writing-drivers/ for more detail.
run wget -O $DIR/ql2.proto https://raw.githubusercontent.com/rethinkdb/rethinkdb/next/src/rdb_protocol/ql2.proto

# Re-generate protobuf files. 
# See https://developers.google.com/protocol-buffers/docs/reference/dart-generated
run protoc --proto_path=$DIR --dart_out=$DIR $DIR/ql2.proto

run dartfmt --fix -w $DIR