import 'package:flutter/material.dart';

import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/data/datasources/data_local_datasource.dart';
import 'package:pos_wisata_app/ui/auth/login_page.dart';
import 'package:pos_wisata_app/ui/home/pages/main_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 2),
          () => AuthLocalDataSource().isLogin(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const MainPage();
            } else {
              return LoginPage();
            }
          }
          return Padding(
            padding: const EdgeInsets.all(96.0),
            child: Center(
              child: Assets.images.logo.image(
                color: AppColors.primary,
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 100.0,
      //   child: Align(
      //     alignment: Alignment.center,
      //     child: Assets.images.logo.image(width: 96.0),
      //   ),
      // ),
    );
  }
}
