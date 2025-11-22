import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final class ReportPage extends StatelessWidget {
  final FirebaseFirestore db;
  const ReportPage({Key? key, required this.db}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Relatório de Notas')),
      body: Center(child: Text('Relatório de Notas')),
    );
  }
}
