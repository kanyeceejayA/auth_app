import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _storage = FlutterSecureStorage();
  // var baseUrl = 'http://10.0.2.2/server/';
  var baseUrl = 'http://fido.silbaka.com/';

  Future<String?> read({required String key}) async{
    try{
      baseUrl = (await _storage.read(key:'baseUrl'))?? 'fido.silbaka.com';
      final response = await http.get(Uri.parse(baseUrl+'read.php?key='+key));
      if(response.statusCode != 200) return null;
      var data = response.body;
      String? result = data;
      return result;
    }catch(e){
      return null;
    }
  }

  Future<String?> write({required String key,required String value}) async{
    try{
      baseUrl = (await _storage.read(key:'baseUrl'))?? 'fido.silbaka.com';
      final response = await http.get(Uri.parse(baseUrl+'write.php?key='+key+'&d='+value));
      if(response.statusCode != 200) return null;
      var data = response.body;
      String? result = data;
      return result;
    }catch(e){
      return null;
    }
  }

  Future<String?> delete({required String key}) async{
    try{
      baseUrl = (await _storage.read(key:'baseUrl'))?? 'fido.silbaka.com';
      final response = await http.get(Uri.parse(baseUrl+'del.php?key='+key));
      if(response.statusCode != 200) return null;
      var data = response.body;
      String? result = data;
      return result;
    }catch(e){
      return null;
    }
  }
}