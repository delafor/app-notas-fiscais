import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Barrscannerpage extends StatefulWidget {
  final FirebaseFirestore db;
  const Barrscannerpage({super.key, required this.db});

  @override
  State<Barrscannerpage> createState() => _BarrscannerpageState();
}

class _BarrscannerpageState extends State<Barrscannerpage> {
  final controller = MobileScannerController(formats: [BarcodeFormat.code128]);
  bool processando = false;
  String resultado = 'Aponte a câmera para o código de barras';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(resultado, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 50),
            SizedBox(
              width: 400,
              height: 100,
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  if (processando) return;
                  processando = true;

                  final codigo = capture.barcodes.first.rawValue ?? '';
                  setState(() {
                    if (codigo.isEmpty) {
                      resultado = 'Código de barras não encontrado';
                    } else {
                      resultado = 'Código de barras encontrado: $codigo';
                    }
                  });

                  // libera nova leitura após 1 segundo
                  Future.delayed(const Duration(seconds: 1), () {
                    processando = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
