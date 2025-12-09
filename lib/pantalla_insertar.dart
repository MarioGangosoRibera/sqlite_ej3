import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ej3/transacciones_provider.dart';

class InsertarDato extends StatefulWidget {
  const InsertarDato({super.key});

  @override
  State<InsertarDato> createState() => _InsertarDatoState();
}

class _InsertarDatoState extends State<InsertarDato> {
  int _selectedIndex = -1; // -1 = ninguno, 0 = gasto, 1 = ingreso
  String _categoria = 'Comida';
  final _cantidadController = TextEditingController();

  final categorias = ['Comida', 'Transporte', 'Ocio', 'Otros'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransaccionesProvider>(context, listen: false);

    return Center(
      child: SizedBox(
        width: 300, // limitar el ancho del formulario
        child: Column(
          mainAxisSize: MainAxisSize.min, //ocupar lo minimo
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Insertar Transacción',
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold
              ),
            ),
            
            SizedBox(height: 20),
            ToggleButtons(
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
              selectedColor: Colors.white,
              color: Colors.black,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Gasto', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Ingreso', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            SizedBox(height: 20),
            DropdownButton<String>(
              value: _categoria,
              items: categorias.map((c) {
                return DropdownMenuItem(value: c, child: Text(c));
              }).toList(),
              onChanged: (value) => setState(() => _categoria = value!),
            ),

            SizedBox(height: 20),
            TextField(
              controller: _cantidadController,
              decoration: const InputDecoration(labelText: 'Cantidad €'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedIndex == 0 ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                if (_selectedIndex == -1 || _cantidadController.text.isEmpty) return;
                final tipo = _selectedIndex == 0 ? 'Gasto' : 'Ingreso';
                provider.insertarTransaccion(
                  tipo,
                  _categoria,
                  double.parse(_cantidadController.text),
                );
                _cantidadController.clear();
                setState(() => _selectedIndex = -1);
              },
              child: Text('Guardar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
