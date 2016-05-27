Dart RethinkDB Driver
=========

A [Dart](http://www.dartlang.org) driver for [RethinkDB v2.2](http://www.rethinkdb.com).


Getting Started:
========

The driver api tries to align with the javascript and python RethinkDB drivers. You can read their documentation [here](http://www.rethinkdb.com/api/).

to include this driver in your own project add the package to your pubspec.yaml file:
```
dependencies:
  rethinkdb_driver: '^2.2.0'
```

or to use bleeding edge:
```
dependencies:
  rethinkdb_driver:
    git: git://github.com/billysometimes/rethinkdb.git
```

or if you are a developer:
  ```
  dependencies:
    rethinkdb_driver:
      path: /path/to/your/cloned/rethinkdb_driver
  ```

  then import the package into your project:
  ```
    import 'package:rethinkdb_driver/rethinkdb_driver.dart';
  ```
