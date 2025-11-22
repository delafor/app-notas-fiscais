import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nfe/firebase_options.dart';
import 'package:nfe/pages/pages/sendNotas.dart';
import 'package:nfe/pages/welcome/welcomePage.dart';
import 'package:nfe/theme.dart';
import 'package:validators/validators.dart' as validator;
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final db = FirebaseFirestore.instance;
  runApp(MyApp(db: db));
}

class MyApp extends StatefulWidget {
  final FirebaseFirestore db;
  const MyApp({super.key, required this.db});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void alternarTema() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Welcome(db: widget.db, isDark: isDark, alternarTema: alternarTema),
    );
  }
}

// ===================== REGISTER PAGE =====================
class RegisterPage extends StatefulWidget {
  final FirebaseFirestore db;
  const RegisterPage({super.key, required this.db});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  String password = "";
  String passwordCacheConfirm = "";
  final regexPhone = RegExp(r'^\(?\d{2}\)?[\s-]?\d{4,5}[-\s]?\d{4}$');
  bool obscuredTextPassword = true;
  bool obscuredTextPasswordConfirm = true;
  bool checkTerm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Register Account')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "Full Name",
                  icon: Icons.person,
                  hint: "Your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSaved: (text) => user = user.copyWith(name: text),
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return 'Este campo não pode ser vazio';
                    if (text.length < 5)
                      return 'O nome deve ter pelo menos 5 letras';
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  label: "Email",
                  icon: Icons.mail,
                  hint: "Your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSaved: (text) => user = user.copyWith(email: text),
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return 'Este campo não pode ser vazio';
                    if (!validator.isEmail(text))
                      return 'Valor deve ser do tipo email';
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  label: "Phone",
                  icon: Icons.phone,
                  hint: "Your Phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSaved: (text) => user = user.copyWith(phone: text),
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return 'Este campo não pode ser vazio';
                    if (!regexPhone.hasMatch(text))
                      return 'Valor deve ser do tipo telefone';
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  label: "Password",
                  icon: Icons.password,
                  hint: "Your Password",
                  obscureText: obscuredTextPassword,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffix: IconButton(
                    icon: Icon(
                      obscuredTextPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(
                        () => obscuredTextPassword = !obscuredTextPassword,
                      );
                    },
                  ),
                  onSaved: (text) => user = user.copyWith(password: text),
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return "Este campo não pode ser vazio";
                    return null;
                  },
                  onChanged: (text) => password = text,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  label: "Confirm Password",
                  icon: Icons.lock,
                  hint: "Confirm your Password",
                  obscureText: obscuredTextPasswordConfirm,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffix: IconButton(
                    icon: Icon(
                      obscuredTextPasswordConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(
                        () => obscuredTextPasswordConfirm =
                            !obscuredTextPasswordConfirm,
                      );
                    },
                  ),
                  onSaved: (text) => user = user.copyWith(password: text),
                  validator: (text) {
                    if (text == null || text.isEmpty)
                      return "Este campo não pode ser vazio";
                    if (passwordCacheConfirm != password)
                      return "Passwords does not match";
                    return null;
                  },
                  onChanged: (text) => passwordCacheConfirm = text,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkTerm,
                      onChanged: (v) => setState(() => checkTerm = v!),
                      checkColor: Theme.of(context).colorScheme.primary,
                    ),
                    Text("Aceito os termos de uso"),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  height: 45,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: !checkTerm
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              try {
                                UserCredential cred = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                      email: user.email.trim(),
                                      password: user.password.trim(),
                                    );
                                String uid = cred.user!.uid;

                                await widget.db
                                    .collection('Usuarios')
                                    .doc(uid)
                                    .set({
                                      "Nome": user.name,
                                      "Telefone": user.phone,
                                      "Email": user.email,
                                      "Senha": user.password,
                                    });

                                formKey.currentState?.reset();
                                setState(() => checkTerm = false);

                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                      'Usuário cadastrado com sucesso!',
                                    ),
                                  ),
                                );

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
                              }
                            }
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== CUSTOM TEXTFIELD =====================
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
        prefixIcon: icon == null ? null : Icon(icon),
        suffixIcon: suffix,
      ),
    );
  }
}

// ===================== USER MODEL =====================
class UserModel {
  final String phone;
  final String name;
  final String email;
  final String password;

  const UserModel({
    this.phone = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  UserModel copyWith({
    String? phone,
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
