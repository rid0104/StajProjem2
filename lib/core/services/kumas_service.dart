import 'package:dio/dio.dart';
import '../../models/kumas.dart';
import 'api_service.dart';

class KumasService {
  final Dio dio = ApiService().dio;
  Future<List<Kumas>> getAll() async {
    final response = await dio.get("/kumas");

    return (response.data as List)
         .map((e) => Kumas.fromJson(e))
         .toList();
  }
  Future<dynamic> create(
    Map<String, dynamic> data,
  ) async {
    final response = await dio.post(
      "/kumas",
      data: data,
    );
    return response.data;

  }
   Future update(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await dio.put(
      "/kumas/$id",
      data: data,
    );
    return response.data;
  }
  Future delete (int id) async {
    await dio.delete("/kumas/$id");
  }

}
