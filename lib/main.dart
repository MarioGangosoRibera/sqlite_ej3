import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ej3/drawer.dart';
import 'package:sqlite_ej3/pantalla_insertar.dart';
import 'package:sqlite_ej3/pantalla_transacciones.dart';
import 'transacciones_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final provider = TransaccionesProvider();
  await provider.initDb();

  runApp(
    ChangeNotifierProvider(
      create: (_) => provider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = const [
      InsertarDato(),
      Transacciones(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        drawer: AppDrawer(
          selectedIndex: _selectedIndex,
          onItemTap: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
        body: screens[_selectedIndex],
      ),
    );
  }
}
