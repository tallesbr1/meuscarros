const String DATABASE_NAME = "veiculos.db";
const String TABLE_NAME_VEICULOS = "veiculos";
const String CREATE_VEICULOS_TABLE_SCRIPT =
    "create table veiculos ( id integer primary key AUTOINCREMENT, tipo integer, marca text, modelo text, placa text, cor text, datacadastro text, anomodelo int);";

const String TABLE_NAME_SERVICOS= "servicos";
const String CREATE_SERVICOS_TABLE_SCRIPT =
    "create table servicos ( id integer primary key AUTOINCREMENT,  " +
                             "idveiculo integer, " +
                             "dataregistro text," +
                             "dataservico text, " +
                             "descricao text, " +
                             "kmatual real, " +
                             "kmproximo real, " +
                             "mesproximo integer, " +
                             "valor real, " +
                             "localservico text," +
                             "outrasinformacoes text, " +
                             "dataarealizar text,"
                             "servicofeito int);";

