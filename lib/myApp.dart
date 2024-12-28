import 'package:flutter/material.dart';
import 'package:test_project/pages/classification/classification.dart';
import 'package:test_project/pages/home/MyHomePage.dart';
import 'package:test_project/pages/login/signIn.dart';
import 'package:test_project/pages/register/registerForm.dart';

import 'package:test_project/pages/models/vocalAssistant.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register':(context)=>SignupPage(),
        '/':(context)=>LoginPage(),
        '/home':(context)=>MyHomePage(title: "home"),
        '/vocal':(context)=>VocalAssistant(),
        '/cnn': (context) => ImageClassificationPage()
       

      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  RegisterForm(),
    );
  }
}