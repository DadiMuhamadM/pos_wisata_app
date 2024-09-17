import 'package:flutter/material.dart';
import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/data/datasources/data_local_datasource.dart';
import 'package:pos_wisata_app/ui/auth/splash_page.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthLocalDataSource().removeAuthData();
            context.pushReplacement(const SplashScreen());
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
