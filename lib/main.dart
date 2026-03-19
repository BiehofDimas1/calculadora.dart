import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraTela(),
    );
  }
}

class CalculadoraTela extends StatefulWidget {
  @override
  _CalculadoraTelaState createState() => _CalculadoraTelaState();
}

class _CalculadoraTelaState extends State<CalculadoraTela> {
  String display = "0";
  String operador = "";

  double calcular(double n1, double n2, String operador) {
    switch (operador) {
      case "+":
        return n1 + n2;
      case "-":
        return n1 - n2;
      case "*":
        return n1 * n2;
      case "/":
        return n2 == 0 ? 0 : n1 / n2;
      default:
        return 0;
    }
  }

  void pressionarBotao(String valor) {
    setState(() {
      if (valor == "C") {
        display = "0";
        operador = "";
      } else if (valor == "DEL") {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = "0";
        }
      } else if (valor == "+" || valor == "-" || valor == "*" || valor == "/") {
        if (display.contains("=")) {
          display = display.split("=").last.trim();
        }

        operador = valor;
        display += valor;
      } else if (valor == "=") {
        if (!display.contains(operador)) return;

        List<String> partes = display.split(operador);
        if (partes.length < 2) return;

        double n1 = double.parse(partes[0]);
        double n2 = double.parse(partes[1]);

        double resultado = calcular(n1, n2, operador);

        display = "$display = $resultado";
      } else {
        if (display.contains("=")) {
          display = valor;
        } else if (display == "0") {
          display = valor;
        } else {
          display += valor;
        }
      }
    });
  }

  // 🔢 BOTÃO PADRÃO (cinza escuro)
  Widget botao(String texto) {
    return botaoCustom(texto, Colors.grey[850]!);
  }

  // 🟠 BOTÃO OPERADOR (laranja)
  Widget botaoOperador(String texto) {
    return botaoCustom(texto, Colors.orange);
  }

  // ⚪ BOTÃO ESPECIAL (cinza claro)
  Widget botaoEspecial(String texto) {
    return botaoCustom(texto, Colors.grey);
  }

  // 🎨 BOTÃO CUSTOM (estilo iPhone)
  Widget botaoCustom(String texto, Color cor) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.all(22),
          ),
          onPressed: () => pressionarBotao(texto),
          child: Text(
            texto,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // DISPLAY
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(20),
            child: Text(
              display,
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // BOTÕES
          Row(
            children: [
              botaoEspecial("C"),
              botaoEspecial("DEL"),
              botaoEspecial("%"),
              botaoOperador("/"),
            ],
          ),
          Row(
            children: [botao("7"), botao("8"), botao("9"), botaoOperador("*")],
          ),
          Row(
            children: [botao("4"), botao("5"), botao("6"), botaoOperador("-")],
          ),
          Row(
            children: [botao("1"), botao("2"), botao("3"), botaoOperador("+")],
          ),
          Row(children: [botao("0"), botao("."), botaoEspecial("=")]),
        ],
      ),
    );
  }
}
