
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget{
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool schedule = false}) async{
    var initAndroidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notification.initialize(settings);
  }


  static Future showNotification({
    var id = 0,
    var title,
    var body,
    var payload
  }) async => _notification.show(id, title, body, await notidicationDetails());


  static notidicationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

}


