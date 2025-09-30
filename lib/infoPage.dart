import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final FirebaseFirestore db;
  const InfoPage({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Info'));
  }
}
