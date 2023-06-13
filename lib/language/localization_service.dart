import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'en_US.dart';
import 'hi_IN.dart';

class LocalizationService extends Translations{
  static final locale = Locale('en','US');
  static final fallBackLocale = Locale('en','US');

  static final language = ['English','Hindi'];
  static final locales  = [
    Locale('en','US'),
    Locale('hi','IN'),
  ];

  Map<String,Map<String,String>> get keys =>{
    'en_US':enUS,
    'hi_IN' :hiIN
  };

  void changeLocale(String lang){
    final locale = getLocaleFromLanguage(lang);
    final box= GetStorage();
    box.write('lng', lang);
    Get.updateLocale(locale!);
  }

  Locale? getLocaleFromLanguage(String lang){
    for(int i=0;i<language.length;i++){
      if(lang == language[i]) return locales[i];
    }
    return Get.locale;
  }

  Locale getCurrentLocale(){
    final box= GetStorage();
    Locale defaultLocale;

    if(box.read('lng') != null){
       final locale = getLocaleFromLanguage(box.read('lng'));
       defaultLocale = locale!;
    }else{
      defaultLocale = Locale('en','US');
    }

    return defaultLocale;
  }

  String getCurrentLang(){
    final box = GetStorage();

    return box.read('lng')!=null ? box.read('lng'): 'English';
  }



}