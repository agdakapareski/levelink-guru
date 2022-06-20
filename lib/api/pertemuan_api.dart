import 'dart:convert';
import 'dart:developer';

import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/pertemuan_model.dart';
import 'package:http/http.dart' as http;

class PertemuanApi {
  storePertemuan(Pertemuan pertemuan) async {
    var url = Uri.parse('$mainUrl/pertemuan');
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "id_jadwal": pertemuan.idJadwal,
        "materi": pertemuan.materi,
        "is_aktif": pertemuan.isAktif,
      }),
    );

    if (response.statusCode == 200) {
      log('pertemuan berhasil dibuat');
    } else {
      log(response.body);
    }
  }

  getPertemuanAktif(int idJadwal) async {
    var url = Uri.parse('$mainUrl/show-pertemuan/$idJadwal');
    var response = await http.get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    if (response.statusCode == 200) {
      Pertemuan pertemuanAktif = Pertemuan(
        id: data['id'],
        idJadwal: data['id_jadwal'],
        materi: data['materi'],
        isAktif: data['is_aktif'],
        capaian: data['capaian'],
        evaluasi: data['evaluasi'],
      );

      return pertemuanAktif;
    } else {
      return log(response.body);
    }
  }
}
