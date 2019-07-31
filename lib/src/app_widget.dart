import 'package:flutter/material.dart';
import 'package:cubos_movie_flutter/src/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '[CUBOS] Mobile Developer (Flutter)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomeModule(),
    );
  }
}
