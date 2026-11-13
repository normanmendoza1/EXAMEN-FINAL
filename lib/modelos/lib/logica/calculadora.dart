import '../modelos/cuenta.dart';

// Calcula el monto correspondiente a la propina.
double calcularPropina(Cuenta cuenta) {
  return cuenta.monto * cuenta.propina / 100;
}

// Calcula el total incluyendo la propina.
double calcularTotal(Cuenta cuenta) {
  return cuenta.monto + calcularPropina(cuenta);
}

// Calcula cuánto debe pagar cada persona.
double calcularPorPersona(Cuenta cuenta) {
  if (cuenta.personas < 1) {
    return 0.0;
  }

  return calcularTotal(cuenta) / cuenta.personas;
}

// Formatea los montos en bolivianos.
String formatearMonto(double monto) {
  return 'Bs ${monto.toStringAsFixed(2)}';
}

// Convierte el texto ingresado en un monto válido.
double leerMonto(String texto) {
  final monto = double.tryParse(texto.replaceAll(',', '.'));

  if (monto == null || !monto.isFinite || monto < 0) {
    return 0.0;
  }

  return monto;
}

// Modifica la cantidad de personas sin permitir menos de una.
int ajustarPersonas(int personas, int cambio) {
  final resultado = personas + cambio;

  if (resultado < 1) {
    return 1;
  }

  return resultado;
}
