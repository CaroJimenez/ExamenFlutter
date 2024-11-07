import 'package:flutter/material.dart';

class GastoDetails extends StatelessWidget {
  final String description;
  final String name;
  final int cantidad;

  const GastoDetails({
    super.key,
    required this.description,
    required this.name,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/snoopyAzul.jpg', 
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Nombre del gasto
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Cantidad
            Text(
              'Cantidad: \$${cantidad.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),

            // Descripción del gasto
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
