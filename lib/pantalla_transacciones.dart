import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ej3/transacciones_provider.dart';
import 'package:intl/intl.dart';

class Transacciones extends StatelessWidget {
  const Transacciones({super.key});

  @override
  Widget build(BuildContext context) {
    // lista transacciones del provider
    final transacciones = Provider.of<TransaccionesProvider>(
      context,
    ).transacciones;

    if (transacciones.isEmpty) {
      return const Center(child: Text('No hay transacciones registradas'));
    }

    return ListView.builder(
      itemCount: transacciones.length,
      itemBuilder: (context, index) {
        final trans = transacciones[index];
        final esIngreso = trans['tipo'] == 'Ingreso';
        final fecha = DateTime.parse(trans['fecha']);
        final fecha_formateada = DateFormat('dd/MM/yyyy HH:mm').format(fecha);

        return ListTile(
          leading: Icon(
            esIngreso ? Icons.arrow_upward : Icons.arrow_downward,
            color: esIngreso ? Colors.green : Colors.red,
          ),
          title: Text(
            '${trans['cantidad']} €',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${trans['tipo']} - ${trans['categoria']}\n$fecha_formateada',
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final provider = context.read<TransaccionesProvider>();
              await provider.eliminarTransaccion(trans['id'] as int);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transacción eliminada')),
              );
            },
          ),
        );
      },
    );
  }
}
