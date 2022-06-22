import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';

class EvaluasiPage extends StatefulWidget {
  const EvaluasiPage({Key? key}) : super(key: key);

  @override
  State<EvaluasiPage> createState() => _EvaluasiPageState();
}

class _EvaluasiPageState extends State<EvaluasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'EVALUASI MURID',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
      ),
    );
  }
}
