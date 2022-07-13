import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/tab_screen.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/input_form.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_theme.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController jenjangController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  update(
    String nama,
    String alamat,
    String kota,
    String provinsi,
    String jenjang,
    String jenisKelamin,
  ) async {
    var url = Uri.parse('$mainUrl/update-user/$currentid');
    var response = await http.put(url, body: {
      "nama_pengguna": nama,
      "alamat_pengguna": alamat,
      "kota_pengguna": kota,
      "provinsi_pengguna": provinsi,
      "jenjang": jenjang,
      "jenis_kelamin": jenisKelamin,
    });

    log(response.body);

    if (response.statusCode == 200) {
      Future<void> addToSp() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('currentnama', nama);
        prefs.setString('currentjenjang', jenjang);
        prefs.setString('currentalamatProvinsi', provinsi);
        prefs.setString('currentalamatKota', kota);
        prefs.setString('currentalamatDetail', alamat);
        prefs.setString('currentjenisKelamin', jenisKelamin);
        currentnama = nama;
        currentjenjang = jenjang;
        currentalamatProvinsi = provinsi;
        currentalamatKota = kota;
        currentalamatDetail = alamat;
        currentjenisKelamin = jenisKelamin;

        setState(() {});
      }

      addToSp();
    }
  }

  List<String> jenjang = [
    'SD',
    'SMP',
    'SMA',
  ];

  List<int> kelasSD = [1, 2, 3, 4, 5, 6];
  List<int> kelasSMPSMA = [1, 2, 3];
  List<String> jenisKelamin = ['laki-laki', 'perempuan'];

  String? selectedKelas;
  String? selectedJenisKelamin;

  @override
  void initState() {
    nameController.text = currentnama!;
    provinsiController.text = currentalamatProvinsi!;
    kotaController.text = currentalamatKota!;
    detailController.text = currentalamatDetail!;
    jenjangController.text = currentjenjang!;

    selectedJenisKelamin = currentjenisKelamin!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var verticalGap = screenHeight * 0.04;
    var titleGap = screenHeight * 0.015;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.04,
          ),
          children: [
            const TitleText('Update Akun'),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            const Text('Data Diri'),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'nama lengkap',
              controller: nameController,
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              controller: jenjangController,
              labelText: 'pendidikan terakhir',
            ),
            SizedBox(
              height: titleGap,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenHeight * 0.015,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedJenisKelamin,
                  items: jenisKelamin
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJenisKelamin = value;
                    });
                  },
                  hint: selectedJenisKelamin == null
                      ? const Text(
                          'jenis kelamin',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          selectedJenisKelamin!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: titleGap,
            ),
            SizedBox(
              height: verticalGap,
            ),
            const Text('Tempat Tinggal'),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'provinsi',
              hintText: 'provinsi',
              controller: provinsiController,
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'kota',
              hintText: 'kota',
              controller: kotaController,
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(
              height: titleGap,
            ),
            SizedBox(
              height: titleGap,
            ),
            InputForm(
              labelText: 'detail',
              hintText: 'detail',
              controller: detailController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 5,
            ),
            SizedBox(
              height: verticalGap,
            ),
            CustomButton(
              text: 'Update',
              color: Colour.blue,
              onTap: () {
                update(
                  nameController.text,
                  detailController.text,
                  kotaController.text,
                  provinsiController.text,
                  jenjangController.text,
                  selectedJenisKelamin!,
                ).then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TabScreen(),
                      ),
                      (route) => false,
                    ));
              },
            ),
            SizedBox(
              height: verticalGap,
            ),
          ],
        ),
      ),
    );
  }
}
