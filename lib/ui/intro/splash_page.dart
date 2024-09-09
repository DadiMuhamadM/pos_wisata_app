import 'package:flutter/material.dart';

import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/ui/intro/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () => context.pushReplacement(
        const LoginPage(),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(
          child: Assets.images.logo.image(
            color: AppColors.primary,
          ),
        ),
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
