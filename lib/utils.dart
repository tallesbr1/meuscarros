import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static String removerAcentos(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  static Future getNotificacaoHabilitada() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
      
      return prefs.getBool('notificacaohabilitada');
    
  }

  static Future setNotificacaoHabilitada(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('notificacaohabilitada', value);
  }
  
}
