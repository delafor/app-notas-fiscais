// pages/invoices_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final data = DateTime.now();
String dataFormatada = DateFormat('dd/MM/yyyy').format(data);

class InvoicesPage extends StatefulWidget {
  final FirebaseFirestore db;
  const InvoicesPage({super.key, required this.db});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 25),
              child: Text(
                'Gestor de Garantias\ne Notas Fiscais',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black,
                ),

                // Customize the style
              ),
            ),
          ),

          Expanded(
            //isso tudo deve ser listview
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  color: Colors.green[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 140,
                    child: Stack(
                      children: [
                        // Textos
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Data: $dataFormatada'),
                            const SizedBox(height: 4),
                            const Text(
                              'Smartphone',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('Nota Fiscal nº: 001234'),
                          ],
                        ),

                        // Botão sobreposto, centralizado verticalmente à direita
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // Ajuste o valor para o raio desejado
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Ver nota'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class GuaranteesPage extends StatelessWidget {
//   final FirebaseFirestore db;
//   const GuaranteesPage({super.key, required this.db});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Guarantees'),
//     );
//   }
// }
