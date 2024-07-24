import 'dart:convert';
import 'dart:developer';

import 'package:cat_app/App_Const/config.dart';
import 'package:cat_app/Model/cat_model.dart';
import 'package:cat_app/Model/server_exception.dart';

import 'package:http/http.dart' as http;


class APIService {

  //RESTful API get method for getting cats with input query paratmeters are set to defualt value and, handling corrupted cat's data
  //Inputs: optional parameters
  //Output: List of CatModel objects
  //throw: Exception and Server Error ;
  Future<List<CatModel>> getCats(
      {int limit = 80 , String order = "Random",
      int pageNum = 3,  String size = "size"}
    ) async{
    try{
      List<CatModel> models = [];
      List data = await _getRequest(query: "limit=$limit&mime_types=&order=$order&size=$size&page=$pageNum&sub_id=demo-ce06ee") ;
      log(data.toString());
      //add non nullable elements 
      for (var element in data) {
        CatModel model = CatModel.fromJson(element);
        if (model.isAllMembersAreNotNull()){
            models.add(model);
        }
      }
      return models;   
    }catch(e){ //exception from the application
      rethrow ;
    }
  }


  //general get request method with error handling to avoid duplication and heterogeneity
  //Inputs: query paramters
  //Output: dynamic
  //throws: Exception and ServerException
  Future _getRequest({ String query = "",}) async{
    try{
       Uri uri = Uri.parse('${AppConfig.baseUrl}?$query');    
       final response = await http.get(
        uri,
        headers: {
            "Content-Type": "application/json",
          },  
        );
   
        if (response.statusCode >= 400){
          throw ServerException("Server is down", additonalLogInfo:  "status code is ${response.statusCode}");
        }
        if (response.body.isEmpty){
          throw ServerException("No Content",);
        }
        return  jsonDecode(response.body);
    }catch(e){ //exception from the application
      log(e.toString());
      rethrow ;
    }
  }
}