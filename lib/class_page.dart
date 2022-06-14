import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levelink_guru/add_class_page.dart';
import 'package:levelink_guru/custom_theme.dart';
import 'package:levelink_guru/providers/kelas_provider.dart';
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
    kelasProvider.getDaftarKelas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kelasProvider = Provider.of<KelasProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colour.blue,
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => const AddClassPage(),
          );
          Navigator.push(context, route);
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
                Column(
                  children: kelasProvider.kelas
                      .map(
                        (kelas) => ListTile(
                          shape: const Border(
                            bottom: BorderSide(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          // isThreeLine: true,
                          title: Text(
                            kelas.mataPelajaran!.mataPelajaran!.toUpperCase(),
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
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
    );
  }
}
