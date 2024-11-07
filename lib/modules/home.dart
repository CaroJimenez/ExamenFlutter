import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba/modules/gasto_details.dart';
import 'package:prueba/navigation/navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference _gastosRef =
      FirebaseFirestore.instance.collection('gastos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gastos",
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _gastosRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay restaurantes disponibles"));
          }

          final gastosDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: gastosDocs.length,
            itemBuilder: (context, index) {
              final gastosData =
                  gastosDocs[index].data() as Map<String, dynamic>;
              final name = gastosData['nombre'] ?? 'Sin nombre';
              final int cantidad = gastosData['gasto'] ?? 0;

              return GestureDetector(
                  onTap: () {
                    final description = gastosData['descripcion'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GastoDetails(description: description, name:name, cantidad:cantidad)),
                    );
                  },
                  child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/snoopyAzul.jpg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '\$',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          cantidad.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              cantidad > 999
                                  ? 'gasto alto'
                                  : cantidad >= 500 && cantidad <= 999
                                      ? 'cuidado'
                                      : 'normal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: cantidad > 999
                                    ? Colors.red
                                    : cantidad >= 500 && cantidad <= 999
                                        ? Colors.orange
                                        : Colors.green,
                              ),
                            ),
                          )
                        ],
                      )));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registrar-gasto');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
