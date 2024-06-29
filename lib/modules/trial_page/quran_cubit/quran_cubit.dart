import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:zekra/modules/trial_page/quran_cubit/quran_states.dart';

import '../../../shared/local/shared_preferences.dart';
class QuranBloc extends Cubit<QuranStates>{
  QuranBloc():super(quranInitState());
  static QuranBloc get(context)=>BlocProvider.of(context);


  bool showOptions=false;
  void displayOptions(){
    showOptions=!showOptions;
    print(showOptions);
    emit(displayOptionsState());
  }




  // int? signIndex;
  void putSign(index){
    SharedPref.saveIntoSharedPref("flag", index).then((value) {
      // signIndex=index;
      print('successful putting a sign of $index');
      emit(successfulPuttingSignState());
    });
  }



  PageController pageController=PageController();

  void contentPage(contentIndex){
    if(contentIndex==0){
      pageController=PageController(initialPage: 0);
    }
    else{
      pageController=PageController(initialPage: contentIndex);
    }
  }

  void goToSign(){
    if(SharedPref.getFromSharedPref("flag")!=null){
        pageController.jumpToPage(SharedPref.getFromSharedPref("flag"));
        emit(goToSignSuccessState());
    }
  }

}