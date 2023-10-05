import 'package:flutter/material.dart';
import 'package:story_app/domain/entities/auth/login/login_request/login_request.dart';
import 'package:story_app/domain/entities/auth/login/login_response/login_response.dart';
import 'package:story_app/domain/entities/auth/register/register_request/register_request.dart';
import 'package:story_app/domain/entities/auth/register/register_response/register_response.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponse> doRegister(RegisterRequest register);
  Future<LoginResponse> doLogin(LoginRequest login);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1/";
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});
  @override
  Future<RegisterResponse> doRegister(RegisterRequest register) async {
    try {
      debugPrint("nyoba $register");
      final response =
          await dio.post(("${_baseUrl}register"), data: register.toJson());
      if (response.statusCode == 200) {
        final responseData = RegisterResponse.fromJson(response.data);
        debugPrint("hai $responseData");
        return responseData;
      } else {
        final err = RegisterResponse.fromJson(response.data);
        throw Exception("${err.message}");
      }
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }

  @override
  Future<LoginResponse> doLogin(LoginRequest login) async {
    try {
      debugPrint("seblak $login");
      final response =
          await dio.post(("${_baseUrl}login"), data: login.toJson());
      debugPrint("hayoo$response");
      if (response.statusCode == 200) {
        final responseData = LoginResponse.fromJson(response.data);
        debugPrint("haiua $responseData");
        return responseData;
      } else {
        final err = LoginResponse.fromJson(response.data);
        throw Exception("${err.message}");
      }
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }
}
