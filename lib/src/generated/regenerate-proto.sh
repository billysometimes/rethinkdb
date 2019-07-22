#!/bin/sh -x

# chdir to script directory. 
# See http://mywiki.wooledge.org/BashFAQ/028 for more detail.
cd "${BASH_SOURCE%/*}/" || exit

# Retrieve updated protobuf for rethinkdb's wire protocol.
# See https://www.rethinkdb.com/docs/writing-drivers/ for more detail.
wget -O ql2.proto https://raw.githubusercontent.com/rethinkdb/rethinkdb/next/src/rdb_protocol/ql2.proto

# Re-generate protobuf files. 
# See https://developers.google.com/protocol-buffers/docs/reference/dart-generated
protoc --proto_path=. --dart_out=. ql2.proto