import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfe/pages/login/loginPage.dart';

class PassRecovery extends StatefulWidget {
  final FirebaseFirestore db;

  const PassRecovery({super.key, required this.db});

  @override
  State<PassRecovery> createState() => _PassRecoveryState();
}

class _PassRecoveryState extends State<PassRecovery> {
  final _formKey = GlobalKey<FormState>();
  // Criando o controller
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // Sempre liberar o controller para evitar vazamentos de memória
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.setLanguageCode('pt_BR');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => Loginpage(db: widget.db)),
            );
          },
        ),
        title: Text('Voltar'),
      ),*/
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 140,
                left: 30,

                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: const Color.fromARGB(181, 0, 0, 0),
                      ),
                      Text(
                        'Voltar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(181, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 190, left: 50, right: 50),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 25),
                    Text(
                      'Redefinição de\nsenha!',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                        //height: ,
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      'Informe um email e enviaremos um link\npara recuperação da sua senha.',
                      style: TextStyle(
                        color: const Color.fromARGB(170, 0, 0, 0),
                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                        //height: ,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        width: 410,
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(vertical: 20),
                            labelText: 'Email',
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            hintText: 'Insira seu email',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira um email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 40),

                    SizedBox(
                      width: 410,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // final user = _controller.text.trim();
                          try {
                            // if (user == null) {
                            //   print('Nenhum usuário logado');
                            //   return;
                            // }
                            final email = _controller.text.trim();
                            if (_formKey.currentState?.validate() ?? false) {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Loginpage(db: widget.db),
                                ),
                              );
                            }
                          } catch (e, stackTrace) {
                            print('Errr: $e');
                            print('Detalhes:$stackTrace');
                          }
                        },
                        label: Text(
                          'Enviar link de recuperação',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.black,

                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    //),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
