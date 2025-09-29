// pages/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:formulario/sendNotas.dart';

import 'package:intl/intl.dart';

final data = DateTime.now();
String nomeDoMes = DateFormat('MMMM', 'pt_BR').format(data);
String anoAtual = DateFormat('yyyy').format(data);

class DashboardPage extends StatefulWidget {
  final FirebaseFirestore db;
  const DashboardPage({super.key, required this.db});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          textAlign: TextAlign.center,
          'Dashboard',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,

            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 25),
              child: Row(
                children: [
                  Text(
                    'Notas enviadas em \n ${nomeDoMes}/${anoAtual}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 50),

                  Text(
                    'Total de Notas \n validas:0 ',
                     //< aqui devo colocar a quantidade de notas cadastradas
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 200),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 200,
                //   child: ListTile(
                //     leading: Icon(Icons.telegram, size: 25),
                //     title: Text('Enviar Nota'),
                //     onTap: selecionarNota,
                //     trailing: nota != null ? Image.file(File(nota!.path)) : null,
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SendNotas(db: widget.db)));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.telegram, size: 25),
                      Text('Enviar Nota'),
                    ],
                  ),
                ),
                SizedBox(width: 100),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.help, size: 25),
                      Text('Dúvidas / Ajuda'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}