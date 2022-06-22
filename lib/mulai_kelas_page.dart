import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/model/pertemuan_model.dart';
import 'package:levelink_guru/providers/pertemuan_provider.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/input_form.dart';
import 'package:levelink_guru/widget/padded_widget.dart';
import 'package:provider/provider.dart';

import 'model/jadwal_model.dart';

class MulaiKelasPage extends StatefulWidget {
  final Jadwal? jadwal;
  const MulaiKelasPage({Key? key, this.jadwal}) : super(key: key);

  @override
  State<MulaiKelasPage> createState() => _MulaiKelasPageState();
}

class _MulaiKelasPageState extends State<MulaiKelasPage> {
  TextEditingController materiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pertemuanProvider = Provider.of<PertemuanProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'MULAI KELAS',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomRow(
            title: 'Nama Siswa',
            value: widget.jadwal!.siswa!.nama!,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRow(
            title: 'Kelas',
            value:
                '${widget.jadwal!.siswa!.kelas} ${widget.jadwal!.siswa!.jenjang}',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRow(
            title: 'Mata Pelajaran',
            value:
                '${widget.jadwal!.kelas!.mataPelajaran!.mataPelajaran} ${widget.jadwal!.kelas!.mataPelajaran!.jenjangMataPelajaran}',
          ),
          const SizedBox(
            height: 10,
          ),
          const PaddedWidget(
            child: Text('Materi :'),
          ),
          const SizedBox(
            height: 10,
          ),
          PaddedWidget(
            child: InputForm(
              controller: materiController,
              labelText: 'materi',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: CustomButton(
              color: Colour.blue,
              text: 'Mulai',
              onTap: () {
                Pertemuan p = Pertemuan(
                  idJadwal: widget.jadwal!.id,
                  materi: materiController.text,
                );

                pertemuanProvider.storePertemuan(p);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String? title;
  final String? value;
  const CustomRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddedWidget(
      child: Row(
        children: [
          Text('$title :'),
          const Spacer(),
          Text(
            value!,
          ),
        ],
      ),
    );
  }
}
