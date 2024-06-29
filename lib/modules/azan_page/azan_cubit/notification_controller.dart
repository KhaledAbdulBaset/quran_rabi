import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zekra/shared/local/shared_preferences.dart';
class NotificationController{
  static AudioPlayer player=AudioPlayer();
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification)async{
    print("on notification create method");
    

  }

  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification)async{
    print("on notification display method");

    player.play(AssetSource("audio/${SharedPref.getFromSharedPref("determinedAzan")}.mp3")).then((value) {
      print("azan is good");
    });
  }


  static Future<void> onDismissActionReceiveMethod(ReceivedAction receivedAction)async{
    player.stop();
print("onDismissAction");
  }


  static Future<void> onActionReceiveMethod(ReceivedNotification receivedNotification)async {
    print("onActionRecieve");

  }

}