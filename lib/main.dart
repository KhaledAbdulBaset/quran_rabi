import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:zekra/modules/welcome_screen/welcome_screen.dart';
import 'package:zekra/shared/local/shared_preferences.dart';
import 'modules/azan_page/azan_cubit/notification_controller.dart';
Future<void> main() async{
WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(null, [NotificationChannel(
          channelGroupKey: "channel_group_key_azan",
          channelKey: "channel_key_azan",
          channelName: "channel_name_azan",
          channelDescription: "channel_description_azan",
          importance: NotificationImportance.Max,
          criticalAlerts: true,


        ),], channelGroups: [NotificationChannelGroup(channelGroupKey: "channel_group_key_azan", channelGroupName: "channel_group_name_azan")]);
  bool isNotificationsAllowed=await AwesomeNotifications().isNotificationAllowed();
  if(!isNotificationsAllowed){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  SharedPref.initSharedPref();




    runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceiveMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceiveMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
    );




    if(SharedPref.getFromSharedPref("determinedAzan")==-1)
    {SharedPref.saveIntoSharedPref("determinedAzan", "azanmeka").then((value)
    {
      print("save determined azan   x%%%%%%%  $value");
      if(SharedPref.getFromSharedPref("choosenAzanIndex")==-1)
      {SharedPref.saveIntoSharedPref("choosenAzanIndex", 0).then((value)
      {
        print("save choosen azan index%%%%%%%  $value");
        if(SharedPref.getFromSharedPref("azanState")==-1)
        { SharedPref.saveIntoSharedPref("azanState", false).then((value) {
          print("save azan state  x%%%%%%%  $value");
        });
        }
      });
      }

    });}



    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:welcomeScreen(),
      
    );
  }
}