import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final class QrScannerPage extends StatelessWidget {
  final FirebaseFirestore db;
  const QrScannerPage({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aponte a câmera para o QR Code',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 300,
              height: 300,
              child: MobileScanner(
                fit: BoxFit.cover,
                onDetect: (capture) {
                  final Barcode = capture.barcodes.first;
                  final code = Barcode.rawValue;
                  if (code == null) {
                    debugPrint('Código não encontrado ou sem valor');
                    return;
                  }
                  debugPrint('Código encontrado: $code');
                  Navigator.pop(
                    context,
                    code,
                  ); // o code meio q ele serve para envia o valr de volta para tela q abriu o scanner

                  // ignore: avoid_print
                  print(code);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
