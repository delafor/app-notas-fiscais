import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formulario/homePage.dart';
import 'package:formulario/loginPage.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:formulario/registerPage.dart';

// Import necessário para Twitter login no mobile
//import 'package:twitter_login/twitter_login.dart';

class Welcome extends StatefulWidget {
  final FirebaseFirestore db;
  const Welcome({super.key, required this.db});

  @override
  State<Welcome> createState() => WelcomepageState();
}

class WelcomepageState extends State<Welcome> {
  final formkey = GlobalKey<FormState>();

  // instância do GoogleSignIn (sem construtor "anônimo")
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

  // Função corrigida e robusta do login Google (só idToken, sem accessToken)
  Future<UserCredential?> _handleSignIn() async {
    try {
      // 1) Abre a tela de seleção de conta Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // usuário cancelou
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login cancelado pelo usuário')),
        );
        return null;
      }

      // 2) Pega tokens
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

      // 3) Cria credencial Firebase com idToken (sem accessToken)
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      // 4) Faz sign-in no Firebase
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
    //final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      // appBar: AppBar(backgroundColor: const Color.fromARGB(240, 255, 255, 255)),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formkey,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/NotaEscudo.png',
                      width: 200,
                      height: 200,
                    ),
                    Text(
                      "Gestor de Garantias\n    e Notas Fiscais",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    // Text(
                    //   "APPSTA",
                    //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    //     letterSpacing: 5,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 24,
                    //     color: Theme.of(context).colorScheme.primary,
                    //   ),
                    // ),
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
                              builder: (context) =>
                                  MyHomePage(db: widget.db, title: 'Form'),
                            ),
                          );
                        },
                        child: Text(
                          "Register using email",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 17,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextButton.icon(
                        //   onPressed: () {},

                        //   icon: Image.asset(
                        //     'assets/X.png',
                        //     width: 50,
                        //     height: 50,
                        //   ),
                        //   label: const Text(''),
                        // ),
                        // const SizedBox(width: 25),
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

                                final saveToken = await storage.read(
                                  key: 'auth_token',
                                );

                                final currentUser =
                                    FirebaseAuth.instance.currentUser;

                                if (saveToken != null && currentUser != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(
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
                          icon: Image.asset(
                            'assets/Google.png',
                            width: 50,
                            height: 50,
                          ),
                          label: const Text('Entrar com Google'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  height: 10,
                                  color: Theme.of(context).colorScheme.scrim,
                                ),
                          ),
                          TextButton(
                            onPressed: () async {
                              // final storage = FlutterSecureStorage();
                              // final savedToken = await storage.read(
                              //   key: 'auth_token',
                              // );

                              // final currentUser =
                              //     FirebaseAuth.instance.currentUser;

                              // if (savedToken != null && currentUser != null) {
                              //   if (savedToken == currentUser.uid) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Loginpage(db: widget.db),
                                ),
                              );
                              //   } else {
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //         content: Text(
                              //           'Token inválido, faça login novamente',
                              //         ),
                              //       ),
                              //     );
                              //   }
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text('Nenhum usuário encontrado'),
                              //     ),
                              //   );
                              // }
                            },
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
