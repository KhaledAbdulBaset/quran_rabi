
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:zekra/modules/azan_page/azan_cubit/azan_cubit.dart';
import 'package:zekra/modules/azan_page/azan_cubit/azan_states.dart';
import 'package:zekra/shared/local/shared_preferences.dart';
class azanScreen extends StatefulWidget{
  @override
  State<azanScreen> createState() => _azanScreenState();
}

class _azanScreenState extends State<azanScreen> {
  dynamic myLat;
  dynamic myLong;
  var scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key:scaffoldKey ,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color(0xff112233),
        centerTitle: true,
        title: Text("الأذان",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),),
      body: BlocProvider(
        create: (BuildContext context) { return AzanCubit(); },
        child: BlocConsumer<AzanCubit,AzanStates>(
          builder: (BuildContext context, AzanStates state) {
            AzanCubit azanCubit=AzanCubit.get(context);
            return   SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(image: AssetImage("assets/madena.JPG"),height: 100,width: 100,fit: BoxFit.fill,)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('لا تنسي تفعيل الموقع الجغرافي ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                  SizedBox(height: 10,),
                  Container(
                    height: 60,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            InkWell(
                              onTap: ()async{
                                {


                                  azanCubit.getCurrentLocation().then((value) {{
                                    myLat=value.latitude;
                                    myLong=value.longitude;
                                    azanCubit.getPrayTimes(myLat,myLong);
                                    print('${azanCubit.fajrHour}  ${azanCubit.zohrHour} ${azanCubit.asrHour} ${azanCubit.mghrbHour} ');


                                    SharedPref.saveIntoSharedPref("fajrTime", azanCubit.fajr);
                                    SharedPref.saveIntoSharedPref("zohrTime", azanCubit.zohr);
                                    SharedPref.saveIntoSharedPref("asrTime", azanCubit.asr);
                                    SharedPref.saveIntoSharedPref("mghrbTime", azanCubit.mghrb);
                                    SharedPref.saveIntoSharedPref("eshaTime", azanCubit.esha);

                                    if(SharedPref.getFromSharedPref("azanState")==false) {
                                      azanCubit.enableAzanState();

                                      AwesomeNotifications().createNotification(content: NotificationContent(
                                            id: 1,
                                            channelKey: "channel_key_azan",
                                            title: "أذان الفجر",
                                            body: "حان الان موعد أذان الفجر",
                                            timeoutAfter: Duration(minutes: 10),
                                            bigPicture: "https://img.freepik.com/free-photo/mosque-building-with-intricate-architecture_23-2150999848.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais",
                                            notificationLayout: NotificationLayout.BigPicture,
                                            displayOnBackground: true,
                                            displayOnForeground: true,
                                            criticalAlert: true,
                                        ), schedule: NotificationCalendar(
                                          hour:azanCubit.fajrHour,
                                          minute: azanCubit.fajrMin,
                                          second: 0,
                                          millisecond: 0,
                                          repeats: true,
                                          preciseAlarm: true,
                                          allowWhileIdle: true,

                                        ));
                                      AwesomeNotifications().createNotification(content: NotificationContent(
                                        id: 2,
                                        channelKey: "channel_key_azan",
                                        title: "أذان الظهر",
                                        body: "حان الان موعد أذان الظهر",
                                        timeoutAfter: Duration(minutes: 10),
                                        bigPicture: "https://img.freepik.com/free-photo/mosque-building-with-intricate-architecture_23-2150999848.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais",
                                        notificationLayout: NotificationLayout.BigPicture,
                                        // displayOnBackground: true,
                                        displayOnForeground: true,
                                        criticalAlert: true,
                                      ), schedule: NotificationCalendar(
                                          hour: azanCubit.zohrHour,
                                          minute: azanCubit.zohrHour,
                                          second: 0,
                                          millisecond: 0,
                                          repeats: true,
                                          preciseAlarm: true,
                                        allowWhileIdle: true,
                                      ));
                                      AwesomeNotifications().createNotification(content: NotificationContent(
                                        id: 3,
                                        channelKey: "channel_key_azan",
                                        title: "أذان العصر",
                                        body: "حان الان موعد أذان العصر",
                                        timeoutAfter: Duration(minutes: 10),
                                        bigPicture: "https://img.freepik.com/free-photo/mosque-building-with-intricate-architecture_23-2150999848.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais",
                                        notificationLayout: NotificationLayout.BigPicture,
                                        // displayOnBackground: true,
                                        displayOnForeground: true,
                                        criticalAlert: true,
                                      ), schedule: NotificationCalendar(
                                          hour: azanCubit.asrHour,
                                          minute: azanCubit.asrMin,
                                          second: 0,
                                          millisecond: 0,
                                          repeats: true,
                                          preciseAlarm: true,
                                        allowWhileIdle: true
                                      ));
                                      AwesomeNotifications().createNotification(content: NotificationContent(
                                        id: 4,
                                        channelKey: "channel_key_azan",
                                        title: "أذان المغرب",
                                        body: "حان الان موعد أذان المغرب",
                                        timeoutAfter: Duration(minutes: 10),
                                        bigPicture: "https://img.freepik.com/free-photo/mosque-building-with-intricate-architecture_23-2150999848.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais",
                                        notificationLayout: NotificationLayout.BigPicture,
                                        // displayOnBackground: true,
                                        displayOnForeground: true,
                                        criticalAlert: true,
                                      ), schedule: NotificationCalendar(
                                          hour: azanCubit.mghrbHour,
                                          minute: azanCubit.mghrbMin,
                                          second: 0,
                                          millisecond: 0,
                                          repeats: true,
                                          preciseAlarm: true,
                                        allowWhileIdle: true,
                                      ));
                                      AwesomeNotifications().createNotification(content: NotificationContent(
                                        id: 5,
                                        channelKey: "channel_key_azan",
                                        title: "أذان العشاء",
                                        body: "حان الان موعد أذان العشاء",
                                        timeoutAfter: Duration(minutes: 10),
                                        bigPicture: "https://img.freepik.com/free-photo/mosque-building-with-intricate-architecture_23-2150999848.jpg?size=626&ext=jpg&ga=GA1.1.553209589.1715126400&semt=ais",
                                        notificationLayout: NotificationLayout.BigPicture,
                                        // displayOnBackground: true,
                                        displayOnForeground: true,
                                        criticalAlert: true,
                                      ), schedule: NotificationCalendar(
                                          hour: azanCubit.eshaHour,
                                          minute: azanCubit.eshaMin,
                                          second: 0,
                                          millisecond: 0,
                                          repeats: true,
                                          preciseAlarm: true,
                                        allowWhileIdle: true
                                      ));

                                    }





                                  }
                                  });

                                }
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)],
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Text("تحديث مواعيد الصلاة",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),),
                              ),
                            ),
                            SizedBox(width: 15,),


                            InkWell(
                              onTap: (){
                                azanCubit.disableAzanState();
                                AwesomeNotifications().cancelAll().then((value) {
                                  print("all azans are canceld");
                                });
                              },
                              child: Container(height: 50,width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                  borderRadius: BorderRadius.all( Radius.circular(20)),
                                  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 1,spreadRadius: 1)]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('ايقاف الاذان',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                    Icon(Icons.stop,size: 25,),
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(height: 80,width: double.infinity, child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            azanCubit.chooseAzan(4);

                          },
                          child: Container(
                            height: double.infinity,width: 120,
                            decoration: BoxDecoration(
                                color: azanCubit.choosenAzanIndex==4?Colors.green:Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("تكبير",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          azanCubit.playAzan("tkber");
                                        },
                                        child: Icon(Icons.not_started,size: 30,)),
                                    SizedBox(width: 5,),
                                    InkWell(
                                        onTap: (){
                                          azanCubit.stopAzan();
                                        },
                                        child: Icon(Icons.stop_circle,size: 30,)),

                                  ],)
                              ],),

                          ),
                        ),
                        SizedBox(width:15,),

                        InkWell(
                          onTap: (){
                            azanCubit.chooseAzan(3);
                          },
                          child: Container(
                            height: double.infinity,width: 120,
                            decoration: BoxDecoration(
                                color: azanCubit.choosenAzanIndex==3?Colors.green:Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text("أذان العفاسي",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                InkWell(
                                    onTap: (){
                                      azanCubit.playAzan("azanefase");
                                    },
                                    child: Icon(Icons.not_started,size: 30,)),
                                SizedBox(width: 5,),
                                InkWell(
                                    onTap: (){
                                      azanCubit.stopAzan();
                                    },
                                    child: Icon(Icons.stop_circle,size: 30,)),

                              ],)
                            ],),

                          ),
                        ),
                        SizedBox(width: 15,),
                        InkWell(
                          onTap: (){
                            azanCubit.chooseAzan(2);
                          },
                          child: Container(
                            height: double.infinity,width: 120,
                            decoration: BoxDecoration(
                                color: azanCubit.choosenAzanIndex==2?Colors.green:Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("أذان فلسطين",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          azanCubit.playAzan("azanflsten");
                                        },
                                        child: Icon(Icons.not_started,size: 30,)),
                                    SizedBox(width: 5,),
                                    InkWell(
                                        onTap: (){
                                          azanCubit.stopAzan();
                                        },
                                        child: Icon(Icons.stop_circle,size: 30,)),

                                  ],)
                              ],),

                          ),
                        ),
                        SizedBox(width: 15,),
                        InkWell(
                          onTap: (){
                            azanCubit.chooseAzan(1);
                          },
                          child: Container(
                            height: double.infinity,width: 120,
                            decoration: BoxDecoration(
                                color: azanCubit.choosenAzanIndex==1?Colors.green:Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("أذان المدينة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          azanCubit.playAzan("azanmadena");
                                        },
                                        child: Icon(Icons.not_started,size: 30,)),
                                    SizedBox(width: 5,),
                                    InkWell(
                                        onTap: (){
                                          azanCubit.stopAzan();
                                        },
                                        child: Icon(Icons.stop_circle,size: 30,)),

                                  ],)
                              ],),

                          ),
                        ),
                        SizedBox(width: 15,),
                        InkWell(
                          onTap: (){
                            azanCubit.chooseAzan(0);
                          },
                          child: Container(
                            height: double.infinity,width: 120,
                            decoration: BoxDecoration(
                                color: azanCubit.choosenAzanIndex==0?Colors.green:Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("أذان مكة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          azanCubit.playAzan("azanmeka");
                                        },
                                        child: Icon(Icons.not_started,size: 30,)),
                                    SizedBox(width: 5,),
                                    InkWell(
                                        onTap: (){
                                          azanCubit.stopAzan();
                                        },
                                        child: Icon(Icons.stop_circle,size: 30,)),

                                  ],)
                              ],),

                          ),
                        ),

                        SizedBox(width: 5,),
                      ],),
                    ),
                  ),),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          Image(image: AssetImage("assets/fajar.JPG"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.8),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${SharedPref.getFromSharedPref("fajrTime")==null?'':SharedPref.getFromSharedPref("fajrTime")}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),
                                  SizedBox(width: 15,),
                                  Text("صلاة الفجر",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),

                                ],),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          Image(image: AssetImage("assets/zohr.JPG"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.8),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${SharedPref.getFromSharedPref("zohrTime")==null?'':SharedPref.getFromSharedPref("zohrTime")}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),
                                  SizedBox(width: 15,),
                                  Text("صلاة الظهر",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),

                                ],),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          Image(image: AssetImage("assets/asr.JPG"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${SharedPref.getFromSharedPref("asrTime")==null?'':SharedPref.getFromSharedPref("asrTime")}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),
                                  SizedBox(width: 15,),
                                  Text("صلاة العصر",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),

                                ],),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          Image(image: AssetImage("assets/maghrb.JPG"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${SharedPref.getFromSharedPref("mghrbTime")==null?'':SharedPref.getFromSharedPref("mghrbTime")}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),
                                  SizedBox(width: 15,),
                                  Text("صلاة المغرب",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),

                                ],),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          Image(image: AssetImage("assets/esha.JPG"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${SharedPref.getFromSharedPref("eshaTime")==null?'':SharedPref.getFromSharedPref("eshaTime")}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),
                                  SizedBox(width: 15,),
                                  Text("صلاة العشاء",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),),

                                ],),
                            ),
                          )
                        ],
                      ),
                    ),
                  )




                ],),
            ) ;
          }, listener: (BuildContext context, AzanStates state) {

            if(state is enableAzanStateSuccessState){
              scaffoldKey.currentState!.showBottomSheet((context) =>Container(
                height: 80,
                width: double.infinity,
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("تم تفعيل الاذان",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                    SizedBox(width: 20,),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close_sharp,color: Colors.red,size: 20,))
                  ],
                ),
              ) );
            }

            if(state is disableAzanStateSuccessState){
              scaffoldKey.currentState!.showBottomSheet((context) =>Container(
                height: 80,
                width: double.infinity,
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("تم الغاء الاذان",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                    SizedBox(width: 20,),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close_sharp,color: Colors.red,size: 20,))
                  ],
                ),
              ) );
            }


        },

        ),
      ),
    );
  }
}