import 'package:dartz/dartz.dart';
import 'package:pos_wisata_app/core/constants/variables.dart';
import 'package:pos_wisata_app/data/datasources/data_local_datasource.dart';
import 'package:pos_wisata_app/data/datasources/product_remote_datasource.dart';
import 'package:pos_wisata_app/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProduct() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/api-products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}'
      },
    );
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
