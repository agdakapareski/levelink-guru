import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/input_form.dart';

class AddClassPage extends StatefulWidget {
  const AddClassPage({Key? key}) : super(key: key);

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  TextEditingController hariController = TextEditingController();
  TextEditingController jamController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colour.blue,
        title: const Text(
          'TAMBAH KELAS',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          InputForm(controller: hariController, labelText: 'hari'),
          const SizedBox(
            height: 16,
          ),
          InputForm(controller: jamController, labelText: 'jam'),
          const SizedBox(
            height: 16,
          ),
          InputForm(controller: hargaController, labelText: 'harga'),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            color: Colour.blue,
            text: 'Buat Kelas',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
