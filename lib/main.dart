import 'package:flutter/material.dart';
import 'package:pos_wisata_app/data/datasources/auth_remote_datasource.dart';
import 'package:pos_wisata_app/ui/auth/bloc/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pos_wisata_app/ui/auth/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        AuthRemoteDatasource(),
      ),
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
