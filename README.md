Dart RethinkDB Driver
=========

A [Dart](http://www.dartlang.org) driver for [RethinkDB v2.0.1](http://www.rethinkdb.com).


Getting Started:
========

The driver api tries to align with the javascript and python RethinkDB drivers. You can read their documentation [here](http://www.rethinkdb.com/api/).

  clone the repository:
  ```
    git clone https://github.com/billysometimes/rethinkdb.git
  ````
  open the project in Dart Editor and view examples.dart to see the available features and how to use them.

  to include this driver in your own project add the package to your pubspec.yaml file:
  ```
  dependencies:
    rethinkdb_driver: '>=2.0.0'
  ````
  or if you are a developer:
  ```
  dependencies:
    rethinkdb_driver:
      path: /path/to/your/cloned/rethinkdb_driver
  ```
  or for bleading edge:
  ```
  dependencies:
    rethinkdb_driver: 
      git: git://github.com/billysometimes/rethinkdb.git
  ```
  
  
  then import the package into your project:
  ```
    import 'package:rethinkdb_driver/rethinkdb_driver.dart'; 
  ````  

