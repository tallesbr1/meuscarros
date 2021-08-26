class ServicosModel {
  int id;
  int idveiculo;
  String dataregistro;
  String descricao;
  String dataservico;
  double valor;
  double kmatual;
  double kmproximo;
  int mesproximo;
  String localservico;
  String outrasinformacoes;
  int servicofeito;
  String dataarealizar;

  ServicosModel({
    this.id,
    this.idveiculo,
    this.dataregistro,
    this.dataservico,
    this.descricao,
    this.kmatual,
    this.kmproximo,
    this.mesproximo,
    this.valor,
    this.localservico,
    this.outrasinformacoes,
    this.servicofeito,
    this.dataarealizar
  });

  ServicosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idveiculo = json['idveiculo'];
    dataregistro = json['dataregistro'];
    descricao = json['descricao'];
    dataservico = json['dataservico'];
    valor = json['valor'];
    kmatual = json['kmatual'];
    kmproximo = json['kmproximo'];
    mesproximo = json['mesproximo'];
    localservico = json['localservico'];
    outrasinformacoes = json['outrasinformacoes'];
    servicofeito = json['servicofeito'];
    dataarealizar = json['dataarealizar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idveiculo'] = this.idveiculo;
    data['dataregistro'] = this.dataregistro;
    data['descricao'] = this.descricao;
    data['dataservico'] = this.dataservico;
    data['valor'] = this.valor;
    data['kmatual'] = this.kmatual;
    data['kmproximo'] = this.kmproximo;
    data['mesproximo'] = this.mesproximo;
    data['localservico'] = this.localservico;
    data['outrasinformacoes'] = this.outrasinformacoes;
    data['servicofeito'] = this.servicofeito;
    data['dataarealizar'] = this.dataarealizar;
    return data;
  }
}
