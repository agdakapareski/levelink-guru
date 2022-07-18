import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levelink_guru/add_class_page.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/mata_pelajaran_page.dart';
import 'package:levelink_guru/model/kelas_model.dart';
import 'package:levelink_guru/providers/kelas_provider.dart';
import 'package:levelink_guru/providers/mata_pelajaran_provider.dart';
import 'package:levelink_guru/widget/confirm_dialog.dart';
import 'package:levelink_guru/widget/padded_widget.dart';
import 'package:provider/provider.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  void initState() {
    final kelasProvider = Provider.of<KelasProvider>(context, listen: false);
    final mataPelajaranProvider =
        Provider.of<MataPelajaranProvider>(context, listen: false);
    kelasProvider.getDaftarKelas();
    mataPelajaranProvider.getMataPelajaranDikuasai(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kelasProvider = Provider.of<KelasProvider>(context);
    final mataPelajaranProvider = Provider.of<MataPelajaranProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colour.blue,
        onPressed: () {
          if (mataPelajaranProvider.mataPelajaranDikuasai.isNotEmpty) {
            Route route = MaterialPageRoute(
              builder: (context) => const AddClassPage(
                isEditing: false,
              ),
            );
            Navigator.push(context, route);
          } else {
            confirmDialog(
              title: 'Belum Ada Mapel',
              context: context,
              confirmation: 'Tambah mata pelajaran dikuasai terlebih dahulu',
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => const MataPelajaranPage(),
                      );

                      Navigator.push(context, route);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colour.blue,
                      ),
                      child: const Center(
                        child: Text(
                          'Tambah',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'Levelink-guru.png',
          height: 35,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
      ),
      body: kelasProvider.loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('memuat')
                ],
              ),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const PaddedWidget(
                  child: Text(
                    'Daftar Kelas',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                kelasProvider.kelas.isEmpty
                    ? const ListTile(
                        title: Text('tidak ada kelas'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: kelasProvider.kelas.length,
                        itemBuilder: (context, index) {
                          Kelas kelas = kelasProvider.kelas[index];
                          return listKelas(context, kelas);
                        },
                      ),
              ],
            ),
    );
  }
}

listKelas(BuildContext context, Kelas kelas) {
  return ListTile(
    onTap: () {
      if (kelas.isPenuh == 0) {
        Route route = MaterialPageRoute(
          builder: (context) => AddClassPage(
            isEditing: true,
            kelas: kelas,
          ),
        );
        Navigator.push(context, route);
      } else {
        log('kelas penuh');
      }
    },
    shape: const Border(
      bottom: BorderSide(
        color: Color(0xFFEEEEEE),
      ),
    ),
    // isThreeLine: true,
    title: Text(
      '${kelas.mataPelajaran!.mataPelajaran!.toUpperCase()} ${kelas.mataPelajaran!.jenjangMataPelajaran!}',
      style: const TextStyle(fontSize: 14),
    ),
    subtitle: Text('${kelas.hari!}, ${kelas.jam!}'),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          NumberFormat.simpleCurrency(
            name: 'Rp. ',
            locale: 'id',
          ).format(kelas.harga),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(kelas.isPenuh == 1 ? 'penuh' : 'tersedia'),
      ],
    ),
  );
}
