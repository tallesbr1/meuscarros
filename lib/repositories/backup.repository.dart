import 'dart:convert';
import 'dart:io';
import 'package:carros/controller/carros.controller.dart';
import 'package:carros/controller/login.controller.dart';
import 'package:carros/model/carros.model.dart';
import 'package:carros/model/servicos.model.dart';
import 'package:carros/repositories/servicos.repository.dart';
import 'package:carros/repositories/veiculos.repository.dart';
import 'dart:convert' show utf8;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:http/http.dart' as http;
import 'package:carros/user.dart';
import 'package:get_it/get_it.dart';

class Backup {
  static bool restaurando = false;

  static Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/meuscarros.json');
  }

  static Future<String> gerarJson() async {
    var rep1 = VeiculosRepository();
    var rep2 = ServicosRepository();

    var servicos = await rep2.listarTodosBackup();
    var carros = await rep1.listar();

    var jsonCarros = '"carros":' + jsonEncode(carros);
    var jsonservicos = '"servicos":' + jsonEncode(servicos);

    String json = "{" + jsonCarros + ",\n" + jsonservicos + "}";

    final file = await _localFile;
    file.writeAsString(json);

    return file.path;
  }

  static Future<bool> criarBackup() async {
    try {
      final controller = new LoginController();

      var path = await Backup.gerarJson();

      await controller.login();

      final googleSignIn =
          signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveScope]);
      final signIn.GoogleSignInAccount account = await googleSignIn.signIn();

      final authenticateClient = GoogleAuthClient(user.authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      var idanterior = await Backup.getID();

      var uploadFile = File(path);
      drive.File fileToUpload = drive.File();

      fileToUpload.name = "backup_meuscarros.json";
      fileToUpload.mimeType = 'application/application/vnd.google-apps.file';

      var result = await driveApi.files.create(
        fileToUpload,
        uploadMedia: drive.Media(
          uploadFile.openRead(),
          uploadFile.lengthSync(),
        ),
      );

      await Backup.setID(result.id);

      //deleta o ultimo
      var delete = await driveApi.files.delete(idanterior);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future setID(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("idbackup", value);
  }

  static Future getID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("idbackup");
    return (id == null) ? "" : id;
  }

  static Future restaurarBackup() async {
    try {
      final controller = new LoginController();

      await controller.login();

      final googleSignIn =
          signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveScope]);
      final signIn.GoogleSignInAccount account = await googleSignIn.signIn();

      final authenticateClient = GoogleAuthClient(user.authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      drive.File file = drive.File();

      var f = await driveApi.files.list(q: "name = 'backup_meuscarros.json'");

      drive.Media xx = await driveApi.files
          .get(f.files[0].id, downloadOptions: drive.DownloadOptions.FullMedia);

      List<int> dataStore = [];
      xx.stream.listen((data) {
        dataStore.insertAll(dataStore.length, data);
      }, onDone: () async {
        // Directory tempDir =
        //     await getTemporaryDirectory(); //Get temp folder using Path Provider
        String tempPath = await _localPath; //Get path to that location
        File file = File('$tempPath/backup.txt'); //Create a dummy file
        await file.writeAsBytes(
            dataStore); //Write to that file from the datastore you created from the Media stream
        String content = file.readAsStringSync(); // Read String from the file
        // print(content); //Finally you have your text
        if (content != "") await salvardados(content);
      }, onError: (error) {
        print("Some Error");
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> salvardados(String dados) async {
    try {
      restaurando = true;
      Map<String, dynamic> userMap = jsonDecode(dados);
      var ret = Dados.fromJson(userMap);

      var carrosRep = VeiculosRepository();
      await carrosRep.executeSql('delete from veiculos');
      final controller = GetIt.I.get<CarrosController>();

      for (var carro in ret.carros) {
        await controller.salvar(carro);
      }

      // await carros.adicionar(ret.carros[0]);

      var servs = ServicosRepository();
      await servs.executeSql("delete from servicos");
      for (var servico in ret.servicos) {
        await servs.adicionar(servico);
      }
    } catch (e) {
      restaurando = false;
    } finally {
      restaurando = false;
    }
    // await serv.adicionar(ret.servicos[0]);
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class Dados {
  List<CarrosModel> carros;
  List<ServicosModel> servicos;

  Dados({this.carros, this.servicos});

  Dados.fromJson(Map<String, dynamic> json) {
    if (json['carros'] != null) {
      carros = [];
      json['carros'].forEach((v) {
        carros.add(new CarrosModel.fromJson(v));
      });
    }
    if (json['servicos'] != null) {
      servicos = [];
      json['servicos'].forEach((v) {
        servicos.add(new ServicosModel.fromJson(v));
      });
    }
  }
}
