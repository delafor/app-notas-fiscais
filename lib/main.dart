import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:nfe/firebase_options.dart';
import 'package:nfe/pages/home/homePage.dart';
import 'package:nfe/pages/login/loginPage.dart';
import 'package:nfe/pages/login/passrecoveryPage.dart';
import 'package:nfe/pages/pages/sendNotas.dart';
import 'package:nfe/pages/register/registerPage.dart';
import 'package:nfe/pages/welcome/welcomePage.dart';
import 'package:nfe/theme.dart';

// -------------------- CONTROLE DO TEMA --------------------

class ThemeController extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  bool isDark = false;

  Future<void> loadTheme() async {
    String? saved = await storage.read(key: "themeMode");
    isDark = saved == "dark";
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDark = !isDark;
    await storage.write(key: "themeMode", value: isDark ? "dark" : "light");
    notifyListeners();
  }
}

// -------------------- MAIN --------------------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final controller = ThemeController();
  await controller.loadTheme();

  runApp(MyApp(controller: controller));
}

// -------------------- APP --------------------

class MyApp extends StatelessWidget {
  final ThemeController controller;
  MyApp({required this.controller});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meu App',

          theme: AppThemes.light(),
          darkTheme: AppThemes.dark(),
          themeMode: controller.isDark ? ThemeMode.dark : ThemeMode.light,

          routes: {
            '/login': (_) => Loginpage(db: db),
            '/register': (_) => RegisterPage(db: db),
            '/recover': (_) => PassRecovery(db: db),
          },

          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final userLogged = snapshot.hasData;

              return userLogged
                  ? SendNotas(
                      db: db,
                      alternarTema: controller.toggleTheme,
                      isDark: controller.isDark,
                    )
                  : Welcome(db: db, isDark: controller.isDark, alternarTema:controller.toggleTheme);
            },
          ),
        );
      },
    );
  }
}
