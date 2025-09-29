// pages/invoices_page.dart
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class NotasPage extends StatefulWidget {
  final FirebaseFirestore db;
  const NotasPage({super.key, required this.db});

  @override
  State<NotasPage> createState() => _NotasPageState();
}

class _NotasPageState extends State<NotasPage> {
  XFile? nota;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: selecionarNota,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  nota != null
                      ? Image.file(
                          File(nota!.path),
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.telegram, size: 25),
                  Text('Enviar Nota'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  selecionarNota() async {
    ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => nota = file);
    } catch (e) {
      print(e);
    }
  }
}
