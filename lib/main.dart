import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/firebase_options.dart';
import 'package:formulario/homePage.dart';
import 'package:formulario/welcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

//import 'package:window_manager/window_manager.dart';

void main() async {
  await initializeDateFormatting('pt_BR', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // se estiver usando flutterfire CLI
  );
  final storage = FlutterSecureStorage();

  String? token = await storage.read(key: 'auth_token');

  runApp((MyApp(initialToken: token)));
}

class MyApp extends StatefulWidget {
  final String? initialToken;
  MyApp({Key? key, this.initialToken}) : super(key: key);


  // void alternarTema() {
  //   setState(() {
  //   isDark = !isDark;
  //   });
  @override
  State<MyApp> createState() => _MyAppState();
}
  // }
class _MyAppState extends State<MyApp> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool isDark = false;

  
  void alternarTema() {
    setState(() {
    isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.light),
      theme:  isDark ? ThemeData.dark() : ThemeData.light(),

      // define o tema do app aqui esqueci de fazer
      title: 'Meu App',
      // home: Welcome(db: FirebaseFirestore.instance),
      home: widget.initialToken == null 
      ? Welcome(db: db) 
      : Home(db: db, alternarTema: alternarTema,isDark: isDark), //initialToken == null ? Welcome(db: db) : Home(db: db),
      // aqui você usa seu widget Home como a tela inicial
    );
  }
}
