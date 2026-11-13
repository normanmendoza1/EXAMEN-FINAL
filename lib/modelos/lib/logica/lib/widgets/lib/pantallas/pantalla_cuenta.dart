import 'package:flutter/material.dart';

import '../modelos/cuenta.dart';
import '../logica/calculadora.dart';
import '../widgets/fila_resultado.dart';

class PantallaCuenta extends StatefulWidget {
  const PantallaCuenta({super.key});

  @override
  State<PantallaCuenta> createState() => _PantallaCuentaState();
}

class _PantallaCuentaState extends State<PantallaCuenta> {
  Cuenta cuenta = const Cuenta();

  final TextEditingController controladorMonto =
      TextEditingController(text: '0');

  @override
  void dispose() {
    controladorMonto.dispose();
    super.dispose();
  }

  void actualizarMonto(String texto) {
    setState(() {
      cuenta = cuenta.copyWith(
        monto: leerMonto(texto),
      );
    });
  }

  void actualizarPersonas(int cambio) {
    setState(() {
      cuenta = cuenta.copyWith(
        personas: ajustarPersonas(cuenta.personas, cambio),
      );
    });
  }

  void actualizarPropina(int porcentaje) {
    setState(() {
      cuenta = cuenta.copyWith(
        propina: porcentaje,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Dividir la cuenta',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 24),

              TextField(
                controller: controladorMonto,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: actualizarMonto,
                decoration: InputDecoration(
                  labelText: 'Monto de la cuenta',
                  prefixText: 'Bs ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    'Personas',
                    style: TextStyle(fontSize: 15),
                  ),

                  Row(
                    children: [

                      IconButton(
                        onPressed: () => actualizarPersonas(-1),
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                      ),

                      Text(
                        '${cuenta.personas}',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),

                      IconButton(
                        onPressed: () => actualizarPersonas(1),
                        icon: const Icon(
                          Icons.add_circle_outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Propina',
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: SegmentedButton<int>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment<int>(
                      value: 0,
                      label: Text('0 %'),
                    ),
                    ButtonSegment<int>(
                      value: 10,
                      label: Text('10 %'),
                    ),
                    ButtonSegment<int>(
                      value: 15,
                      label: Text('15 %'),
                    ),
                    ButtonSegment<int>(
                      value: 20,
                      label: Text('20 %'),
                    ),
                  ],
                  selected: {cuenta.propina},
                  onSelectionChanged: (seleccion) {
                    actualizarPropina(seleccion.first);
                  },
                ),
              ),

              const SizedBox(height: 18),

              const Divider(),

              const SizedBox(height: 18),

              FilaResultado(
                etiqueta: 'Propina',
                valor: formatearMonto(
                  calcularPropina(cuenta),
                ),
              ),

              const SizedBox(height: 16),

              FilaResultado(
                etiqueta: 'Total con propina',
                valor: formatearMonto(
                  calcularTotal(cuenta),
                ),
              ),

              const SizedBox(height: 18),

              FilaResultado(
                etiqueta: 'Cada persona paga',
                valor: formatearMonto(
                  calcularPorPersona(cuenta),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
