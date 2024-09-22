import 'dart:convert';
import 'package:http/http.dart' as http;
import '../jsonFiles/Request/SignInRequest.dart';
import '../jsonFiles/Request/SignUpRequest.dart';
import '../jsonFiles/Response/GetAllCatResponse.dart';
import '../jsonFiles/Response/SignInResponse.dart';
import '../jsonFiles/Response/SignUpResponse.dart';
import '../jsonFiles/Response/addressResponse.dart';
import 'endPoint.dart';

class ApiManager {
  static Future<AddressResponse?> fetchUserAddress(String token) async {
    final url = Uri.parse(getAdd);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return AddressResponse.fromJson(json.decode(response.body));
      } else {
        print('Failed to load addresses: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error fetching addresses: $error');
      return null;
    }
  }
  // Sign Up Method
  static Future<SignUpResponse?> signUp(SignUpRequest signUpRequest) async {
    final url = Uri.parse(signUpUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(signUpRequest.toJson()),  // Use the request model to generate JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SignUpResponse.fromJson(json.decode(response.body));
      } else {
        print('Failed to sign up: ${response.statusCode} - ${response.body}');
        return SignUpResponse.fromJson(json.decode(response.body));  // Return the error response if available
      }
    } catch (error) {
      print('Error occurred during sign up: $error');
      return null;
    }
  }

  // Sign In Method
  static Future<SignInResponse?> signIn(SignInRequest signInRequest) async {
    final url = Uri.parse(loginUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(signInRequest.toJson()),  // Use the request model to generate JSON
      );

      if (response.statusCode == 200) {
        return SignInResponse.fromJson(json.decode(response.body));
      } else {
        print('Failed to sign in: ${response.statusCode} - ${response.body}');
        return SignInResponse.fromJson(json.decode(response.body));  // Return error message from API
      }
    } catch (error) {
      print('Error occurred during sign in: $error');
      return null;
    }
  }
  // Method to fetch all categories
  static Future<GetAllCatResponse?> getAllCategories() async {
    final url = Uri.parse(getCat); // Replace with your real API URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return GetAllCatResponse.fromJson(json.decode(response.body));
      } else {
        print('Failed to load categories: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error occurred while fetching categories: $error');
      return null;
    }
  }
}
