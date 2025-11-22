// // pages/dashboard_page.dart

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:nfe/pages/help/helpPage.dart';

// import 'package:nfe/pages/pages/sendNotas.dart';

// import 'package:intl/intl.dart';

// final data = DateTime.now();
// String nomeDoMes = DateFormat('MMMM', 'pt_BR').format(data);
// String anoAtual = DateFormat('yyyy').format(data);

// class DashboardPage extends StatefulWidget {
//   final FirebaseFirestore db;
//   const DashboardPage({super.key, required this.db});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Align(
//         alignment: Alignment.center,
//         child: FractionallySizedBox(
//           heightFactor: 0.90,
//           widthFactor: 0.85,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               Text(
//                 'Olá',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 35,
//                   color: const Color.fromARGB(255, 0, 0, 0),
//                 ),
//               ),
//               SizedBox(width: 50),

//               Text(
//                 'Gerencie suas notas fiscais de forma\nsimples e segura.',
//                 //< aqui devo colocar a quantidade de notas cadastradas
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: const Color.fromARGB(255, 0, 0, 0),
//                 ),
//               ),
//               Spacer(),
//               Align(
//                 alignment: Alignment.center,
//                 child: FractionallySizedBox(
//                   widthFactor: 0.85, // 0.85 = 85% da largura disponível
//                   child: Column(
//                     children: [
//                       CardWithIconButton(
//                         color: Theme.of(context).colorScheme.primary,
//                         widget: widget,
//                         textColor: Theme.of(context).colorScheme.onPrimary,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SendNotas(db: widget.db),
//                             ),
//                           );
//                         },
//                         icon: Icons.telegram_outlined,
//                         title: 'Enviar Nota',
//                         subtitle: 'Envie suas notas diretamente\npelo app.',
//                       ),

//                       const SizedBox(height: 30),
//                       CardWithIconButton(
//                         color: Theme.of(context).colorScheme.primary,
//                         widget: widget,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HelpPage(db: widget.db),
//                             ),
//                           );
//                         },
//                         icon: Icons.help,
//                         title: 'Ajuda e Suporte',
//                         subtitle: 'Dúvidas? Fale com nossa equipe.',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CardWithIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//   final String title;
//   final Color? color;
//   final String subtitle;
//   final Color? textColor;
//   const CardWithIconButton({
//     super.key,
//     required this.icon,
//     this.color,
//     this.textColor,
//     required this.onTap,
//     required this.title,
//     required this.subtitle,
//     required this.widget,
//   });

//   final DashboardPage widget;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         color: const Color.fromARGB(255, 0, 0, 0),
//         margin: EdgeInsets.zero,
//         child: Row(
//           children: [
//             Expanded(
//               child: Icon(
//                 icon,
//                 size: 70,
//                 color: const Color.fromARGB(255, 255, 255, 255),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   Text(
//                     subtitle,
//                     overflow: TextOverflow.clip,
//                     style: TextStyle(
//                       fontSize: 13.5,
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
