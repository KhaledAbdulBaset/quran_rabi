import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class finalDoaaScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 500,
                width: double.infinity,
                child: Image(image: AssetImage("assets/final_doaa/doaa1.jpg"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,)),
            Container(
                height: 500,
                width: double.infinity,
                child: Image(image: AssetImage("assets/final_doaa/doaa2.jpg"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,)),
          ],
        ),
      )),
    );
  }
  
}