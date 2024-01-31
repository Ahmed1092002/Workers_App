import 'package:dio/dio.dart';




class DioHelper{

  static late Dio dio;


  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://fcm.googleapis.com/',
          receiveDataWhenStatusError: true,

        )

    );

  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String lang='en',
    String? token,
  })async{
    print (token);
    try{
      dio.options.headers = {
        'Authorization' : 'Bearer $token',
        'Content-Type': 'application/json',
        "Accept":"application/json"
      };
      return await dio.get(url,queryParameters: query,options:Options (
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,

      ));
    }catch(error){
      print(error.toString());
      rethrow;
    }
  }

  static Future<Response> postData({
     String? url,
    Map<String,dynamic>? query,
    dynamic data,
    String lang='en',
    String? token,
  })async{
    try{
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAA6KXkzOk:APA91bFrhdHAUE5mI-ruovQ5mTYxvnU2OTM0kO6j6LBgURiGALM9BakFgT_xrILDVlK9BMjaC3ZC3pwiO52wlMKzIERXYzP0t9zul3hljKVaNSVXZyJk9--vJ25EKUmvKVFj-ld8BYQC'
      };
      return   await dio.post(url!,queryParameters: query,data: data,options:Options (
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,

      ));
    }catch(error){
      print(error.toString());
      rethrow;
    }

  }

  static Future<Response> putData(
      {
        required String url,
        dynamic? data,
        Map<String, dynamic>? query,
        String? token,
      }
      ) async {
    try{
      dio.options.headers = {
        'Authorization' : 'Bearer $token',

      };
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    }catch(error){
      throw error;
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String,dynamic>? query,
    dynamic data,
    String lang='en',
    String? token,
  })async{
    try{
      dio.options.headers = {
        'Authorization' : 'Bearer $token',
      };
      return await dio.delete(url,queryParameters: query,data: data);
    }catch(error){
      print(error.toString());
      rethrow;
    }

  }

}