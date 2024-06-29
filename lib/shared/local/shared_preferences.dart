import 'package:shared_preferences/shared_preferences.dart';
class SharedPref{
  static SharedPreferences? sharedPreferences;

  static initSharedPref()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static Future<bool> saveIntoSharedPref(String key,dynamic value)async{
    if(value is String){return await sharedPreferences!.setString(key, value);}
    if(value is int){return await sharedPreferences!.setInt(key, value);}
    if(value is double){return await sharedPreferences!.setDouble(key, value);}
    else{return await sharedPreferences!.setBool(key, value);}
  }
  static Future<bool> deleteFromSharedPref(String key)async{
    return await sharedPreferences!.remove(key);
  }
  static dynamic getFromSharedPref(String key){
    return  sharedPreferences?.get(key) ?? -1;
  }

}