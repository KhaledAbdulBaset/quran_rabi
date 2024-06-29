import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../shared/local/shared_preferences.dart';
import '../trial_page/trial_Screen.dart';

class welcomeScreen extends StatefulWidget{
  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {

  @override
  void initState() {
    new Future.delayed(
        const Duration(seconds: 2,milliseconds: 300),
            () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>(SharedPref.getFromSharedPref("currentPage")==0||SharedPref.getFromSharedPref("currentPage")==null)?trialScreen(contentIndex: 0,):trialScreen(contentIndex: SharedPref.getFromSharedPref("currentPage"),),
          ),
                    (route) => false));
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
          Container(
            height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(image: AssetImage("assets/app_icon/icon.png",),height: 150,width: 150,)),
          SizedBox(height: 20,),
          Text("قرآن ربي",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
          SizedBox(height: 20,),
          Container(
              width: 200,
              child: LinearProgressIndicator(color: Colors.deepOrange,))
        ],),
      ),
    );
  }
}