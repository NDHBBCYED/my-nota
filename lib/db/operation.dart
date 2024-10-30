
import 'package:my_notas/models/materia.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operation{
  static Future<Database> _openDB() async{
    return openDatabase(
      join(
        await getDatabasesPath(), 'mynotes.db'), 
        onCreate: (db,version) 
        {
          
          return db.execute("CREATE TABLE asignaturas (id INTEGER PRIMARY KEY, materia TEXT, docente TEXT, creditos TEXT, nota1 TEXT, nota2 TEXT, nota3 TEXT)");
        }, version: 1
    );
  }

  static Future<void> insert(Materia materia) async{

    final Database database = await _openDB();

    return database.insert("asignaturas", materia.toMap());

  }

  static Future<List<Materia>> materias() async {
    final Database database = await _openDB();

    final List<Map<String, dynamic>> materiasMap = await database.query("asignaturas");

    return List.generate(materiasMap.length, (i) => Materia(id: materiasMap[i]['id'],
     materia: materiasMap[i]['materia'],
     docente: materiasMap[i]['docente'],
     creditos:  materiasMap[i]['creditos'].toString(),
     nota1: materiasMap[i]['nota1'],
     nota2: materiasMap[i]['nota2'],
     nota3: materiasMap[i]['nota3']
     ));

  }

  static Future<Materia> consult(int cid) async{
    final Database database = await _openDB();

    var consultid = await database.query("asignaturas", where: "id = ?", whereArgs: [cid]);

    return consultid.isNotEmpty ? Materia.fromMap(consultid.first) : null;

  }

  static Future<void> update(Materia materia) async{
    final Database database = await _openDB();

    return database.update("asignaturas", materia.toMap(), where: "id = ?", whereArgs: [materia.id]);

  }

  static Future<void> delete(int id) async{
    final Database database = await _openDB();

    return database.delete("asignaturas", where: "id = ?", whereArgs: [id]);

  }

  static Future<void> deleteAll() async{
    final Database database = await _openDB();

    return database.delete("asignaturas");

  }

}