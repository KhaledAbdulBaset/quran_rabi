import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:zekra/modules/qibla_page/qibla_compass.dart';
class qiblaScreen extends StatelessWidget{
  final _deviceSupport=FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
          future: _deviceSupport,
          builder: (_,AsyncSnapshot<bool?> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasError) {
              return Center(
                child: Text("error:${snapshot.error.toString()}"),
              );
            }
            if(snapshot.data!){
              return QiblahCompass();
            }
            else{
              return Center(
                child: Text("your device is not supported "),
              );
            }
          }

      ),
    );
  }

}