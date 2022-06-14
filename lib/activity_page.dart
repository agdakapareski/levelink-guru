import 'package:flutter/material.dart';
import 'package:levelink_guru/widget/padded_widget.dart';

import 'custom_theme.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'Levelink-guru.png',
          height: 35,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 16,
        //     ),
        //     child: GestureDetector(
        //       child: const CircleAvatar(
        //         child: Icon(Icons.person),
        //       ),
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const AccountPage(),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          PaddedWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text('Selamat Datang, '),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Aktifitas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colour.blue,
                      width: 0.5,
                    ),
                  ),
                  height: 88,
                  child: const Center(
                    child: Text('belum ada kelas aktif'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const CustomDivider(),
          const SizedBox(
            height: 16,
          ),
          const PaddedWidget(
            child: Text(
              'Riwayat Aktifitas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
