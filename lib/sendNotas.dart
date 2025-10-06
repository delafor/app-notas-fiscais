import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/dashboardPage.dart';
import 'package:formulario/infoPage.dart';
import 'package:formulario/notasPage.dart';

class SendNotas extends StatefulWidget {
  final FirebaseFirestore db;
  const SendNotas({super.key, required this.db});

  @override
  State<SendNotas> createState() => _SendNotasState();
}

class BotoesCustomizados extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String? imagePath;
  final ButtonStyle? style;
  final double? fontSize;
  final Icon? icon;
  final double elevation;
  final Color? textColor;
  final double? minWidth;
  final double? minHeight;

  const BotoesCustomizados({
    Key? key,
    required this.text,
    required this.onTap,
    this.imagePath,
    this.style,
    this.fontSize,
    this.icon,
    this.elevation = 5,
    this.textColor,
    this.minWidth,
    this.minHeight,
    //required ButtonStyle style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = ElevatedButton.styleFrom(
      minimumSize: Size(minWidth ?? 200, minHeight ?? 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    return ElevatedButton(
      style: defaultStyle.merge(style),

      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon!,
                SizedBox(width: 10),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize ?? 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          if (imagePath != null && imagePath!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Image.asset(imagePath!, width: 100, height: 100),
          ],
        ],
      ),
    );
  }
}

class _SendNotasState extends State<SendNotas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(db: widget.db),
              ),
            );
          },
        ),

        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botão de info
                  BotoesCustomizados(
                    text: 'Sua nota é válida? Veja as regras.',
                    icon: const Icon(Icons.info, color: Colors.white),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoPage(db: widget.db),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      backgroundColor: Colors.orange,
                      shadowColor: Colors.black,
                    ),
                    fontSize: 10,
                    textColor: Colors.white,
                    minWidth: 500,
                    minHeight: 15,
                  ),

                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     // side: BorderSide(
                  //     //   color: const Color.fromARGB(255, 255, 255, 255),
                  //     //   width: 2,
                  //     // ),
                  //     shadowColor: Colors.black,
                  //     backgroundColor: Colors.orange,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 20,
                  //       vertical: 20,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => InfoPage(db: widget.db),
                  //       ),
                  //     );
                  //   },

                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.info, color: Colors.white),
                  //       SizedBox(width: 10),
                  //       Text(
                  //         'Sua nota é valida? Veja as regas.',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botão 1
                SizedBox(
                  width: 460,
                  height: 200,
                  child: BotoesCustomizados(
                    text: 'Enviar Nota/Cupom Fiscal',
                    imagePath: 'assets/CupomFiscal.png',

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotasPage(db: widget.db),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Botão 2
                SizedBox(
                  width: 460,
                  height: 210,
                  child: BotoesCustomizados(
                    text:
                        'Enviar Nota Fiscal Eletrônica\n(NF-e, DANFE, DANFE Simplificada)',
                    imagePath: 'assets/NotaEletronica02.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotasPage(db: widget.db),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
