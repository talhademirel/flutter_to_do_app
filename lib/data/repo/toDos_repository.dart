import 'package:flutter_to_do_app/data/entity/toDos.dart';
import 'package:flutter_to_do_app/data/sqlite/database.dart';

class ToDosRepository {
  Future<void> save(String name) async {
    var db = await DatabaseClass.accessDatabase();
    var data = <String,dynamic>{};
    data["name"] = name;
    await db.insert("toDos", data);
  }

  Future<void> update(int id,String name) async {
    var db = await DatabaseClass.accessDatabase();
    var data = <String,dynamic>{};
    data["name"] = name;
    data["id"] = id;
    await db.update("toDos", data,where: "id=?",whereArgs: [id]);
  }

  Future<List<ToDos>> loadAllData() async {
    var db = await DatabaseClass.accessDatabase();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM toDos");
    return List.generate(maps.length, (i) {
      var row = maps[i];
      return ToDos(id: row["id"],name: row["name"]);
    });
  }

  Future<List<ToDos>> search(String searchWord) async {
    var db = await DatabaseClass.accessDatabase();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM toDos WHERE name like '%$searchWord%'");

    return List.generate(maps.length, (i){
      var row = maps[i];
      return ToDos(id: row["id"],name: row["name"]);
    });
  }

  Future<void> delete(int id) async {
    var db = await DatabaseClass.accessDatabase();
    await db.delete("toDos",where: "id=?",whereArgs: [id]);
  }

}