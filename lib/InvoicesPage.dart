// pages/guarantees_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvoicesPage extends StatelessWidget {
  final FirebaseFirestore db;
  const InvoicesPage({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Guarantees'),
    );
  }
}
