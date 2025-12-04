import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ej3/transacciones_provider.dart';

class InsertarDato extends StatefulWidget {
  const InsertarDato({super.key});

  @override
  State<InsertarDato> createState() => _InsertarDatoState();
}

class _InsertarDatoState extends State<InsertarDato> {

  int _selectedIndex = -1; //-1 = ninguno 0 = gasto 1= ingreso
  String _categoria = '';
  final _cantidadController = TextEditingController();

  final categorias = ['Comida', 'Transporte', 'Ocio', 'Otros'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionesProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Insertar Transacción',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Center(
            child: ToggleButtons(
              isSelected: [
                _selectedIndex == 0,
                _selectedIndex == 1,
              ],
              onPressed: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              borderRadius: BorderRadius.circular(8),
              fillColor: _selectedIndex == 0 ? Colors.red : Colors.green,
              selectedColor: Colors.white, // texto cuando está seleccionado
              color: Colors.black,         // texto cuando NO está seleccionado
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Gasto',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Ingreso',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )

        ]
      )
    );
  }
}