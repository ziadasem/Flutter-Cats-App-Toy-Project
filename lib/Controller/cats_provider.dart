import 'dart:developer';

import 'package:cat_app/Model/cat_model.dart';
import 'package:cat_app/Model/services/api_services.dart';
import 'package:flutter/material.dart';


class CatsProvider with ChangeNotifier {

  List<CatModel> _cats = [];
  List<CatModel> get cats => _cats ;
  final APIService _apiService =  APIService() ;

  bool _isLoading = false ;
  bool get isLoading => _isLoading ;


  Future loadCats({bool forceRefresh = false}) async{
    if (_cats.isNotEmpty && !forceRefresh ){
      //don't load loaded cats and save data
      return ;
    }
   
    try{
      _isLoading = true ;
      notifyListeners() ;

     _cats = await _apiService.getCats();
    
    }catch(e){
      log(e.toString());
      rethrow ;
    }finally{
      _isLoading = false ;
      notifyListeners() ;
    }
   
  }

 


}

