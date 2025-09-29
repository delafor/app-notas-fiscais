import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; // Importa o pacote de componentes visuais do Flutter.
import 'package:formulario/firebase_options.dart';
import 'package:formulario/homePage.dart';

import 'package:formulario/theme.dart';
import 'package:formulario/welcomePage.dart';
import 'package:validators/validators.dart' as validator;
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final db = FirebaseFirestore.instance;
  runApp(
    MyApp(db: db),
  ); // Fun o principal que executa o app, rodando o widget MyApp.
}

final colorScheme = MaterialTheme.lightScheme();

// Widget principal que inicializa o app.
class MyApp extends StatelessWidget {
  final FirebaseFirestore db;
  const MyApp({
    super.key,
    required this.db,
  }); // Construtor do widget, chave  nica.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Welcome(db: db),
      // Estrutura base do app, configura tema, t tulo e tela inicial.
      title: 'Flutter Demo', // T tulo do app.
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(),
          border: OutlineInputBorder(),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,

          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondary,
          ),
        ),

        // Tema global do app.
        useMaterial3: false,
        colorScheme: MaterialTheme.lightScheme(),

        // Define a paleta de cores.
      ),
      //home: Home(db:db), // const MyHomePage(title: 'Form'), // Tela inicial do app.
    );
  }
}

// Tela inicial do app, que  um widget com estado (pode mudar durante a execu o).
class MyHomePage extends StatefulWidget {
  final FirebaseFirestore db;
  const MyHomePage({
    super.key,
    required this.title,
    required this.db,
  }); // Construtor recebe o t tulo.

  final String title; // T tulo que aparece na barra superior.

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Cria o estado da p gina.
}

// Controlador do campo de texto (captura o que o usuario digita).
final controller = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  var password = "";
  var passwordCacheConfirm = "";
  final regexPhone = RegExp(r'^\(?\d{2}\)?[\s-]?\d{4,5}[-\s]?\d{4}$');
  bool obscuredTextPassword = false;
  bool obscuredTextPasswordConfirm = false;
  bool checkTerm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(241, 255, 255, 255),
      // Estrutura b sica com AppBar e corpo.
      appBar: AppBar(
        title: Text(
          widget.title,

          // style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 24,
          //   color: const Color.fromARGB(174, 101, 84, 84),
          // ),
          // style: TextStyle(
          //   fontSize: 20,
          //   color: const Color.fromARGB(183, 121, 102, 102),
          //   //backgroundColor: const Color.fromARGB(183, 121, 102, 102),
          //   fontWeight: FontWeight.bold,
          // ),
        ),

        // Barra superior.
        //title: Text(widget.title), // Mostra o t tulo passado na cria o.
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //valida os campos para saber se esta digitado ou prenchido da forma certa,em tempo real,so dispara com o inetracao do usuario
          key: formKey,

          child: Padding(
            // Espa amento interno na tela.
            padding: EdgeInsets.all(20), // Padding de 20 em todos os lados.
            //child: SingleChildScrollView(
            // pra q serve?? o singlle
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              // Coluna para empilhar widgets verticalmente.
              children: [
                Icon(Icons.person, size: 100, color: colorScheme.primary),
                Text(
                  'Register Account',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  /* style: TextStyle(
                      color: const Color.fromARGB(183, 121, 102, 102),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),*/
                ),

                CustomTextField(
                  label: "Full Name",
                  icon: Icons.person,
                  hint: "Your name",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSaved: (text) => user = user.copyWith(
                    name: text,
                  ), // parei aqui copiar pro email parei 1:14:31
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo n o pode ser vazio';
                    }
                    if (text.length < 5) {
                      return "O nome deve ter pelo menos 5 letras. (has ${text.length})";
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Email",
                  icon: Icons.mail,
                  hint: "Your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSaved: (text) => user = user.copyWith(email: text),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo n o pode ser vazio';
                    }
                    if (!validator.isEmail(text)) {
                      return "Valor deve ser do tipo email ";
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Phone",
                  icon: Icons.phone,
                  hint: "Your Phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSaved: (text) => user = user.copyWith(phone: text),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Este campo n o pode ser vazio";
                    }
                    if (!regexPhone.hasMatch(text)) {
                      return "Valor deve ser do tipo telefone";
                    }
                    return null;
                  },
                ),

                CustomTextField(
                  label: "Password",
                  icon: Icons.password,
                  hint: "Your Password",
                  obscureText: obscuredTextPassword,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscuredTextPassword =
                            !obscuredTextPassword; //// Inverte o valor da variável 'obscuredTextPassword'. Se estava true (senha escondida), vira false (senha visível).// Se estava false (senha visível), vira true (senha escondida).
                      });
                    },
                    icon: Icon(
                      obscuredTextPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  onSaved: (text) => user = user.copyWith(password: text),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Este campo n o pode ser vazio";
                    }
                    return null;
                  },
                  onChanged: (text) => password = text,
                ),
                CustomTextField(
                  label: "Confirm Password",
                  icon: Icons.lock,
                  hint: "Confirm your Password",
                  obscureText: obscuredTextPasswordConfirm,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscuredTextPasswordConfirm =
                            !obscuredTextPasswordConfirm; //// Inverte o valor da variável 'obscuredTextPassword'. Se estava true (senha escondida), vira false (senha visível).// Se estava false (senha visível), vira true (senha escondida).
                      });
                    },
                    icon: Icon(
                      obscuredTextPasswordConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  onSaved: (text) => user = user.copyWith(password: text),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Este campo n o pode ser vazio";
                    }
                    if (passwordCacheConfirm != password) {
                      return "Passwords does not match";
                    }
                    return null;
                  },
                  onChanged: (text) => passwordCacheConfirm = text,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: colorScheme.primary,
                      value: checkTerm,
                      onChanged: (v) {
                        setState(() {
                          checkTerm = v!;
                        });
                      },
                    ),
                    Text("Aceito os termos de uso"),
                  ],
                ),
                SizedBox(
                  width: 250,
                  height: 35,
                  child: ElevatedButton.icon(
                    onPressed: !checkTerm
                        ? null
                        : () async {
                            // final storage = FlutterSecureStorage();
                            // storage.write(key: 'auth_token', value:  );

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print('''FLUTTERANDO FORM
                              '\nTelefone: ${user.phone}'
                              '\nNome: ${user.name}'
                              '\nEmail: ${user.email}'
                              '\nSenha: ${user.password}'
                            ''');
                              try {
                                // Criar usuário no Firebase Auth
                                UserCredential cred = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                      email: user.email.trim(),
                                      password: user.password.trim(),
                                    );

                                String uid = cred.user!.uid;

                                // Salvar dados no Firestore
                                await FirebaseFirestore.instance
                                    .collection('Usuarios')
                                    .doc(uid)
                                    .set({
                                      "Nome": user.name,
                                      "Telefone": user.phone,
                                      "Email": user.email,
                                      "Senha": user.password,
                                    });

                                // Limpar formulário e resetar checkbox
                                formKey.currentState?.reset();
                                setState(() => checkTerm = false);

                                // Mostrar mensagem de sucesso
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                      'Usuário cadastrado com sucesso!',
                                    ),
                                  ),
                                );

                                // Navegar para Home após fechar diálogo
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(db: widget.db),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                String message;
                                if (e.code == 'email-already-in-use') {
                                  message = 'Email já cadastrado';
                                } else if (e.code == 'weak-password') {
                                  message =
                                      'Senha muito fraca (mínimo 6 caracteres)';
                                } else if (e.code == 'invalid-email') {
                                  message = 'Email inválido';
                                } else {
                                  message = 'Erro: ${e.message}';
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(content: Text(message)),
                                );
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('Erro inesperado: $e'),
                                  ),
                                );
                              }
                            }
                          },
                    icon: Icon(Icons.save), // icon: Icons(Icons.save),
                    label: Text('Register'),
                  ),
                ),
                // SizedBox(
                //   width: 250,
                //   height: 30,
                //   child: ElevatedButton.icon(
                //     //style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                //     onPressed: () {
                //       Navigator.pop(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Welcome(db: widget.db),
                //         ),
                //       );
                //     },
                //     icon: Icon(Icons.restore_page), // icon: Icons(Icons.save),
                //     label: Text('Voltar'),
                //   ),
                // ),
              ],
            ),
            //),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final InputBorder? border;
  final String label;
  final IconData? icon;
  final String? hint;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;
  final bool obscureText;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.icon,
    this.hint,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.suffix,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = border ?? OutlineInputBorder();
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText,

      decoration: InputDecoration(
        labelText: label,
        border: inputBorder,
        hintText: hint,
        // border: OutlineInputBorder(),
        prefixIcon: icon == null ? null : Icon(icon),
        suffixIcon: suffix,
      ),
    );
  }
}

class UserModel {
  final String phone;
  final String
  name; //caso eu queira q seja opicional usar o "?" caso eu queira q seja passados obrigatoriamente usar o "required"
  final String email;
  final String password;

  const UserModel({
    //permite criar um usuario ex "UserModel user = UserModel(name: "Lucas", email: "lucas@gmail.com");
    this.phone = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  UserModel copyWith({
    // O copyWith é um método que serve para criar uma nova cópia de um objeto, alterando apenas os valores que você quiser e mantendo os outros iguais. UserModel updatedUser = user.copyWith(name: "Carlos");
    String? phone,
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone:
          phone ??
          this.phone, // Se name tiver valor, usa o valor novo. Se name for null, mantém o valor antigo (this.name).
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
