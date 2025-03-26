import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../../features/presentation/modules/auth/login/login_controller.dart';

class ApiService {
  final String baseUrl = "https://learn2aid.firebaseapp.com/api/v1";
  final LoginController loginController = Get.find<LoginController>();

  Future<dynamic> getRequest(String endpoint) async {
    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: await _getHeaders(),
    );
    return _handleResponse(response);
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: await _getHeaders(),
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = loginController.authToken.value;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      loginController.logout();
      throw Exception("Unauthorized: Token expired");
    } else {
      throw Exception("Error: ${response.body}");
    }
  }
}