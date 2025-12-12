import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onItemTap;
  final int selectedIndex;

  const AppDrawer({
    super.key,
    required this.onItemTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Insertar dato'),
            selected: selectedIndex == 0,
            onTap: () {
              onItemTap(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Transacciones'),
            selected: selectedIndex == 1,
            onTap: () {
              onItemTap(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            selected: selectedIndex == 2,
            onTap: () {
              onItemTap(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
