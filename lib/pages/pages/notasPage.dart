// pages/invoices_page.dart
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfe/pages/scanners/qrScannerPage.dart';
import '../scanners/barrScannerPage.dart';
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
  final String? imagePath;
  final int? minHeight;
  final int? minWidth;
  const BotoesCustomizados({
    Key? key,
    required this.text,
    required this.onTap,
    this.style,
    this.icon,
    this.fontSize,
    this.textColor,
    // required String imagePath,
    // required int minHeight,
    // required int minWidth,
    this.imagePath,
    this.minHeight,
    this.minWidth,
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
  bool qrcode = false;
  String? linkQrCode;

  String _selectedDate = '';
  // String _dateCount = '';
  String _range = '';
  // String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        final DateTime date = args.value;
        final formatted = DateFormat('dd/MM/yyyy').format(date);
        _selectedDate = formatted;
        dataController.text = formatted;
      } else if (args.value is PickerDateRange) {
        final start = DateFormat('dd/MM/yyyy').format(args.value.startDate);
        final end = DateFormat(
          'dd/MM/yyyy',
        ).format(args.value.endDate ?? args.value.startDate);
        _range = '$start - $end';
        dataController.text = _range;
      }
      Navigator.of(context).pop();
      // if (args.value is PickerDateRange) {
      //   _range =
      //       '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - '
      //       '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      // } else if (args.value is DateTime) {
      //   _selectedDate = args.value.toString();
      // } else if (args.value is List<DateTime>) {
      //   _dateCount = args.value.length.toString();
      // } else {
      //   _rangeCount = args.value.length.toString();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Notas')),
      body: Stack(
        children: [
          Column(
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
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.telegram,
                              size: 50,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      text: 'Escolha\nUma Nota',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onTap: selecionarNota,
                      imagePath: '',
                      minHeight: null,
                      minWidth: null,
                    ),
                  ),
                  // SizedBox(width: 50),
                  // SizedBox(
                  //   height: 160,
                  //   width: 160,
                  //   child: BotoesCustomizados(
                  //     icon: Icon(Icons.key, size: 50),
                  //     text: 'Digitar\nChave de Acesso',
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 10,
                  //         vertical: 10,
                  //       ),
                  //     ),
                  //     onTap: selecionarNota,
                  //     imagePath: '',
                  //     minHeight: null,
                  //     minWidth: null,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 160,
                  //   width: 160,
                  //   child: BotoesCustomizados(
                  //     icon: FaIcon(FontAwesomeIcons.barcode, size: 50),
                  //     text: 'Ler\nCódigo de barra',
                  //     onTap: barrScanner,
                  //     imagePath: '',
                  //     minHeight: null,
                  //     minWidth: null,
                  //   ),
                  // ),
                  SizedBox(width: 50),
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: BotoesCustomizados(
                      icon: FaIcon(
                        FontAwesomeIcons.qrcode,
                        size: 50,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      text: 'Ler\nCódigo QR Code',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onTap: lerQrCode,
                      imagePath: '',
                      minHeight: null,

                      minWidth: null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (mostrarcard && (nota != null || qrcode))
            Center(
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
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: qrcode
                                ? Image.asset(
                                    'assets/qrcode.png',
                                    width: 200,
                                    fit: BoxFit.contain,
                                  )
                                : (nota != null
                                      ? Image.file(
                                          File(nota!.path),
                                          width: 200,
                                          fit: BoxFit.contain,
                                        )
                                      : SizedBox()),

                            ////////////////////
                            // child: Image.file(
                            //   File(nota!.path),
                            //   width: 200,
                            //   // height: 200,
                            //   fit: BoxFit.contain,
                            // ),
                            ////////////////////
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
                        TextFormField(
                          readOnly: true,
                          key: Key('data'),
                          controller: dataController,
                          decoration: const InputDecoration(
                            labelText: 'Data da Compra',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Campo obrigatorio';
                            }
                            return null;
                          },

                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Escolha uma data'),
                                content: Container(
                                  height: 350,
                                  width: 300,
                                  child: SfDateRangePicker(
                                    onSelectionChanged: _onSelectionChanged,
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate())
                                    return;
                                  // if (nota == null) return;

                                  try {
                                    String base64Image = '';
                                    if (qrcode) {
                                      final bytes = await rootBundle.load(
                                        'assets/qrcode.png',
                                      );
                                      base64Image = base64Encode(
                                        bytes.buffer.asUint8List(),
                                      );
                                    } else if (nota != null) {
                                      final bytes = await nota!.readAsBytes();
                                      base64Image = base64Encode(bytes);
                                      // final bytes = await nota!.readAsBytes();
                                      // base64Image = base64Encode(bytes);
                                    }
                                    // lê bytes da imagem

                                    //converte para a base64

                                    // Salva os dados no Firestore
                                    await FirebaseFirestore.instance
                                        .collection('notas')
                                        .add({
                                          'titulo': tituloController.text,
                                          'data': dataController.text,
                                          'imagemBase64': base64Image,
                                          'linkNota': qrcode
                                              ? linkQrCode.toString()
                                              : null,
                                          'criadoEm':
                                              FieldValue.serverTimestamp(),
                                        });

                                    // Limpa os campos e fecha o card
                                    setState(() {
                                      mostrarcard = false;
                                      nota = null;
                                      tituloController.clear();
                                      dataController.clear();
                                      qrcode = false;
                                      linkQrCode = null;
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
                                    qrcode = false;
                                  });
                                },
                                child: Text('Cadastrar Nota'),
                              ),
                            ),
                          ],
                        ),
                      ],
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
        nota = file;
        //TODO usar dialog no lugar stack

        setState(() {
          mostrarcard = true;
          qrcode = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  lerQrCode() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrScannerPage(db: widget.db)),
    );

    if (resultado == null) return;

    setState(() {
      qrcode = true;
      nota = null;
      linkQrCode = resultado.toString();
      tituloController.text = ''; //resultado.toString();
      mostrarcard = true;
    });
  }

  // barrScanner() async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Barrscannerpage(db: widget.db)),
  //   );
  // }
}
