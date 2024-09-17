import 'package:pos_wisata_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Buat local storage untuk menyimpan token jwt
class AuthLocalDataSource {
  // Buat unruk menyimpan token auth
  Future<void> saveAuthData(AuthResponseModel data) async {
    // panggil share freference nya
    final pref = await SharedPreferences.getInstance();
    // simpan data nya dengan key 'auth_data' dengan value 'data.toJson()'
    await pref.setString('auth_data', data.toJson());
  }

  // Remove data auth ketika logout
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  // Ambil data auth setelah login
  Future<AuthResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      return AuthResponseModel.fromJson(data);
    } else {
      throw Exception('Data auth not found');
    }
  }

  // Cek apakah user sudah login
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('auth_data');
  }
}
