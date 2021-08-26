import 'package:fluttertoast/fluttertoast.dart';
import 'package:carros/controller/login.controller.dart';
import 'package:carros/repositories/backup.repository.dart';
import 'package:carros/repositories/veiculos.repository.dart';
import 'package:carros/user.dart';
import 'package:flutter/material.dart';
import '../utils.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  final controller = new LoginController();

  bool busy = false;
  bool notifhabilitado = false;
  bool gerandoBackup = false;
  bool restaurarbackup = false;

  handleSignIn() {
    setState(() {
      busy = true;
    });
    controller.login().then((data) {
      onSucess();
    }).catchError((err) {
      onError();
    }).whenComplete(() {
      onComplete();
    });
  }

  onSucess() {
    setState(() {
      Navigator.pop(context);
    });
  }

  onError() {
    // scaffoldKey.currentState.showSnackBar(snackbar);
  }

  onComplete() {
    setState(() {
      busy = false;
    });
  }

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  carregarDados() async {
    LoginController.retornarDadosUsuario();
    notifhabilitado = await Utils.getNotificacaoHabilitada();

    var carrosrep = VeiculosRepository();
    var existecarros = await carrosrep.listar();
    restaurarbackup = (existecarros.isEmpty);

    setState(() {});
  }

  Future<void> criarBackup() async {
    setState(() {
      gerandoBackup = true;
    });
    bool feito = false;
    if (restaurarbackup) {
      feito = await Backup.restaurarBackup();
    } else
      feito = await Backup.criarBackup();

    String texto = "";
    if (feito) {
      restaurarbackup == true
          ? texto = "Backup restaurado com sucesso"
          : texto = "Backup realizado com sucesso";
    } else
      texto = restaurarbackup
          ? "Não foi possível encontrar o arquivo de backup"
          : "Ocorreu um erro ao realizar o procedimento";

    setState(() {
      gerandoBackup = false;
    });

    Fluttertoast.showToast(
        msg: texto,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    if (!feito) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text(
                  (user.name == null)
                      ? 'Bem-vindo. Faça o login para poder fazer backup dos dados'
                      : 'Bem-vindo, ${user.name}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                (user.picture != "")
                    ? Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(user.picture),
                          ),
                          color: Colors.black.withOpacity(0.2),
                          border: Border.all(
                            width: 5,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 10,
                      ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              // image:
              //     DecorationImage(image: ExactAssetImage('assets/155100.png')),
            ),
          ),
          Divider(),
          ListTile(
              title: (!gerandoBackup)
                  ? Text(
                      (user.name != '')
                          ? (restaurarbackup == true
                              ? 'Restaurar Backup'
                              : 'Fazer Backup')
                          : 'Login',
                      style: TextStyle(fontSize: 15),
                    )
                  : Center(child: CircularProgressIndicator()),
              onTap: (!gerandoBackup)
                  ? () async {
                      (user.name == '') ? handleSignIn() : await criarBackup();
                    }
                  : null),
          CheckboxListTile(
            title: Text("Notificações"),
            value: notifhabilitado != null ? notifhabilitado : false,
            onChanged: (bool value) {
              setState(() {
                Utils.setNotificacaoHabilitada(value);
                notifhabilitado = value;
              });
            },
          ),
          Divider(),
          (user.name != "")
              ? ListTile(
                  title: Text(
                    "Sair",
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    controller.logout();
                    Navigator.pop(context);
                  },
                )
              : SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }
}
