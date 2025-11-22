import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfe/gen/assets.gen.dart';
import 'package:nfe/pages/help/infoPage.dart';
import 'package:nfe/pages/pages/InvoicesPage.dart';
import 'package:nfe/pages/pages/guaranteesPage.dart';
import 'package:nfe/pages/pages/notasPage.dart';
import 'package:nfe/pages/welcome/welcomePage.dart';

class SendNotas extends StatefulWidget {
  final FirebaseFirestore db;
  final bool isDark;
  final VoidCallback alternarTema;

  const SendNotas({
    super.key,
    required this.db,
    required this.isDark,
    required this.alternarTema,
  });

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
  final Color? backgroundColor;
  final Row? row;

  const BotoesCustomizados({
    Key? key,
    required this.text,
    required this.onTap,
    this.imagePath,
    this.row,
    this.style,
    this.fontSize,
    this.icon,
    this.elevation = 5,
    this.textColor,
    this.minWidth,
    this.minHeight,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = ElevatedButton.styleFrom(
      minimumSize: Size(minWidth ?? 200, minHeight ?? 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: backgroundColor,
      elevation: elevation,
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
                const SizedBox(width: 10),
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
          if (row != null) ...[const SizedBox(height: 2, width: 2), row!],
        ],
      ),
    );
  }
}

class _SendNotasState extends State<SendNotas> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;

  void logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          "Deseja sair?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("Você realmente deseja encerrar sua sessão?"),
        actions: [
          TextButton(
            child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Welcome(
                    db: widget.db,
                    isDark: widget.isDark,
                    alternarTema: widget.alternarTema,
                  ),
                ),
                (route) => false,
              );
            },
            child: const Text("Sair"),
          ),
        ],
      ),
    );
  }

  Widget buildDashboard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                backgroundColor: Colors.orange,
                shadowColor: Colors.black,
              ),
              fontSize: 14,
              textColor: Colors.white,
              minWidth: 500,
              minHeight: 40,
            ),
            const SizedBox(height: 300),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: BotoesCustomizados(
                backgroundColor: Theme.of(context).colorScheme.primary,
                text:
                    'Enviar Nota/Cupom Fiscal\n(NFC-e, DANFE, DANFE Simplificada)',
                textColor: Theme.of(context).colorScheme.onPrimary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotasPage(db: widget.db),
                    ),
                  );
                },

                row: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.cupomFiscal.image(width: 80, height: 80),  
                    // Image.asset(
                    //   'assets/CupomFiscal.png',
                    //   width: 80,
                    //   height: 80,
                    // ),
                    Container(
                      width: 2,
                      height: 85, // mesma altura das imagens
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(width: 10),
                    Assets.notaEletronica.image(width: 80, height: 80),

                    // Image.asset(
                    //   'assets/NotaEletronica.png',
                    //   width: 100,
                    //   height: 100,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   width: double.infinity,
            //   height: 210,
            //   child: BotoesCustomizados(
            //     backgroundColor: Theme.of(context).colorScheme.primary,
            //     text:
            //         'Enviar Nota Fiscal Eletrônica\n(NF-e, DANFE, DANFE Simplificada)',
            //     textColor: Theme.of(context).colorScheme.onPrimary,
            //     imagePath: 'assets/NotaEletronica02.png',
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => NotasPage(db: widget.db),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      buildDashboard(),
      InvoicesPage(db: widget.db),
      GuaranteesPage(db: widget.db),
    ];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 237, 237),
        elevation: 4,
        shadowColor: Colors.black,
        leading: const SizedBox.shrink(),

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            onPressed: widget.alternarTema,
            icon: Icon(
              widget.isDark ? Icons.dark_mode : Icons.light_mode,
              color: Colors.black,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              if (value == "logout") logout();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text("Sair/Deslogar"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(index: screenIndex, children: screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ), // Cor do fundo do item selecionado
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            // backgroundColor: const Color.fromARGB(
            //   255,
            //   238,
            //   237,
            //   237,
            // ), // Fundo do NavigationBar
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 238, 237, 237),
          elevation: 4,
          shadowColor: Colors.black,
          selectedIndex: screenIndex,
          onDestinationSelected: (index) {
            setState(() {
              screenIndex = index;
            });
          },

          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                size: 45,
                color: Color.fromARGB(191, 0, 0, 0),
              ),
              selectedIcon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.description_outlined,
                size: 45,
                color: Color.fromARGB(191, 0, 0, 0),
              ),
              selectedIcon: Icon(Icons.description),
              label: 'Notas Fiscais',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.shield_outlined,
                size: 45,
                color: Color.fromARGB(191, 0, 0, 0),
              ),
              selectedIcon: Icon(Icons.shield),
              label: 'Garantias',
            ),
          ],
        ),
      ),
    );
  }
}
