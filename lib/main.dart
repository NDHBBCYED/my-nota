import 'package:flutter/material.dart';
import 'package:my_notas/Pages/list_page.dart';
import 'package:my_notas/Pages/save_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE : (_) => ListPage(),
        SavePage.ROUTE : (_) => SavePage(false)
      },
    );
  }
}


  

