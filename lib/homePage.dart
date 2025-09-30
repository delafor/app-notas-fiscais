import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:formulario/dashboardPage.dart';
import 'package:formulario/guaranteesPage.dart';
import 'package:formulario/notasPage.dart';
import 'package:formulario/welcomePage.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.db});
  final FirebaseFirestore db;

  @override
  State<Home> createState() => HomeState();
}

class Destination {
  const Destination(this.label, this.icon, this.selectedIcon);
  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Dashboard', Icon(Icons.dashboard), Icon(Icons.dashboard)),
  Destination('Profile', Icon(Icons.description), Icon(Icons.description)),
  Destination(
    'Settings',
    Icon(Icons.shield_outlined),
    Icon(Icons.shield_outlined),
  ),
];

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget Function()> screens = [
      () => DashboardPage(db: widget.db),
      () => GuaranteesPage(db: widget.db),
      () => NotasPage(db: widget.db), // Profile
      // () => GuaranteesPage(db: widget.db), // Settings
    ];

    return Scaffold(
      //backgroundColor: const Color.fromRGBO(218, 241, 222, 1),
      appBar: AppBar(
        // centerTitle: true,
        // title: Text(
        //   textAlign: TextAlign.center,
        //   'N',
        //   style: TextStyle(
        //     fontSize: 18,
        //     letterSpacing: 1,

        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        // ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu), // ícone do botão
            onSelected: (String value) {
              if (value == "logout") {
                logout(context);
              }
            },

            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),
      key: scaffoldKey,

      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: [
            NavigationRail(
              //backgroundColor: const Color.fromARGB(255, 214, 213, 213),
              minWidth: 100,

              extended:
                  false, //faz a label aparecer do lado do texto,n é necessario,so se eu quiser q apareça ai eu deixo true
              selectedIndex: screenIndex,
              onDestinationSelected: (index) {
                setState(() {
                  screenIndex = index;
                });
              },

              destinations: const [
                // NavigationRailDestination(
                //   icon: Icon(Icons.add_outlined, size: 45),
                //   selectedIcon: Icon(Icons.add),
                //   label: Text('Adicionar'),
                // ),
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined, size: 45),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Dashboard'),
                ),

                NavigationRailDestination(
                  icon: Icon(Icons.description_outlined, size: 45),
                  selectedIcon: Icon(Icons.description),
                  label: Text('Notas Fiscais'),
                ),

                NavigationRailDestination(
                  icon: Icon(Icons.shield_outlined, size: 45),
                  selectedIcon: Icon(Icons.shield),
                  label: Text('Garantias'),
                ),
              ],
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
            ), //linha onde cria uma sombra entre a pagina e a coluna de icons
            // This is the main content.
            Expanded(
              child: screenIndex < screens.length
                  ? screens[screenIndex]()
                  : const Center(child: Text('Index out of range')),
            ),
          ],
        ),
      ),
    );
  }
}

void logout(context) {
  final storage = FlutterSecureStorage();
  storage.delete(key: 'auth_token');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Welcome(db: FirebaseFirestore.instance),
    ),
  );
}
