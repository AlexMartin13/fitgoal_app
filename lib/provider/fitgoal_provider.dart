import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fitgoal_app/app_config.dart';
import 'package:fitgoal_app/helpers/debouncer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FitGoalProvider extends ChangeNotifier {
  static String _baseUrl = AppConfig.BaseApiUrl;
  String _language = 'es-ES';
  static String apiKey = '';

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  static Future<String> postJsonData(
    String endpoint,
    Map<String, dynamic> data
  ) async {
      final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': apiKey,
    };
    String jsonData = json.encode(data);

      final response = await http.post( url, headers: headers, body: jsonData);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }

  }

  static Future<String> getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': apiKey,
    };
    final response = await http.get(url, headers: headers);
    return response.body;
  }

  static Future<String> putJsonData(
      String endpoint, Map<String, dynamic> data) async {
    String end = endpoint;
    final url = Uri.http(_baseUrl, end);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': apiKey,
    };

    String jsonData = json.encode(data);

    try {
      final response = await http.put(url, headers: headers, body: jsonData);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error durante la solicitud: $error');
    }
  }

  static Future<String> deleteJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': apiKey,
    };

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 204) {
        return response.body;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      if (error is SocketException) {
      } else if (error is http.ClientException) {
      } else {
      }
      throw Exception('Error durante la solicitud: $error');
    }
  }

  static Future<String> deleteJsonDataWithBody(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': apiKey,
    };

    String jsonData = json.encode(data);

    try {
      final response = await http.delete(url, headers: headers, body: jsonData);

      if (response.statusCode == 204) {
        return response.body;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error durante la solicitud: $error');
    }
  }
}
