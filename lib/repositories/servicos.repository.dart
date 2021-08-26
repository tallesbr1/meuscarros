import 'package:carros/model/servicos.model.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:carros/settings.dart';
import 'package:path/path.dart';

class ServicosRepository {
  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_SERVICOS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future<void> adicionar(ServicosModel model) async {
    try {
      final Database db = await _getDatabase();

      var now = new DateTime.now();
      var formatter = new DateFormat("yyyy-MM-dd");
      model.dataregistro = formatter.format(now);

      await db.insert(
        TABLE_NAME_SERVICOS,
        model.toJson(),
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
        TABLE_NAME_SERVICOS,
        where: 'id = ?',
        whereArgs: [id],
      );

      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<bool> marcarComoFeito(int id, valorFeitoDesfeito) async {
    try {
      final Database db = await _getDatabase();

      ServicosModel model = await getServico(id);

      model.servicofeito = valorFeitoDesfeito;

      await db.update(
        TABLE_NAME_SERVICOS,
        model.toJson(),
        where: 'id = ?',
        whereArgs: [id],
      );

      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<List<ServicosModel>> listar(int idcarro) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_SERVICOS,
        where: "idveiculo = ? and servicofeito = ?",
        whereArgs: [idcarro, 0],
        // where: "idveiculo = ?",
        // whereArgs: [idcarro],
        orderBy: "id desc",
      );
      return List.generate(maps.length, (i) {
        return ServicosModel.fromJson(
          maps[i],
        );
      });
    } catch (ex) {
      print(ex);
      return <ServicosModel>[];
    }
  }

  Future<List<ServicosModel>> listarTodos(int idcarro) async {
    try {
      final Database db = await _getDatabase();
      List<Map<String, dynamic>> maps;
      if (idcarro != 0) {
        maps = await db.query(
          TABLE_NAME_SERVICOS,
          where: "idveiculo = ?",
          whereArgs: [idcarro],
          orderBy: "id desc",
        );
      } else {
        maps = await db.query(
          TABLE_NAME_SERVICOS,
          orderBy: "id desc",
        );
      }

      return List.generate(
        maps.length,
        (i) {
          return ServicosModel.fromJson(
            maps[i],
          );
        },
      );
    } catch (ex) {
      print(ex);
      return <ServicosModel>[];
    }
  }

  Future<List<Map<String, dynamic>>> listarServicosASeremFeitos() async {
    try {
      final Database db = await _getDatabase();

      // select * from servicos
      // where date(dataarealizar) <= date('2021-09-20') and servicofeito = 0

      String datacomparar = DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: 10)))
          .toString();

      String sql =
          " select v.marca, v.modelo, descricao, kmproximo,localservico, valor, dataservico,dataarealizar " +
              " from veiculos v left join servicos s on s.idveiculo = v.id " +
              " where s.servicofeito = 0 and date(dataarealizar) <= date( ? )  " +
              " order by date(dataarealizar)";

      List<Map<String, dynamic>> maps = await db.rawQuery(sql, [datacomparar]);

      return maps;
    } catch (ex) {
      print(ex);
      return <Map<String, String>>[];
    }
  }

  Future<List<String>> listarServicosCadastrados() async {
    try {
      final Database db = await _getDatabase();

      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_SERVICOS,
        columns: ['descricao'],
        distinct: true,
        orderBy: "descricao asc",
      );

      return List.generate(maps.length, (i) {
        return maps[i]['descricao'];
      });
    } catch (ex) {
      print(ex);
      return <String>[];
    }
  }

  Future<List<String>> listarLocaisCadastrados() async {
    try {
      final Database db = await _getDatabase();

      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_SERVICOS,
        columns: ['localservico'],
        distinct: true,
        orderBy: "localservico",
      );

      return List.generate(maps.length, (i) {
        return maps[i]['localservico'];
      });
    } catch (ex) {
      print(ex);
      return <String>[];
    }
  }

  Future<ServicosModel> getServico(int id) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_SERVICOS,
        where: "id = ?",
        whereArgs: [id],
      );

      return ServicosModel.fromJson(
        maps[0],
      );
    } catch (ex) {
      print(ex);
      return ServicosModel();
    }
  }

  Future<List<ServicosModel>> listarTodosBackup() async {
    try {
      final Database db = await _getDatabase();
      List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME_SERVICOS,
        orderBy: "id desc",
      );

      return List.generate(
        maps.length,
        (i) {
          return ServicosModel.fromJson(
            maps[i],
          );
        },
      );
    } catch (ex) {
      print(ex);
      return <ServicosModel>[];
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
