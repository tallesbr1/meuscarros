import 'package:carros/model/carros.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:carros/settings.dart';
import 'package:path/path.dart';

class VeiculosRepository {
  static final marcas = ['Fiat', 'Volks', 'Chevrolet', 'Ford'];

  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        db.execute(CREATE_VEICULOS_TABLE_SCRIPT);
        db.execute(CREATE_SERVICOS_TABLE_SCRIPT);

        return true;
      },
      version: 1,
    );
  }

  Future<void> adicionar(CarrosModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        TABLE_NAME_VEICULOS,
        model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<void> alterar(CarrosModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.update(
        TABLE_NAME_VEICULOS,
        model.toJson(),
        where: 'id = ?',
        whereArgs: [model.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<bool> remover(int id) async {
    try {
      final Database db = await _getDatabase();

      await db.delete(
        TABLE_NAME_VEICULOS,
        where: 'id = ?',
        whereArgs: [id],
      );

      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<List<CarrosModel>> listar() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_VEICULOS,
        orderBy: "id asc",
      );
      return List.generate(maps.length, (i) {
        return CarrosModel.fromJson(
          maps[i],
        );
      });
    } catch (ex) {
      print(ex);
      return <CarrosModel>[];
    }
  }

  Future<CarrosModel> getCarro(int id) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_VEICULOS,
        where: "id = ?",
        whereArgs: [id],
      );

      return CarrosModel.fromJson(
        maps[0],
      );
    } catch (ex) {
      print(ex);
      return CarrosModel();
    }
  }

  Future<void> executeSql(String sql) async {
    try {
      final Database db = await _getDatabase();
      db.rawQuery(sql);
    } catch (ex) {
      print(ex);
    }
  }
}
