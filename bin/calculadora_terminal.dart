import 'dart:async';
import 'dart:io';

Future<double> calcular(double n1, double n2, String operador) async {
  await Future.delayed(Duration(seconds: 1)); // simula processamento

  switch (operador) {
    case "+":
      return n1 + n2;
    case "-":
      return n1 - n2;
    case "*":
      return n1 * n2;
    case "/":
      if (n2 == 0) {
        throw Exception("Divisão por zero!");
      }
      return n1 / n2;
    default:
      throw Exception("Operador inválido!");
  }
}

Future<void> main() async {
  print("=== CALCULADORA TERMINAL LIVRE ===");
  print("Digite operações como: 5 + 3");
  print("Digite 'sair' para encerrar.\n");

  while (true) {
    stdout.write("> ");
    String? entrada = stdin.readLineSync();

    if (entrada == null) continue;

    if (entrada.toLowerCase() == "sair") {
      print("Encerrando calculadora...");
      break;
    }

    try {
      List<String> partes = entrada.split(" ");

      if (partes.length != 3) {
        print("Formato inválido! Use: número operador número");
        continue;
      }

      double n1 = double.parse(partes[0]);
      String operador = partes[1];
      double n2 = double.parse(partes[2]);

      double resultado = await calcular(n1, n2, operador);
      print("Resultado: $resultado\n");
    } catch (e) {
      print("Erro: $e\n");
    }
  }
}
