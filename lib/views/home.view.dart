import 'package:carros/bloc/cubit/home/carros_bloc_cubit.dart';
import 'package:carros/bloc/cubit/home/carros_bloc_state.dart';
import 'package:carros/controller/servicos.controller.dart';
import 'package:carros/views/addcarro.view.dart';
import 'package:carros/views/servicosafazer.view.dart';
import 'package:carros/widget/carroslist.widget.dart';
import 'package:carros/widget/menuprincipal.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool fechouAviso = false;
  bool manutencaoproxima = false;

  final bloc = GetIt.I.get<CarrosBlocCubit>();

  final bannerId = "ca-app-pub-7755244434659492/3919035577";
  BannerAd myBanner;
  BannerAd buildBannerAd() {
    return BannerAd(
        adUnitId: bannerId,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myBanner..show();
          }
        });
  }
  

  removerCarro(int id) async {
    await bloc.remover(id);
  }

  recuperarDados() async {
    bloc.getCarros;
  }

  @override
  void initState() {
    super.initState();

    verificarManutencaoProxima();

    // FirebaseAdMob.instance
    //     .initialize(appId: "ca-app-pub-7755244434659492~95987376697");

    // myBanner = buildBannerAd()
    //   ..load()
    //   ..show(anchorType: AnchorType.bottom);
  }

  @override
  void dispose() {
    myBanner?.dispose();
    super.dispose();
  }

  verificarManutencaoProxima() async {
    var controller = ServicosController();
    var map = await controller.listarServicosASeremFeitos();
    setState(() {
      manutencaoproxima = map.isEmpty == false;
    });
  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      onDrawerChanged: (value) {
        if (!value) {
          setState(() {
            recuperarDados();
          });
        }
      },
      appBar: AppBar(
        title: Text('Meus carros'),
      ),
      drawer: MenuPrincipal(),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            ((fechouAviso == false) && (manutencaoproxima == true))
                ? Container(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    width: 320,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Lista as que estao prestes a fazer manutenção

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServicosaFazer(),
                                    ));
                              },
                              child: Text(
                                "Existem manutenções prestes \na serem feitas. Clique aqui para vê-las",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  fechouAviso = !fechouAviso;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            Container(
              width: double.infinity,
              height: 500,
              child: BlocBuilder<CarrosBlocCubit, CarrosBlocState>(
                bloc: bloc ,
                builder: (context, state) {
                  if (state is CarrosBlocLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CarrosBlocLoaded) {
                    var list = state.list;

                    if (list.length <= 0) {
                      return Center(
                        child: Text(
                            "Nenhum veículo cadastrado\nVocê pode cadastrar um novo clicando abaixo"),
                      );
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          key:
                              UniqueKey(), //Key(controller.listCarros[i].id.toString()),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              removerCarro(list[i].id);
                            }
                          },
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Excluir veículo"),
                                  content: const Text(
                                      "Tem certeza?\nTodas as informações serão perdidas!"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Sim")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Não"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CarrosList(
                            carro: list[i],
                          ),
                          background: Container(
                            alignment: Alignment.center,
                            color: Colors.red,
                            child: Text(
                              "Remover",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCarroView(),
              ),
            ).then((value) => setState(() {
                  bloc.getCarros;
                }));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
