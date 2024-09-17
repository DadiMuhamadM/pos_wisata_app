import 'package:flutter/material.dart';
import 'package:pos_wisata_app/data/datasources/auth_remote_datasource.dart';
import 'package:pos_wisata_app/ui/auth/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wisata_app/ui/auth/bloc/logout/logout_bloc.dart';

import 'package:pos_wisata_app/ui/auth/splash_page.dart';

import 'data/datasources/product_remote_datasource.dart';
import 'ui/home/bloc/checkout/checkout_bloc.dart';
import 'ui/home/bloc/product/product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            ProductRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
