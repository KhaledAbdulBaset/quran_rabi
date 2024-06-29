import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class azkarScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,centerTitle: true,title: Text("أذكار الصباح و المساء",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 22),),),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(children: [
          Container(
              width: double.infinity,
              height: 1000,
              child: Image(image: AssetImage("assets/azkar/azkarsabah.png"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,)),
          Container(
              width: double.infinity,
              height: 1000,
              child: Image(image: AssetImage("assets/azkar/azkarmsaa.jpg"),height: double.infinity,width: double.infinity,fit: BoxFit.fill,))
        ],),
      ),)
    );
  }

}