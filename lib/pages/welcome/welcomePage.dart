import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nfe/pages/home/homePage.dart';
import 'package:nfe/pages/login/loginPage.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:nfe/pages/pages/sendNotas.dart';
import 'package:nfe/pages/register/registerPage.dart';

class Welcome extends StatefulWidget {
  final FirebaseFirestore db;
  final bool isDark;
  final VoidCallback alternarTema;

  const Welcome({
    super.key,
    required this.db,
    required this.isDark,
    required this.alternarTema,
  });

  @override
  State<Welcome> createState() => WelcomepageState();
}

class WelcomepageState extends State<Welcome> {
  final formkey = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

  Future<UserCredential?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login cancelado pelo usuário')),
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível obter token do Google'),
          ),
        );
        return null;
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logado como: ${userCredential.user?.email}')),
      );

      return userCredential;
    } on FirebaseAuthException catch (authError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('FirebaseAuth error: ${authError.code}')),
      );
      debugPrint(
        'FirebaseAuthException: ${authError.code} - ${authError.message}',
      );
      return null;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro no login: $e')));
      debugPrint('Erro no _handleSignIn: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formkey,
        child: Column(
          children: [
            Image.asset('assets/NotaEscudo.png', width: 200, height: 200),
            Text(
              "Gestor de Garantias\n    e Notas Fiscais",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Theme.of(context).colorScheme.scrim,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "It's easier to sign up now",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color.fromARGB(168, 0, 0, 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(345, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color.fromARGB(201, 0, 0, 0),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(db: widget.db),
                    ),
                  );
                },
                child: Text(
                  "Register using email",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    try {
                      final userCredential = await _handleSignIn();
                      if (userCredential != null) {
                        final storage = FlutterSecureStorage();
                        await storage.write(
                          key: 'auth_token',
                          value: userCredential.user?.uid,
                        );
                        debugPrint(
                          "Usuário logado com sucesso: ${userCredential.user?.email}",
                        );

                        final saveToken = await storage.read(key: 'auth_token');

                        final currentUser = FirebaseAuth.instance.currentUser;

                        if (saveToken != null && currentUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SendNotas(
                                db: widget.db,
                                isDark: false,
                                alternarTema: () {},
                              ),
                            ),
                          );
                        }
                      } else {
                        debugPrint("Usuário não logado");
                      }
                    } catch (e) {
                      debugPrint("Erro: $e");
                    }
                  },
                  icon: Image.asset('assets/Google.png', width: 40, height: 40),
                  label: Text(
                    'Entrar com Google',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(flex: 3),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginpage(db: widget.db),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      height: 10,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: TextButton(
                      onPressed: () async {},
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
