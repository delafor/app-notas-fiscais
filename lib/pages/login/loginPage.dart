// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nfe/pages/home/homePage.dart';
import 'package:nfe/pages/login/passrecoveryPage.dart';
import 'package:nfe/pages/pages/sendNotas.dart';
import 'package:nfe/pages/register/registerPage.dart';
import 'package:nfe/pages/welcome/welcomePage.dart';
import 'package:validators/validators.dart' as validator;
import 'package:firebase_auth/firebase_auth.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key, required this.db});
  final FirebaseFirestore db;

  @override
  State<Loginpage> createState() => LoginpageState();
}

class LoginpageState extends State<Loginpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController(
    text: kDebugMode
        ? 'note@gmail.com'
        : '', // caso eu queira fica usando login de teste
  );
  final passwordController = TextEditingController(
    text: kDebugMode
        ? '123456'
        : '', // caso eu queira fica usando login de teste
  );
  final _formKey = GlobalKey<FormState>();

  void entrar(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SendNotas(db: widget.db, isDark: false, alternarTema: () {}),
      ),
    );
  }

  bool obscuredTextPassword = true;
  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true, // necessario pra capturar os eventos de clicks de teclas
      child: Shortcuts(
        shortcuts: {LogicalKeySet(LogicalKeyboardKey.enter): ActivateIntent()},

        child: Actions(
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) => entrar(context),
            ),
          },

          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 238, 237, 237),
              elevation: 4,
              shadowColor: Colors.black,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),

                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Welcome(
                        db: widget.db,
                        isDark: false,
                        alternarTema: () {},
                      ),
                    ),
                  );
                },
              ),

              title: Text('Welcome'),
            ),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            body: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode
                  .onUserInteraction, //valida os campos para saber se esta digitado ou prenchido da forma certa,em tempo real,so dispara com o inetracao do usuario
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          size: 100,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          'Login Account',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            hint: Text('Your Email'),
                            prefixIcon: Icon(Icons.email),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onPrimary,
                                width: 2,
                              ),
                            ),
                          ),

                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Email is required';
                            }
                            if (!validator.isEmail(text)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: passwordController,
                          obscureText: obscuredTextPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  obscuredTextPassword = !obscuredTextPassword;
                                });
                              },
                              child: Icon(
                                obscuredTextPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 22,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onPrimary,
                                width: 2,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        TextButton(
                          style: TextButton.styleFrom(
                            shadowColor: Colors.black,
                            minimumSize: Size(150, 45),
                            elevation: 3,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              try {
                                // Tenta fazer login com FirebaseAuth
                                UserCredential userCredential = await _auth
                                    .signInWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );

                                final storage = FlutterSecureStorage();
                                await storage.write(
                                  key: 'auth_token',
                                  value: userCredential.user!.uid,
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SendNotas(
                                      db: widget.db,
                                      isDark: false,
                                      alternarTema: () {},
                                    ),
                                  ),
                                );

                                // Login bem-sucedido, navega para Home

                                // Navigator.push(
                                //   // ignore: use_build_context_synchronously
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Home(db: widget.db),
                                //   ),

                                // );
                              } on FirebaseAuthException catch (e) {
                                // Define a mensagem de erro de acordo com o código
                                String message;
                                if (e.code == 'user-not-found') {
                                  message = 'Usuário não encontrado';
                                } else if (e.code == 'wrong-password') {
                                  message = 'Senha incorreta';
                                } else {
                                  message = 'Erro: ${e.message}';
                                }

                                // Mostra alerta
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(content: Text(message)),
                                );

                                // Limpa campos do formulário
                                _formKey.currentState?.reset();
                                emailController.clear();
                                passwordController.clear();
                              }
                            }
                          },
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),

                        SizedBox(height: 12),

                        TextButton(
                          style: TextButton.styleFrom(
                            shadowColor: Colors.black,
                            minimumSize: Size(180, 45),
                            elevation: 3,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PassRecovery(db: widget.db),
                              ),
                            );
                          },
                          child: Text(
                            "Esqueceu a senha?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomForm extends FormState {
  late final String email;
  late final String password;
  late final bool obscureText;
}
