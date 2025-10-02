import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final FirebaseFirestore db;
  const InfoPage({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regras da Nota Fiscal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '📋 Regras para a nota ser válida',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            ListTile(
              leading: Icon(Icons.store, color: Colors.blue),
              title: Text('Emitida por estabelecimento regular'),
              subtitle: Text(
                'A nota deve ser de uma empresa com CNPJ ativo e autorizado.',
              ),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.green),
              title: Text('Data de emissão válida'),
              subtitle: Text(
                'Apenas notas dentro do período de validade da campanha serão aceitas.',
              ),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.orange),
              title: Text('Produtos/serviços participantes'),
              subtitle: Text(
                'Devem constar produtos/serviços que fazem parte da promoção/regulamento.',
              ),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.purple),
              title: Text('Nota legível e completa'),
              subtitle: Text(
                'A foto ou upload precisa mostrar:\n- CNPJ do estabelecimento\n- Data e hora da compra\n- Número da nota/cupom fiscal\n- Produtos comprados\n- Valor total',
              ),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text('Sem rasuras ou alterações'),
              subtitle: Text(
                'Notas com edição, cortes ou adulterações não serão aceitas.',
              ),
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.upload_file, color: Colors.teal),
              title: Text('Uma nota por envio'),
              subtitle: Text(
                'Cada envio deve conter apenas uma nota/cupom fiscal.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
