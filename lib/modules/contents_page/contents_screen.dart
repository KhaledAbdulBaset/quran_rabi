import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zekra/models/content_model.dart';
import 'package:zekra/modules/trial_page/trial_Screen.dart';

import '../../constants/constants.dart';

class contentScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(child: Column(children: [

        Expanded(child: ListView.separated(
            itemBuilder: (context, index) => ItemContents(contentList[index], context),
            separatorBuilder:(context, index) =>   Container(height: 2,width: double.infinity,color: Colors.white,),
            itemCount: contentList.length))


      ],)),
    );
  }

  Widget ItemContents(ContentModel contentModel,context)=> InkWell(
    onTap: (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => trialScreen(contentIndex: contentModel.surahStartPage-1,),), (route) => false);
    },
    child: Container(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 60,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text("${contentModel.surahStartPage}",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow.withOpacity(0.7),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: Text("آياتها ${contentModel.ayaNumber}",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,

                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(image: AssetImage("${contentModel.surahTypeImage}"),height: 70,width: double.infinity,fit: BoxFit.fill,),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text("${contentModel.surahName}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                  ),

                ],),
            ),
          ),
          Container(
            width: 60,
            color: Colors.black,
            alignment: Alignment.center,
            child: Text("${contentModel.surahNumber}",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
          ),


        ],
      ),
    ),
  );
}