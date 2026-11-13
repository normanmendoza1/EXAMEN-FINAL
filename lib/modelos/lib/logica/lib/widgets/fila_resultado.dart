import 'package:flutter/material.dart';

class FilaResultado extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const FilaResultado({
    super.key,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
