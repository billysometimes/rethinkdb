import 'package:test/test.dart';
import '../lib/rethinkdb_driver.dart';

main() {
  Rethinkdb r = new Rethinkdb();
  String tableName = null;
  String testDbName = null;
  bool shouldDropTable = false;
  var connection;

  setUp(() async {
    connection = await r.connect();

    if (testDbName == null) {
      String useDb = await r.uuid().run(connection);
      testDbName = 'unit_test_db' + useDb.replaceAll("-", "");
      await r.dbCreate(testDbName).run(connection);
    }
    connection.use(testDbName);

    if (tableName == null) {
      String tblName = await r.uuid().run(connection);
      tableName = "test_table_" + tblName.replaceAll("-", "");
      await r.tableCreate(tableName).run(connection);
    }
  });

  tearDown(() {
    if (shouldDropTable) {
      shouldDropTable = false;
      return r.tableDrop(tableName).run(connection).then((_) {
        connection.close();
      });
    } else {
      connection.close();
    }
  });

  group("insert command -> ", () {
    test("should insert a single record", () {
      r
          .table(tableName)
          .insert({'id':1, 'name':'Jane Doe'})
          .run(connection)
          .then(expectAsync((Map createdRecord) {
            expect(createdRecord['deleted'], equals(0));
            expect(createdRecord['errors'], equals(0));
            expect(createdRecord['inserted'], equals(1));
            expect(createdRecord['replaced'], equals(0));
            expect(createdRecord['skipped'], equals(0));
            expect(createdRecord['unchanged'], equals(0));
          }));
    });
    test("should error if record exists", () async{
      r
          .table(tableName)
          .insert({'id':1, 'name':'Jane Doe'})
          .run(connection)
          .then(expectAsync((Map createdRecord) {
            expect(createdRecord['first_error'].startsWith('Duplicate primary key `id`'), equals(true));
            expect(createdRecord['deleted'], equals(0));
            expect(createdRecord['errors'], equals(1));
            expect(createdRecord['inserted'], equals(0));
            expect(createdRecord['replaced'], equals(0));
            expect(createdRecord['skipped'], equals(0));
            expect(createdRecord['unchanged'], equals(0));
          }));
    });
    test("should insert multiple records", () {
      r
          .table(tableName)
          .insert([
            {'name':'Jane Doe'},
            {'id':2,
             'name':'John Bonham',
             'kit': {
               'cymbals':['hi-hat', 'crash', 'splash'],
               'drums':['kick','tom']
             }
           }])
          .run(connection)
          .then(expectAsync((Map createdRecord) {
            expect(createdRecord['deleted'], equals(0));
            expect(createdRecord['errors'], equals(0));
            expect(createdRecord['generated_keys'].length, equals(1));
            expect(createdRecord['inserted'], equals(2));
            expect(createdRecord['replaced'], equals(0));
            expect(createdRecord['skipped'], equals(0));
            expect(createdRecord['unchanged'], equals(0));
          }));
    });
    test("should change durability", () {
      r
          .table(tableName)
          .insert({'name':'a'},{'durability':'hard'})
          .run(connection)
          .then(expectAsync((Map createdRecord) {
            expect(createdRecord['deleted'], equals(0));
            expect(createdRecord['errors'], equals(0));
            expect(createdRecord['generated_keys'].length, equals(1));
            expect(createdRecord['inserted'], equals(1));
            expect(createdRecord['replaced'], equals(0));
            expect(createdRecord['skipped'], equals(0));
            expect(createdRecord['unchanged'], equals(0));
          }));
    });
    test("should allow return_changes", () {
      r
          .table(tableName)
          .insert({'name':'a'},{'return_changes':true})
          .run(connection)
          .then(expectAsync((Map createdRecord) {
            expect(createdRecord['changes'][0]['new_val']['name'], equals('a'));
            expect(createdRecord['changes'][0]['old_val'], equals(null));
            expect(createdRecord['deleted'], equals(0));
            expect(createdRecord['errors'], equals(0));
            expect(createdRecord['generated_keys'].length, equals(1));
            expect(createdRecord['inserted'], equals(1));
            expect(createdRecord['replaced'], equals(0));
            expect(createdRecord['skipped'], equals(0));
            expect(createdRecord['unchanged'], equals(0));
          }));
    });
    test("should allow handle conflicts", () async{
      var update = await r.table(tableName)
          .insert({'id':1, 'birthYear':new DateTime(1984)},
              {'conflict':'update','return_changes':true})
          .run(connection);

      expect(update['changes'][0]['new_val'].containsKey('birthYear'), equals(true));
      expect(update['changes'][0]['new_val'].containsKey('name'), equals(true));
      expect(update['changes'][0]['old_val'].containsKey('birthYear'), equals(false));
      expect(update['changes'][0]['old_val'].containsKey('name'), equals(true));
      expect(update['replaced'], equals(1));

      var replace = await r.table(tableName)
          .insert({'id':1, 'name':'Jane Doe'},
            {'conflict':'replace','return_changes':true})
          .run(connection);

      expect(replace['changes'][0]['new_val'].containsKey('birthYear'), equals(false));
      expect(replace['changes'][0]['new_val'].containsKey('name'), equals(true));
      expect(replace['changes'][0]['old_val'].containsKey('birthYear'), equals(true));
      expect(replace['changes'][0]['old_val'].containsKey('name'), equals(true));
      expect(replace['replaced'], equals(1));

      var custom = await r.table(tableName)
          .insert({'id':1, 'name':'Jane Doe'},
            {'conflict':(_id, _old, _new) => {'id':_old('id'), 'err':'bad record'},'return_changes':true})
          .run(connection);
      expect(custom['changes'][0]['new_val'].containsKey('err'), equals(true));
      expect(replace['replaced'], equals(1));
    });
  });

  group("update command -> ", (){
    test("should update all records in a table", (){
      r.table(tableName)
       .update({'lastModified': new DateTime.now()})
       .run(connection)
       .then(expectAsync((update){
         expect(update['replaced'], equals(5));
       }));
    });

    test("should update all records in a selection", (){
      r.table(tableName)
       .getAll(1,2)
       .update({'newField': 33})
       .run(connection).then(expectAsync((updatedSelection){
         expect(updatedSelection['replaced'], equals(2));
      }));
    });

    test("should update a single record", (){
      r.table(tableName)
       .get(1)
       .update({'newField2': 44})
       .run(connection).then(expectAsync((updatedSelection){
         expect(updatedSelection['replaced'], equals(1));
      }));
    });

    test("should update with durability option", (){
      r.table(tableName)
       .get(1)
       .update({'newField2': 22},{'durability': 'soft'})
       .run(connection).then(expectAsync((updatedSelection){
         expect(updatedSelection['replaced'], equals(1));
      }));
    });

    test("should update with return_changes option", (){
      r.table(tableName)
       .get(1)
       .update({'newField2': 11},{'return_changes': 'always'})
       .run(connection).then(expectAsync((Map updatedSelection){
         expect(updatedSelection.containsKey('changes'), equals(true));
      }));
    });

    test("should update with non_atomic option", (){
      r.table(tableName)
       .get(1)
       .update({'newField2': 00},{'non_atomic': true})
       .run(connection).then(expectAsync((Map updatedSelection){
         expect(updatedSelection['replaced'], equals(1));
      }));
    });

    test("should update with r.literal", (){
      r.table(tableName)
        .get(2)
        .update({'kit':r.literal({'bells':'cow'})},{'return_changes':true})
        .run(connection)
        .then(expectAsync((updated){
          Map old_val = updated['changes'][0]['old_val'];
          Map new_val = updated['changes'][0]['new_val'];

          expect(old_val['kit'].containsKey('drums'), equals(true));
          expect(new_val['kit'].containsKey('bells'), equals(true));
          expect(new_val['kit'].containsKey('drums'), equals(false));
        }));
    });
  });

  group("replace command -> ", (){
    test("should replace a single selection", (){
      r.table(tableName).get(1).replace({'id':1}).run(connection)
       .then(expectAsync((replaced){
         expect(replaced['replaced'], equals(1));
       }));
    });

    test("should replace a selection", (){
      r.table(tableName).getAll(1,2).replace((item){
        return item.pluck('kit', 'id');
      }, {'return_changes':true}).run(connection)
       .then(expectAsync((Map replaced){
         expect(replaced['replaced'], equals(1));

         Map newVal = replaced['changes'][0]['new_val'];
         Map oldVal = replaced['changes'][0]['old_val'];

         expect(newVal.containsKey('lastModified'), equals(false));
         expect(oldVal.containsKey('lastModified'), equals(true));
       }));
    });

    test("should populate errors", (){
      r.table(tableName).get(1).replace({}).run(connection)
      .then(expectAsync((replaceError){
        expect(replaceError['errors'], equals(1));
        expect(replaceError['first_error'], equals('Inserted object must have primary key `id`:\n{}'));
      }));
    });
  });

  group("delete command -> ", (){
    test("should delete a single selection", (){
      r.table(tableName).get(1).delete({'return_changes':true}).run(connection)
       .then(expectAsync((deleted){

         Map newVal = deleted['changes'][0]['new_val'];
         Map oldVal = deleted['changes'][0]['old_val'];

         expect(deleted['deleted'], equals(1));
         expect(newVal, equals(null));
         expect(oldVal['id'], equals(1));
       }));
    });

    test("should delete a selection", (){
      r.table(tableName).limit(2)
       .delete({'return_changes':true})
      .run(connection)
       .then(expectAsync((deleted){
         expect(deleted['changes'].length, equals(2));

         Map newVal = deleted['changes'][0]['new_val'];
         Map oldVal = deleted['changes'][0]['old_val'];

         expect(deleted['deleted'], equals(2));
         expect(newVal, equals(null));
         expect(oldVal.containsKey('name'), equals(true));

         newVal = deleted['changes'][1]['new_val'];
        oldVal = deleted['changes'][1]['old_val'];

        expect(newVal, equals(null));
        expect(oldVal.containsKey('id'), equals(true));
       }));
    });

    test("should delete all records on a table", (){
      r.table(tableName)
       .delete()
       .run(connection)
       .then((deleted){
         return r.table(tableName).run(connection);
       })
       .then(expectAsync((results){
         results.toList().then((List resList){
           expect(resList.isEmpty, equals(true));
         });
       }));
    });
  });

  group("sync command -> ", (){
    test("should sync",(){
        r.table(tableName)
         .sync()
         .run(connection)
         .then(expectAsync((syncComplete){
           expect(syncComplete.containsKey('synced'), equals(true));
           expect(syncComplete['synced'], equals(1));
         }));
    });
  });

  test("remove the test database", () {
    r.dbDrop(testDbName).run(connection).then(expectAsync((Map response) {
      expect(response.containsKey('config_changes'), equals(true));
      expect(response['dbs_dropped'], equals(1));
    }));
  });
}
