import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrarGasto extends StatefulWidget {
  const RegistrarGasto({super.key});

  @override
  State<RegistrarGasto> createState() => _RegistrarGastoState();
}

class _RegistrarGastoState extends State<RegistrarGasto> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _registrarGastoEnFirebase() async {
    if (_formKey.currentState?.validate() ?? false) {
      final nombre = _nombreController.text;
      final cantidad = double.parse(_cantidadController.text);
      final descripcion = _descripcionController.text;

      try {
        await FirebaseFirestore.instance.collection('gastos').add({
          'nombre': nombre,
          'gasto': cantidad,
          'descripcion': descripcion,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gasto registrado con éxito en Firebase')),
        );

        _nombreController.clear();
        _cantidadController.clear();
        _descripcionController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar el gasto: $e')),
        );
      }
    }
  }

  String? _validateNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa un nombre';
    }
    if (value.length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? _validateCantidad(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa una cantidad';
    }
    final cantidad = double.tryParse(value);
    if (cantidad == null || cantidad <= 0) {
      return 'La cantidad debe ser un número positivo';
    }
    return null;
  }

  String? _validateDescripcion(String? value) {
    if (value != null && value.isNotEmpty && value.length < 5) {
      return 'La descripción debe tener al menos 5 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Gasto'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: _validateNombre,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cantidadController,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: _validateCantidad,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción (opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: _validateDescripcion,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registrarGastoEnFirebase,
                  child: const Text('Registrar Gasto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
