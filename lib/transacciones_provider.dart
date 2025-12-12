import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class TransaccionesProvider extends ChangeNotifier {
  late Database _db;
  List<Map<String, dynamic>> _transacciones = [];

  List<Map<String, dynamic>> get transacciones => _transacciones;

  Future<void> initDb() async {
    sqfliteFfiInit();
    final factory = databaseFactoryFfi;
    final dbPath = join(await factory.getDatabasesPath(), 'transacciones.db');
    _db = await factory.openDatabase(dbPath);

    await _db.execute('''
      CREATE TABLE IF NOT EXISTS transacciones(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT NOT NULL,
        categoria TEXT NOT NULL,
        cantidad REAL NOT NULL,
        fecha TEXT NOT NULL
      )
    ''');

    await cargarTransacciones();
  }

  Future<void> cargarTransacciones() async {
    _transacciones = await _db.query('transacciones');
    notifyListeners();
  }

  Future<void> insertarTransaccion(
    String tipo,
    String categoria,
    double cantidad,
  ) async {
    await _db.insert('transacciones', {
      'tipo': tipo,
      'categoria': categoria,
      'cantidad': cantidad,
      'fecha': DateTime.now().toIso8601String(),
    });

    await cargarTransacciones();
  }

  Future<void> eliminarTransaccion(int id) async {
    await _db.delete('transacciones', where: 'id = ?', whereArgs: [id]);
    await cargarTransacciones();
  }
}
