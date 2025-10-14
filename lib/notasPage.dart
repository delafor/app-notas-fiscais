// pages/invoices_page.dart
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/qrScannerPage.dart';
import 'barrScannerPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  final tituloController = TextEditingController();
  final dataController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool mostrarcard = false;
  XFile? nota;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - '
            '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Notas')),
      body: Stack(
        children: [
          Center(
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
                                width: 150,
                                height: 250,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.telegram, size: 50),
                        text: 'Escolha\nUma Nota',
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
          if (mostrarcard && nota != null)
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600, minHeight: 500),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: SizedBox(
                                height: 50,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  mostrarcard = false;
                                  nota = null;
                                });
                              },
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              File(nota!.path),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: Key('titulo'),
                            controller: tituloController,
                            decoration: const InputDecoration(
                              labelText: 'Titulo da Nota',
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     // TODO: implement your code here
                          //   },
                          //   icon: Icon(Icons.date_range),
                          // ),
                          //////////////////////////////////////////
                          // TextFormField(
                          //   key: Key('data'),
                          //   controller: dataController,
                          //   decoration: const InputDecoration(
                          //     labelText: 'Data da Compra',
                          //   ),
                          //   validator: (text) {
                          //     if (text == null || text.isEmpty) {
                          //       return 'Campo obrigatorio';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              if (nota == null) return;

                              try {
                                // lê bytes da imagem
                                final bytes = await nota!.readAsBytes();
                                //converte para a base64
                                final base64Image = base64Encode(bytes);

                                // Salva os dados no Firestore
                                await FirebaseFirestore.instance
                                    .collection('notas')
                                    .add({
                                      'titulo': tituloController.text,
                                      'data': dataController.text,
                                      'imagemBase64': base64Image,
                                      'criadoEm': FieldValue.serverTimestamp(),
                                    });

                                // Limpa os campos e fecha o card
                                setState(() {
                                  mostrarcard = false;
                                  nota = null;
                                  tituloController.clear();
                                  dataController.clear();
                                });

                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                      'Nota cadastrada com sucesso!',
                                    ),
                                  ),
                                );
                              } catch (e) {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('Erro ao cadastrar: $e'),
                                  ),
                                );
                              }

                              setState(() {
                                mostrarcard = false;
                                nota = null;
                                tituloController.clear();
                                dataController.clear();
                              });
                            },
                            child: Text(
                              'Cadastrar Nota',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Selected date: $_selectedDate'),
                                Text('Selected date count: $_dateCount'),
                                Text('Selected range: $_range'),
                                Text('Selected ranges count: $_rangeCount'),
                              ],
                            ),
                          ),
                          Positioned(
                            child: SfDateRangePicker(
                              onSelectionChanged: _onSelectionChanged,
                              selectionMode: DateRangePickerSelectionMode.range,
                              initialSelectedRange: PickerDateRange(
                                DateTime.now().subtract(
                                  const Duration(days: 4),
                                ),
                                DateTime.now().add(const Duration(days: 3)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  selecionarNota() async {
    ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          nota = file;
          mostrarcard = true;
        });
      }
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
