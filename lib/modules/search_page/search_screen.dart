import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:zekra/models/surah_model.dart';
import 'package:zekra/modules/search_page/search_bloc/search_bloc.dart';
import 'package:zekra/modules/search_page/search_bloc/search_states.dart';

import '../../models/search_model.dart';
import '../../shared/local/shared_preferences.dart';
import '../trial_page/trial_Screen.dart';
class searchScreen extends StatelessWidget{
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) { return SearchBloc(); },
      child: BlocConsumer<SearchBloc,SearchStates>(
        builder: (BuildContext context, SearchStates state) {
          SearchBloc searchBloc=SearchBloc.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white,),
              backgroundColor: Color(0xff112233),title: Text("البحث",style: TextStyle(color: Colors.white,fontSize: 24),),centerTitle: true,),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    searchBloc.search(value);
                  },textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                      hintText: "أكتب الأية",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text("نتيجة",style: TextStyle(color: Colors.grey[700],fontSize: 22,fontWeight: FontWeight.w700),),
                          SizedBox(width: 10,),
                            Text("${searchBloc.searchModelsList.length}",style: TextStyle(color: Colors.green[400],fontSize: 20,fontWeight: FontWeight.w700),)
                        ],),
                      ),
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(child: ListView.separated(
                    itemBuilder: (context, index) => ItemSearch(searchBloc.searchModelsList[index],context),
                    separatorBuilder: (context, index) => Container(height: 4,width: double.infinity,color: Colors.black),
                    itemCount: searchBloc.searchModelsList.length))
              ],),
            ),
          );
        }, listener: (BuildContext context, SearchStates state) {  },

      ),
    );
  }

  Widget ItemSearch(SearchModel searchModel,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
        SharedPref.saveIntoSharedPref("currentPage", searchModel.pageNumber-1);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>trialScreen(contentIndex: searchModel.pageNumber-1,) ,), (route) => false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Text(" سورة${searchModel.surahName}",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 26,fontWeight: FontWeight.w900),),
          SizedBox(height: 14,),
          Text("${searchModel.aya}",textAlign: TextAlign.end,style: TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.w700)),
        ],),
      ),
    ),
  );
}