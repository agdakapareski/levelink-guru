import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/mata_pelajaran_model.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/input_form.dart';

import 'package:http/http.dart' as http;

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hours = hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hours:$min";
  }
}

class AddClassPage extends StatefulWidget {
  const AddClassPage({Key? key}) : super(key: key);

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  Future<List<MataPelajaran>> getMataPelajaran(int id) async {
    var url = Uri.parse('$mainUrl/mata-pelajaran-pengajar/$id');
    var response = await http.get(url);

    List<MataPelajaran> mataPelajarans = [];

    var body = json.decode(response.body);
    var data = body['data'];
    List datas = data['mata_pelajaran_dikuasai'];

    if (response.statusCode == 200) {
      for (var item in datas) {
        MataPelajaran mp = MataPelajaran(
          id: item['id'],
          mataPelajaran: item['nama_mata_pelajaran'],
        );

        mataPelajarans.add(mp);
      }
    }

    return mataPelajarans;
  }

  List<MataPelajaran> listMapelDikuasai = [];

  String? selectedMapel;

  TextEditingController hariController = TextEditingController();
  TextEditingController jamController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    getMataPelajaran(currentid!).then((value) {
      setState(() {
        listMapelDikuasai = value;
      });
    });
    super.initState();
  }

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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedMapel,
                items: listMapelDikuasai
                    .map((mapel) => DropdownMenuItem<String>(
                          value: mapel.id.toString(),
                          child: Text(
                            mapel.mataPelajaran!,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMapel = value;
                  });
                },
                hint: selectedMapel == null
                    ? const Text(
                        'Mata Pelajaran',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      )
                    : Text(
                        selectedMapel!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InputForm(controller: hariController, labelText: 'hari'),
          const SizedBox(
            height: 16,
          ),
          InputForm(
            readonly: true,
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: selectedTime,
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (timeOfDay != null && timeOfDay != selectedTime) {
                setState(() {
                  selectedTime = timeOfDay;
                });
              }
            },
            controller: TextEditingController(text: selectedTime.to24hours()),
            labelText: 'jam',
          ),
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
