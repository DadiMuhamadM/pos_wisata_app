import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_wisata_app/core/assets/assets.gen.dart';
import 'package:pos_wisata_app/core/components/spaces.dart';
import 'package:pos_wisata_app/core/components/textfield_custom.dart';
import 'package:pos_wisata_app/core/constants/colors.dart';
import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/data/datasources/data_local_datasource.dart';
import 'package:pos_wisata_app/ui/auth/bloc/login/login_bloc.dart';

import '../home/pages/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 200.0,
              child: Center(
                child: Assets.images.logo
                    .image(height: 150.0, color: AppColors.white),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                  child: ColoredBox(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 44.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SpaceHeight(30.0),
                          TextFieldCustom(
                            controller: emailController,
                            label: 'Email',
                            icon: Icons.email,
                          ),
                          const SpaceHeight(30.0),
                          TextFieldCustom(
                            controller: passwordController,
                            label: 'Password',
                            icon: Icons.lock,
                            isOutlineBorder: false,
                            obscureText: true,
                          ),
                          const SpaceHeight(86.0),
                          BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                orElse: () {},
                                success: (data) async {
                                  // save auth data
                                  await AuthLocalDataSource()
                                      .saveAuthData(data);
                                  context.pushReplacement(MainPage());
                                },
                                error: (message) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                              );
                            },
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return state.maybeWhen(orElse: () {
                                  return Button.filled(
                                    onPressed: () {
                                      context.read<LoginBloc>().add(
                                            LoginEvent.login(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ),
                                          );
                                    },
                                    label: 'Login',
                                  );
                                }, loading: () {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                              },
                            ),
                          ),
                          const SpaceHeight(128.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
