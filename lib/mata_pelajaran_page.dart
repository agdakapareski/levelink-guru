import 'package:flutter/material.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/providers/mata_pelajaran_provider.dart';
import 'package:levelink_guru/tambah_mata_pelajaran_page.dart';
import 'package:provider/provider.dart';

class MataPelajaranPage extends StatefulWidget {
  const MataPelajaranPage({Key? key}) : super(key: key);

  @override
  State<MataPelajaranPage> createState() => _MataPelajaranPageState();
}

class _MataPelajaranPageState extends State<MataPelajaranPage> {
  @override
  void initState() {
    final mataPelajaranProvider = Provider.of<MataPelajaranProvider>(
      context,
      listen: false,
    );
    mataPelajaranProvider.getMataPelajaran();
    mataPelajaranProvider.getMataPelajaranDikuasai(currentid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mataPelajaranProvider = Provider.of<MataPelajaranProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'MATA PELAJARAN',
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => const TambahMataPelajaranPage(),
          );

          Navigator.push(context, route);
        },
        backgroundColor: Colour.blue,
        child: const Icon(Icons.add),
      ),
      body: mataPelajaranProvider.mataPelajaranDikuasai.isEmpty
          ? const ListTile(
              title: Text('belum ada mata pelajaran dikuasai'),
            )
          : ListView.builder(
              itemCount: mataPelajaranProvider.mataPelajaranDikuasai.length,
              itemBuilder: (context, index) {
                // if (mataPelajaranProvider.mataPelajaranDikuasai.isEmpty) {
                //   return const ListTile(
                //     title: Text('belum ada mata pelajaran dikuasai'),
                //   );
                // }
                return ListTile(
                  shape: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                  title: Text(
                    mataPelajaranProvider.mataPelajaranDikuasai[index]
                        .mataPelajaran!.mataPelajaran!,
                  ),
                  trailing: Text(
                    mataPelajaranProvider.mataPelajaranDikuasai[index]
                        .mataPelajaran!.jenjangMataPelajaran!,
                  ),
                );
              }),
    );
  }
}
