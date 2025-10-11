import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formulario/infoPage.dart';

class HelpPage extends StatelessWidget {
  final FirebaseFirestore db;
  const HelpPage({Key? key, required this.db}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajuda e Suporte')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // SizedBox(height: 5),
              SizedBox(
                width: 600,
                height: 70,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoPage(db: db)),
                    );
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(500, 50),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info, size: 25),
                      SizedBox(width: 8),
                      Text(
                        'Regras de envio e validação de notas',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(),
              SizedBox(height: 5),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size(500, 50),
                  padding: EdgeInsets.all(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.help, size: 25),
                    SizedBox(width: 8),
                    Text('Central de ajuda', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 19),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
