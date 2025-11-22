import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nfe/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:json_theme/json_theme.dart';

final data = DateTime.now();
String dataFormatada = DateFormat('dd/MM/yyyy').format(data);

class InvoicesPage extends StatefulWidget {
  final FirebaseFirestore db;
  const InvoicesPage({super.key, required this.db});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  String searchQuery = '';
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 25),
            child: Text(
              'Gestor de Garantias\ne Notas Fiscais',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              //agora tenho q colocar logica etc
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary, // cor da borda normal
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimary, // cor da borda ao focar
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.db
                  .collection('notas')
                  .orderBy('criadoEm', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Nenhuma nota cadastrada'));
                }

                final alldocs = snapshot.data!.docs;

                final docs = alldocs.where((doc) {
                  final titulo = (doc['titulo'] ?? '').toString().toLowerCase();
                  final dataNota = (doc['data'] ?? '').toString().toLowerCase();
                  //final numeroNota = (doc['numeroNota'] ?? '')
                  //  .toString()
                  //  .toLowerCase();

                  return titulo.contains(searchQuery) ||
                      dataNota.contains(searchQuery);
                  // numeroNota.contains(searchQuery);
                }).toList();
                if (docs.isEmpty) {
                  return const Center(child: Text('Nenhuma nota encontrada'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(
                    16,
                  ), // adiciona espaçamento ao redor da lista de cards
                  itemCount: docs
                      .length, // define quantos itens a lista terá (quantos documentos do Firestore)
                  itemBuilder: (context, index) {
                    // função que constrói cada item/card da lista
                    final doc =
                        docs[index]; // pega o documento atual da lista de docs
                    final titulo =
                        doc['titulo'] ??
                        ''; // extrai o título da nota, se não existir usa string vazia
                    final dataNota =
                        doc['data'] ??
                        ''; // extrai a data da nota, se não existir usa string vazia
                    final imagemBase64 =
                        doc['imagemBase64'] ??
                        ''; // pega a imagem em base64, se não existir string vazia
                    final bytes = base64Decode(imagemBase64);
                    // converte a string base64 em bytes, que podem virar imagem

                    return Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 140,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Image.memory(
                                  //    pega os bytes da imagem que veio do Firestore
                                  bytes, //  define a largura da miniatura dentro do card
                                  width:
                                      80, //  mantém a proporção original da imagem, não corta
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Data: $dataNota'),
                                    SizedBox(height: 4),
                                    Text(
                                      titulo,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () async {
                                    String link = doc['linkNota'] ?? '';
                                    link = link.trim();
                                    if (!link.startsWith('http')) {
                                      link = '$link';
                                    }

                                    // encode para caracteres especiais

                                    try {
                                      await launchUrlString(
                                        link,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Não foi possível abrir o link',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Ver nota',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
