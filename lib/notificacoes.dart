import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notificacoes {
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails("teste", "teste2", "teste3");

  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettingsIOS = new IOSInitializationSettings();
  final flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  Notificacoes() {
    iniciarConfigNotificacoes();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
  }

  iniciarConfigNotificacoes() {
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future agendarNotificacao(
      String titulo, String descricao, String payload, int dias) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   titulo,
    //   descricao,
    //   platformChannelSpecifics,
    //   payload: payload,
    // );
    
    var scheduledNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(Duration(days: dias, seconds: 15));
    

    await flutterLocalNotificationsPlugin.zonedSchedule(0, titulo, descricao,
        scheduledNotificationDateTime, platformChannelSpecifics,
        payload: payload,
        uiLocalNotificationDateInterpretation: null,
        androidAllowWhileIdle: false);
  }

  Future onSelectNotification(String payload) async {
    //return MyApp.navigatorKey.currentState.pushNamed('home');
    //Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //return Home();
    //payload: payload,
    //}));
  }

  Future<void> agendarNotification(String titulo, String descricao) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '',
      '',
      '',
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      titulo,
      descricao,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: null,
    );
  }
}
