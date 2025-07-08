import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isAuthenticated = false.obs;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('uri'),
      headers: {},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      isAuthenticated.value = true;

      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar('Error', 'Error al iniciar sesión');
    }
  }

  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('uri'),
      headers: {},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      isAuthenticated.value = true;
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar('Error', 'Error al registrarse');
    }
  }

  Future<void> logout() async {
    isAuthenticated.value = false;
    Get.offAllNamed('/login');
  }

  Future<void> checkAuthStatus() async {
    if (isAuthenticated.value) {
      Get.offAllNamed('/dashboard');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
