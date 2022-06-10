import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:levelink_guru/list_data.dart';
// import 'package:levelink_guru/model/guru_model.dart';
import 'package:levelink_guru/model/jadwal_model.dart';
import 'package:levelink_guru/model/kelas_model.dart';
import 'package:levelink_guru/model/mata_pelajaran_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';

class JadwalApi {
  getJadwal(int id) async {
    var url = Uri.parse('$mainUrl/jadwal-guru/$id');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<Jadwal> jadwals = [];

    if (response.statusCode == 200) {
      for (var jadwal in data) {
        Jadwal j = Jadwal(
          siswa: Siswa(nama: jadwal['siswa']['nama_pengguna']),
          kelas: Kelas(
            mataPelajaran: MataPelajaran(
              mataPelajaran: jadwal['kelas']['mata_pelajaran_kelas']
                  ['nama_mata_pelajaran'],
            ),
            hari: jadwal['kelas']['hari'],
            jam: jadwal['kelas']['jam'],
          ),
        );

        jadwals.add(j);
      }
      return jadwals;
    }
  }
}
