import 'package:cat_app/Controller/cats_provider.dart';
import 'package:cat_app/View/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CatsProvider>(
          create: (context) => CatsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cats App',
        theme: ThemeData(
        
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
