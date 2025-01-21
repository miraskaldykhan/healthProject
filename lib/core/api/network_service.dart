import 'package:dio/dio.dart';
import 'package:testprojectforhealth/core/models/health_data.dart';

class NetworkService {
  final Dio _dio = Dio();

  Future<HealthData> getData() async {
    try {
      final res = await _dio.get("http://158.160.30.46:8080/health_mock");
      return HealthData.fromJson(res.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
