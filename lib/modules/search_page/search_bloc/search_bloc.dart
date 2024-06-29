import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zekra/constants/constants.dart';
import 'package:zekra/models/surah_model.dart';
import 'package:zekra/modules/search_page/search_bloc/search_states.dart';

import '../../../models/search_model.dart';

class SearchBloc extends Cubit<SearchStates>{
  static SearchBloc get(context)=>BlocProvider.of(context);
  SearchBloc():super(searchInitState());

  List<SurahModel> searchResults=[];
  List<SurahModel> subQuranList=quranList;

  void searchForAya(String aya){
    searchResults=[];
    print(aya);
    subQuranList.forEach((element) {
      String? x;
      if(element.text!.contains("$aya")){
        element.text=element.text!.substring(element.text!.indexOf(aya),);
        print("xxxxxxxxxxxxxxxxxxx is $x");
        searchResults.add(element);
      }

    });

  }
  List<SearchModel> searchModelsList=[];
  void search(String searchedAya){
    searchModelsList=[];
    subQuranList.forEach((element) {
      if(element.text!.length>0) {
        List<String> pageAyaList = [];
        pageAyaList = element.text!.split(')');
        pageAyaList.forEach((aya) {
          if (aya.contains(searchedAya)) {
            searchModelsList.add(SearchModel(surahName: element.surahName,pageNumber: int.parse(element.pageNumber),aya: aya));}

        });
      }
      else{
        print('shit');
      }
    });
    emit(searchSuccessState());

    // subQuranList.forEach((element) {
    //   List<String> pageAyaList=[];
    //   List<String> searchedModelAyaList=[];
    //   pageAyaList=element.text!.split('()');
    //   print("******************$pageAyaList");
    //   // pageAyaList.forEach((aya) {
    //   //   if(aya.contains(searchedAya))
    //   //   {
    //   //     searchedModelAyaList.add(aya);
    //   //     print(aya);
    //   //   }
    //   // });
    //   // searchModelsList.add(SearchModel(surahName: element.surahName,ayaList: searchedModelAyaList));
    //   emit(searchSuccessState());
    //
    // });
  }

  // void search(String aya){
  //   quranList.forEach((element) {
  //     if(element.text!.contains('aya'))
  //       {
  //         String x=element.text.startsWith(0)
  //         searchResults.add(element);
  //       }
  //   });
  // }
}