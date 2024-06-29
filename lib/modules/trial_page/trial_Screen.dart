import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zekra/modules/azan_page/azan_screen.dart';
import 'package:zekra/modules/azkar/azkar_screen.dart';
import 'package:zekra/modules/contents_page/contents_screen.dart';
import 'package:zekra/modules/qibla_page/qibla_screen.dart';
import 'package:zekra/modules/search_page/search_screen.dart';
import 'package:zekra/modules/trial_page/quran_cubit/quran_cubit.dart';
import 'package:zekra/modules/trial_page/quran_cubit/quran_states.dart';
import 'package:zekra/shared/local/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/constants.dart';
import '../../models/surah_model.dart';
class trialScreen extends StatelessWidget{
int contentIndex=0;
trialScreen({int contentIndex=0}){
  this.contentIndex=contentIndex;
  SharedPref.saveIntoSharedPref("currentPage", contentIndex);
}

  @override
  Widget build(BuildContext context) {
  
    return BlocProvider(
      create: (BuildContext context) { return QuranBloc(); },
      child: BlocConsumer<QuranBloc,QuranStates>(
        builder: (BuildContext context, QuranStates state) {
          QuranBloc quranBloc=QuranBloc.get(context)..contentPage(contentIndex);
          var pageController=quranBloc.pageController;

          return Scaffold(
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: PageView.builder(
                    controller: quranBloc.pageController,  
                      physics: BouncingScrollPhysics(),
                    reverse: true,
                    onPageChanged: (index){
                      SharedPref.saveIntoSharedPref("currentPage", index);

                    },
                    itemCount: quranList.length,
                    itemBuilder: (context, index) =>ItemQuranPage(quranList[index],quranBloc,context,index,pageController)),
                )
              ],),
            )
          );


        }, listener: (BuildContext context, QuranStates state) {

      },

      ),
    );
  }


  Widget ItemQuranPage(SurahModel surahModel,QuranBloc quranBloc,context,index,pageController)=>InkWell(
    onTap: (){
      quranBloc.displayOptions();
    },
    child: Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  ClipRRect(
                      child: Transform.scale(
                          // scale: 1.158,
                          scaleX: 1.22,
                          scaleY: 1.14,
                          child: Image.asset("${surahModel.pageImage}",height: double.infinity,width: double.infinity,fit: BoxFit.fill,))),

                  if(SharedPref.getFromSharedPref("flag")==index)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(height: 200,width: 100,color: Colors.red.withOpacity(0.8),),
                    )

                ],
              )),
         ////////////////////////// page number & surah name & juza
          if(quranBloc.showOptions)
            Container(
              height: 60,
              width: double.infinity,
              color: Colors.black.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                      width: 160,
                      alignment: Alignment.center,

                      child: Text("${surahModel.surahJoza}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900),)),
                  Spacer(),
                  Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Text("${surahModel.pageNumber}",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),)),
                  Spacer(),
                  Container(
                      width: 160,
                      alignment: Alignment.center,
                      child: Text(" سورة${surahModel.surahName}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w900),)),

                ],),
              ),
            ),
          if(quranBloc.showOptions)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),));
                                    },
                                    child: Container(
                                      color: Colors.transparent,//Color(0xff112233),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        Text("البحث",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)),
                                        SizedBox(width: 10,),
                                        Icon(Icons.search,color: Colors.white,)
                                      ],),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Container(color: Colors.white,width: 2,height: double.infinity,),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => contentScreen(),), (route) => false);
                                    },
                                    child: Container(
                                      color: Colors.transparent,// Colors.green,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("الفهرس",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)),
                                          SizedBox(width: 10,),
                                          Icon(Icons.menu,color: Colors.white,)
                                        ],),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(color: Colors.white,width: double.infinity,height: 2,),
                        SizedBox(height: 5,),

                        //////////////////////////azan  and qubila pages
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /////////////////////azan /////
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => azanScreen(),));
                                    },
                                    child: Container(
                                      color: Colors.transparent,//Color(0xff63000a),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("الأذان",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)),
                                          SizedBox(width: 10,),
                                          Icon(Icons.mosque,color: Colors.white,)
                                        ],),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Container(color: Colors.white,width: 2,height: double.infinity,),
                                SizedBox(width: 5,),
                                ///////////////compass//////////
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => qiblaScreen(),));
                                    },
                                    child: Container(
                                      color: Colors.transparent,//Colors.deepOrange,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("القبلة",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)),
                                          SizedBox(width: 10,),
                                          Icon(CupertinoIcons.compass,color: Colors.white,)
                                        ],),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(color: Colors.white,width: double.infinity,height: 2,),
                        SizedBox(height: 5,),
                        ///////////////// put sign and go to sign of reading////////////////
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///////////////// put sign button ////////////////
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      quranBloc.putSign(index);
                                    },
                                    child: Container(
                                      color: Colors.transparent,//Colors.red,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("وضع علامة",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)),
                                          SizedBox(width: 10,),
                                          Icon(Icons.fmd_good_outlined,color: Colors.white,)
                                        ],),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Container(color: Colors.white,width: 2,height: double.infinity,),
                                SizedBox(width: 5,),
                                ///////////////// GO TO sign button ////////////////
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      quranBloc.goToSign();
                                    },
                                    child: Container(
                                      color: Colors.transparent,//Colors.indigo,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("الذهاب الي العلامة",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700)),
                                          SizedBox(width: 5,),
                                          Icon(Icons.fmd_bad,color: Colors.white,)
                                        ],),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(color: Colors.white,width: double.infinity,height: 2,),
                        SizedBox(height: 5,),
                        ///////////////// azkar sabah and masaa and share button////////////////






                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /////////////////  azkra  button ////////////////
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => azkarScreen(),));

                                    },
                                    child: Container(
                                    color: Colors.transparent,//Colors.blueGrey,// Colors.amber,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("أذكار الصباح و المساء",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700)),
                                          SizedBox(width: 10,),
                                          Icon(Icons.library_books,color: Colors.white,)
                                        ],),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Container(color: Colors.white,width: 2,height: double.infinity,),
                                SizedBox(width: 5,),                                /////////////////share button ////////////////
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: InkWell(
                                      onTap: (){

                                        Share.share("https://play.google.com/store/apps/details?id=com.maher4web.quran");
                                      },
                                      child: Container(
                                        color: Colors.transparent,//Colors.blueGrey,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("مشاركة الرابط",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700)),
                                            SizedBox(width: 10,),
                                            Icon(Icons.share,color: Colors.white,)
                                          ],),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),













                      ],),
                  ),
                ),

              ],)


        ],
      ),
    ),
  );





}

