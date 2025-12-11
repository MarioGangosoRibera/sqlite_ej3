import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ej3/drawer.dart';
import 'package:sqlite_ej3/pantalla_configuracion.dart';
import 'package:sqlite_ej3/pantalla_insertar.dart';
import 'package:sqlite_ej3/pantalla_transacciones.dart';
import 'transacciones_provider.dart';
import 'configuracion_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final transProvider = TransaccionesProvider();
  await transProvider.initDb();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => transProvider),
        ChangeNotifierProvider(create: (_) => ConfiguracionProvider()),
      ],
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
    final config = Provider.of<ConfiguracionProvider>(context);

    final screens = const [
      InsertarDato(),
      Transacciones(),
      Configuracion(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: config.modoOscuro ? ThemeMode.dark : ThemeMode.light,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: config.tamanoLetra),
          child: child!,
        );
      },
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
