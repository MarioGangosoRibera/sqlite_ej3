import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'configuracion_provider.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfiguracionProvider>(context);

    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Modo oscuro'),
                Switch(
                  value: config.modoOscuro,
                  onChanged: (value) => config.setModoOscuro(value),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Tamaño de letra: ${config.tamanoLetra.toStringAsFixed(1)}'),
            Slider(
              value: config.tamanoLetra,
              min: 0.8,
              max: 2.0,
              divisions: 12,
              label: config.tamanoLetra.toStringAsFixed(1),
              onChanged: (value) => config.setTamanoLetra(value),
            ),
          ],
        ),
      ),
    );
  }
}
