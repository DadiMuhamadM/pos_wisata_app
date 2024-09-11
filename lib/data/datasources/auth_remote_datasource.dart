import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_wisata_app/core/constants/variables.dart';
import 'package:pos_wisata_app/data/models/request/login_request_model.dart';
import 'package:pos_wisata_app/data/models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  // 192.168.0.104

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
}
