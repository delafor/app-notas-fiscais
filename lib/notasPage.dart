// pages/invoices_page.dart
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/qrScannerPage.dart';
import 'barrScannerPage.dart';
import 'package:image_picker/image_picker.dart';

class NotasPage extends StatefulWidget {
  final FirebaseFirestore db;
  const NotasPage({super.key, required this.db});

  @override
  State<NotasPage> createState() => _NotasPageState();
}

class BotoesCustomizados extends StatelessWidget {
  final Widget? icon;
  final String text;

  final VoidCallback onTap;
  final ButtonStyle? style;
  final double? fontSize;
  final Color? textColor;

  const BotoesCustomizados({
    Key? key,
    //required this.icon,
    required this.text,
    required this.onTap,
    this.style,
    this.icon,
    this.fontSize,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = ElevatedButton.styleFrom(
      //minimumSize: Size(minWidth ?? 100, minHeight ?? 100),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
    );
    return ElevatedButton(
      style: defaultStyle.merge(style),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,

          SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize ?? 15,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotasPageState extends State<NotasPage> {
  XFile? nota;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Notas')),
      //style: defaultStyle.merge(style),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: BotoesCustomizados(
                    icon: nota != null
                        ? Image.file(
                            File(nota!.path),
                            width: 110,
                            height: 90,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.telegram, size: 50),
                    text: 'Enviar Nota',

                    onTap: selecionarNota,
                  ),
                ),
                SizedBox(width: 50),
                SizedBox(
                  height: 160,
                  width: 160,
                  child: BotoesCustomizados(
                    icon: Icon(Icons.key, size: 50),
                    text: 'Digitar\nChave de Acesso',
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    onTap: selecionarNota,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: BotoesCustomizados(
                    icon: FaIcon(FontAwesomeIcons.barcode, size: 50),
                    text: 'Ler\nCódigo de barra',
                    onTap: barrScanner,
                  ),
                ),
                SizedBox(width: 50),
                SizedBox(
                  height: 160,
                  width: 160,
                  child: BotoesCustomizados(
                    icon: FaIcon(FontAwesomeIcons.qrcode, size: 50),
                    text: 'Ler\nCódigo QR Code',
                    onTap: lerQrCode,
                  ),
                ),
              ],
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

  lerQrCode() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrScannerPage(db: widget.db)),
    );
  }

  barrScanner() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Barrscannerpage(db: widget.db)),
    );
  }
}
