import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_wisata_app/core/constants/variables.dart';
import 'package:pos_wisata_app/data/models/request/login_request_model.dart';
import 'package:pos_wisata_app/data/models/response/auth_response_model.dart';
import 'package:pos_wisata_app/data/datasources/data_local_datasource.dart';

class AuthRemoteDatasource {
  // 192.168.0.104

  // login
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel data,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right('Logout Success');
    } else {
      return Left(response.body);
    }
  }
}
