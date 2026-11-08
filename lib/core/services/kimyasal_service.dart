import 'package:dio/dio.dart';
import '../../models/kimyasal.dart';
import 'api_service.dart';

class KimyasalService {
  final Dio dio = ApiService().dio;
  Future<List<Kimyasal>> getAll() async {
    final response = await dio.get("/kimyasal");

    return (response.data as List)
         .map((e) => Kimyasal.fromJson(e))
         .toList();
  }
  Future<dynamic> create(
    Map<String, dynamic> data,
  ) async {
    final response = await dio.post(
      "/kimyasal",
      data: data,
    );
    return response.data;

  }
   Future update(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await dio.put(
      "/kimyasal/$id",
      data: data,
    );
    return response.data;
  }
  Future delete (int id) async {
    await dio.delete("/kimyasal/$id");
  }

}
