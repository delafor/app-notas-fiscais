// pages/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/helpPage.dart';

import 'package:formulario/sendNotas.dart';

import 'package:intl/intl.dart';

final data = DateTime.now();
String nomeDoMes = DateFormat('MMMM', 'pt_BR').format(data);
String anoAtual = DateFormat('yyyy').format(data);

class DashboardPage extends StatefulWidget {
  final FirebaseFirestore db;
  const DashboardPage({super.key, required this.db});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 50),

          Text(
            'Gerencie suas notas fiscais de forma\nsimples e segura.',
            //< aqui devo colocar a quantidade de notas cadastradas
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          Spacer(),
          CardWithIconButton(
            widget: widget,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SendNotas(db: widget.db),
                ),
              );
            },
            icon: Icons.telegram_outlined,
            title: 'Enviar Nota',
            subtitle: 'Envie suas notas diretamente\npelo app.',
          ),
          const SizedBox(height: 30),
          CardWithIconButton(
            widget: widget,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpPage(db: widget.db),
                ),
              );
            },
            icon: Icons.help,
            title: 'Ajuda e Suporte',
            subtitle: 'Dúvidas? Fale com nossa equipe.',
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class CardWithIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  const CardWithIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.widget,
  });

  final DashboardPage widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      subtitle,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 13.5, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
