import 'package:dio/dio.dart';
import 'api_service.dart';
import '../../models/urun.dart';

class UrunService {
  final Dio dio =  ApiService().dio;
  Future<List<Urun>> getAll() async {
    final response = await dio.get("/urun");
    return (response.data as List)
        .map(
          (e) => Urun.fromJson(e))
        .toList(); 
  }

  Future create( 
    Map<String,dynamic> data,
  ) async {
    final response =  await dio.post(
      "/urun",
      data: data,
    );
    return response.data;
  }
  Future update(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await dio.put(
      "/urun/$id",
      data: data,
    );
    return response.data;
  }
  Future delete (int id) async {
    await dio.delete("/urun/$id");
  }

}


