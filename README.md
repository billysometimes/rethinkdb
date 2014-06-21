Dart RethinkDB Driver
=========

A [Dart](http://www.dartlang.org) driver for [RethinkDB v1.13](http://www.rethinkdb.com).

This driver has been rewritten from scratch to conform with the new RethinkDB JSON Protocol

Getting Started:
========

The driver api tries to align with the javascript and python RethinkDB drivers. You can read their documentation [here](http://www.rethinkdb.com/api/).

  clone the repository:
  ```
    git clone https://github.com/billysometimes/rethinkdb.git
  ````
  open the project in Dart Editor and view examples.dart to see the available features and how to use them.

  to include this driver in your own project add:
  ```
    import 'lib/rethinkdb_driver.dart';
  ````
  to your project.
  
  or add the package to your pubspec.yaml file:
  ```
  dependencies:
    rethinkdb_driver: '>=0.4.4'
  ````
  and import the package into your project:
  ```
    import 'package:rethinkdb_driver/rethinkdb_driver.dart'; 
  ````  



