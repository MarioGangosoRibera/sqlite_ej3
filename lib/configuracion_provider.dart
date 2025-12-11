import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracionProvider extends ChangeNotifier {
  bool _modoOscuro = false;
  double _tamanoLetra = 1.0;

  bool get modoOscuro => _modoOscuro;
  double get tamanoLetra => _tamanoLetra;

  ConfiguracionProvider() {
    _cargarPreferencias();
  }

  Future<void> _cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    _tamanoLetra = prefs.getDouble('tamanoLetra') ?? 1.0;
    notifyListeners();
  }

  Future<void> setModoOscuro(bool value) async {
    _modoOscuro = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', value);
    notifyListeners();
  }

  Future<void> setTamanoLetra(double value) async {
    _tamanoLetra = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamanoLetra', value);
    notifyListeners();
  }
}
