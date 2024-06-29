// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:adhan/adhan.dart';
// import 'package:intl/intl.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:zekra/modules/azan_page/azan_cubit/azan_states.dart';
// class AzanCubit extends Cubit<AzanStates>{
//   AzanCubit ():super(azanInitState());
//   static AzanCubit get(context)=>BlocProvider.of(context);
//
//   dynamic egyLat=29.9976781;
//   dynamic egyLong=31.1941592;
//   Future<Position> getCurrentLocation()async
//   {
//     bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
//
//     if(!serviceEnabled){
//       return Future.error('location service is disabled');
//     }
//
//     LocationPermission permission= await Geolocator.checkPermission();
//
//     if(permission==LocationPermission.denied){
//       permission=await Geolocator.requestPermission();
//       if(permission==LocationPermission.denied){return Future.error('location permission denial');}
//     }
//
//     if(permission==LocationPermission.deniedForever){
//       return Future.error('location permission dinal for ever');
//     }
//
//     return Geolocator.getCurrentPosition();
//   }
//
//   String fajr='';
//   String zohr='';
//   String asr='';
//   String mghrb='';
//   String esha='';
//
//
//
//   void getPrayTimes(dynamic lat,dynamic long){
//     if(lat!=null&&long!=null){
//       print('Prayer Times');
//       final myCoordinates = Coordinates(lat,long); // Replace with your own location lat, lng.
//       final params = CalculationMethod.muslim_world_league.getParameters();
//       params.madhab = Madhab.hanafi;
//       final prayerTimes = PrayerTimes.today(myCoordinates, params);
//
//       print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
//       print(DateFormat.jm().format(prayerTimes.fajr));
//       fajr=DateFormat.jm().format(prayerTimes.fajr);
//
//       print(DateFormat.jm().format(prayerTimes.dhuhr));
//       zohr=DateFormat.jm().format(prayerTimes.dhuhr);
//
//       print(DateFormat.jm().format(prayerTimes.asr));
//       asr=DateFormat.jm().format(prayerTimes.asr);
//
//       print(DateFormat.jm().format(prayerTimes.maghrib));
//       mghrb=DateFormat.jm().format(prayerTimes.maghrib);
//
//       print(DateFormat.jm().format(prayerTimes.isha));
//       esha=DateFormat.jm().format(prayerTimes.isha);
//
//       emit(azanGetPrayTimesState());
//
//     }
//
//   }
//
//
//
//
// }
// import 'package:azan1/azan_screen/azan_cubit/azan_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zekra/modules/azan_page/azan_cubit/azan_states.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zekra/shared/local/shared_preferences.dart';
class AzanCubit extends Cubit<AzanStates>{
  AzanCubit ():super(azanInitState());
  static AzanCubit get(context)=>BlocProvider.of(context);


  Future<Position> getCurrentLocation()async
  {
    bool serviceEnabled=await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('location service is disabled');
    }

    LocationPermission permission= await Geolocator.checkPermission();

    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){return Future.error('location permission denial');}
    }

    if(permission==LocationPermission.deniedForever){
      return Future.error('location permission dinal for ever');
    }

    return Geolocator.getCurrentPosition();
  }

  dynamic fajrHour=0;
  dynamic fajrMin=0;
  String fajr='';
  List<String> fajrTime=[];


  dynamic zohrHour=0;
  dynamic zohrMin=0;
  String zohr='';
  List<String> zohrTime=[];


  dynamic asrHour=0;
  dynamic asrMin=0;
  String asr='';
  List<String> asrTime=[];

  dynamic mghrbHour=0;
  dynamic mghrbMin=0;
  String mghrb='';
  List<String> mghrbTime=[];

  dynamic eshaHour=0;
  dynamic eshaMin=0;
  String esha='';
  List<String> eshaTime=[];




  void getPrayTimes(dynamic lat,dynamic long){
    if(lat!=null&&long!=null){
      print('Prayer Times');
      final myCoordinates = Coordinates(lat,long);
      final params = CalculationMethod.umm_al_qura.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);

      print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
      print(DateFormat.jm().format(prayerTimes.fajr));

      bool fajrPM=false;
      fajr=DateFormat.jm().format(prayerTimes.fajr);
      if(fajr.contains("PM")){
        fajrPM=true;
      }
      fajr=fajr.replaceAll("AM", '');
      fajr=fajr.replaceAll("PM", '');

      fajrTime=fajr.split(":");
      fajrHour=int.parse(fajrTime[0]);
      if(fajrPM==true&&fajrHour!=12){fajrHour=fajrHour+12;}
      fajrMin=int.parse(fajrTime[1]);

      print("Fajr Hour ${fajrHour} +++++++++++++ Fajr Min ${fajrMin}");

      bool zohrPM=false;

      print(DateFormat.jm().format(prayerTimes.dhuhr));
      zohr=DateFormat.jm().format(prayerTimes.dhuhr);

      if(zohr.contains("PM")){zohrPM=true;}
      zohr=zohr.replaceAll("PM", '');
      zohr=zohr.replaceAll("AM", '');

      zohrTime=zohr.split(":");
      zohrHour=int.parse(zohrTime[0]);
      if(zohrPM){zohrHour+=12;}
      zohrMin=int.parse(zohrTime[1]);

      print("zohr Hour ${zohrHour}     zohr Min ${zohrMin}");

      bool asrPM=false;
      print(DateFormat.jm().format(prayerTimes.asr));
      asr=DateFormat.jm().format(prayerTimes.asr);
      if(asr.contains("PM")){asrPM=true;}

      asr=asr.replaceAll("PM", '');
      asr=asr.replaceAll("AM", '');

      asrTime=asr.split(":");

      asrHour=int.parse(asrTime[0]);
      if(asrPM){asrHour+=12;}

      asrMin=int.parse(asrTime[1]);

      print("asr Hour ${asrHour} +++++++++++++ asr Min ${asrMin}");
      bool mghrbPM=false;

      print(DateFormat.jm().format(prayerTimes.maghrib));
      mghrb=DateFormat.jm().format(prayerTimes.maghrib);
      if(mghrb.contains("PM")){mghrbPM=true;}

      mghrb=mghrb.replaceAll("PM", '');
      mghrb=mghrb.replaceAll("AM", '');

      mghrbTime=mghrb.split(":");

      mghrbHour=int.parse(mghrbTime[0]);
      if(mghrbPM){mghrbHour+=12;}

      mghrbMin=int.parse(mghrbTime[1]);

      print("mghrb hour ${mghrbHour} +++++++++++++ mghrb min ${mghrbMin}");

      bool eshaPM=false;

      print(DateFormat.jm().format(prayerTimes.isha));
      esha=DateFormat.jm().format(prayerTimes.isha);
      if(esha.contains("PM")){eshaPM=true;}

      esha=esha.replaceAll("PM", '');
      esha=esha.replaceAll("AM", '');

      eshaTime=esha.split(":");

      eshaHour=(int.parse(eshaTime[0]));
      if(eshaPM){eshaHour+=12;}

      eshaMin=int.parse(eshaTime[1]);

      print("888888888888888888 Esha  888888888888888888888 ${eshaHour} +++++++++++++ ${eshaMin}");




      emit(azanGetPrayTimesState());

    }

  }

  AudioPlayer player=AudioPlayer();
  int choosenAzanIndex=SharedPref.getFromSharedPref("choosenAzanIndex");
  void chooseAzan(index){
    choosenAzanIndex=index;
    SharedPref.saveIntoSharedPref("determinedAzan", "${determinedAzanList[index]}");
    SharedPref.saveIntoSharedPref("choosenAzanIndex",index);
    print("the choosen azan is ${determinedAzanList[index]}");
    emit(azanChooseSuccessState());
  }


  List<String> determinedAzanList=['azanmeka','azanmadena','azanflsten','azanefase','tkber'];

  void playAzan(String? azan){
    player.play(AssetSource("audio/$azan.mp3")).then((value) {
      print("$azan is good");
      emit(azanPlaySuccessState());
    });
  }
  void stopAzan(){
    player.stop().then((value) {
      emit(azanStopSuccessState());
    });
  }


  void disableAzanState(){
    SharedPref.saveIntoSharedPref("azanState", false);
    emit(disableAzanStateSuccessState());
  }

  void enableAzanState(){
    SharedPref.saveIntoSharedPref("azanState", true);
    emit(enableAzanStateSuccessState());
  }


}