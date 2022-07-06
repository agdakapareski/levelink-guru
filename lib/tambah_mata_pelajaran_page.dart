import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/providers/mata_pelajaran_provider.dart';
import 'package:levelink_guru/widget/custom_button.dart';
import 'package:levelink_guru/widget/padded_widget.dart';
import 'package:provider/provider.dart';

class TambahMataPelajaranPage extends StatefulWidget {
  const TambahMataPelajaranPage({Key? key}) : super(key: key);

  @override
  State<TambahMataPelajaranPage> createState() =>
      _TambahMataPelajaranPageState();
}

class _TambahMataPelajaranPageState extends State<TambahMataPelajaranPage> {
  String? selectedMapel;
  @override
  Widget build(BuildContext context) {
    final mataPelajaranProvider = Provider.of<MataPelajaranProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        title: const Text(
          'Tambah Mata Pelajaran Dikuasai',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: Container(
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
                  items: mataPelajaranProvider.mataPelajaran
                      .map((mapel) => DropdownMenuItem<String>(
                            value: mapel.id.toString(),
                            child: Text(
                              '${mapel.mataPelajaran!} ${mapel.jenjangMataPelajaran!}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      // print(value);
                      selectedMapel = value;
                    });
                  },
                  hint: selectedMapel == null
                      ? Text(
                          mataPelajaranProvider.mataPelajaran.isEmpty
                              ? 'memuat'
                              : 'mata pelajaran',
                          style: const TextStyle(
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
          ),
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: CustomButton(
              onTap: () {
                mataPelajaranProvider.storeMataPelajaranDikuasai(
                  currentid!,
                  int.parse(selectedMapel!),
                );

                Navigator.pop(context);
              },
              text: 'Tambah Mata Pelajaran',
              color: Colour.blue,
            ),
          ),
        ],
      ),
    );
  }
}
