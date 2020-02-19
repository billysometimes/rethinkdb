[![Build Status](https://travis-ci.org/marceloneppel/rethinkdb.svg?branch=master)](https://travis-ci.org/marceloneppel/rethinkdb)

Dart 2 and Flutter RethinkDB Driver
=========

A [Dart 2](http://www.dartlang.org) and [Flutter](https://flutter.io) driver for [RethinkDB v2.3](http://www.rethinkdb.com).

This is a fork of [RethinkDB Driver](https://pub.dartlang.org/packages/rethinkdb_driver), that was created to update the driver to Dart 2 and Flutter.


Getting Started:
========

The driver api tries to align with the javascript and python RethinkDB drivers. You can read their documentation [here](http://www.rethinkdb.com/api/).

To include this driver in your own project add the package to your pubspec.yaml file:
```yaml
dependencies:
  rethinkdb_dart: '^2.3.2+6'
```

Or to use bleeding edge:
```yaml
dependencies:
  rethinkdb_dart:
    git: git://github.com/marceloneppel/rethinkdb.git
```

Or if you are a developer:
  ```yaml
  dependencies:
    rethinkdb_dart:
      path: /path/to/your/cloned/rethinkdb_dart
  ```

Then import the package into your project:
```dart
import 'package:rethinkdb_dart/rethinkdb_dart.dart';
```
Connect to the database:
```dart
var connection = await r.connect(db: "test", host: "localhost", port: 28015);
```
Create a table:
```dart
await r.db('test').tableCreate('tv_shows').run(connection);
```
Insert some data:
```dart
await r.table('tv_shows').insert([
      {'name': 'Star Trek TNG', 'episodes': 178},
      {'name': 'Battlestar Galactica', 'episodes': 75}
    ]).run(connection);
```
And work with the data:
```dart
var count = await r.table('tv_shows').count();
print("count: $count");
```

To update protobuf execute the following command from the project root:

```sh
bash lib/src/generated/regenerate-proto.sh
```

To run tests execute the following command from the project root:

**warning: tests are run against a live database, but they do attempt to
clean up after themselves**
```sh
pub run test  
```
