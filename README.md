[![Build Status](https://travis-ci.org/marceloneppel/rethinkdb.svg?branch=master)](https://travis-ci.org/marceloneppel/rethinkdb)

Dart 2 RethinkDB Driver
=========

A [Dart 2](http://www.dartlang.org) driver for [RethinkDB v2.3](http://www.rethinkdb.com).

This is a fork of [RethinkDB Driver](https://pub.dartlang.org/packages/rethinkdb_driver), that was created to update the driver to [Dart 2](http://www.dartlang.org).


Getting Started:
========

The driver api tries to align with the javascript and python RethinkDB drivers. You can read their documentation [here](http://www.rethinkdb.com/api/).

to include this driver in your own project add the package to your pubspec.yaml file:
```
dependencies:
  rethinkdb_dart: '^2.3.2+3'
```

or to use bleeding edge:
```
dependencies:
  rethinkdb_dart:
    git: git://github.com/marceloneppel/rethinkdb.git
```

or if you are a developer:
  ```
  dependencies:
    rethinkdb_dart:
      path: /path/to/your/cloned/rethinkdb_dart
  ```

  then import the package into your project:
  ```
    import 'package:rethinkdb_dart/rethinkdb_driver.dart';
  ```

  to run tests execute the following command from the project root:

  **warning: tests are run against a live database, but they do attempt to
  clean up after themselves**
  ```
  pub run test  
  ```
