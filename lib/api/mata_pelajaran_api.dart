import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/mata_pelajaran_model.dart';

class MataPelajaranApi {
  getMataPelajaranDikuasai(int idGuru) async {
    Uri url = Uri.parse('$mainUrl/mata-pelajaran/$idGuru');
    Response response = await get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<MataPelajaranDikuasai> mataPelajarans = [];

    if (response.statusCode == 200) {
      for (var item in data) {
        var mapel = item['mata_pelajaran'];
        MataPelajaranDikuasai mataPelajaranDikuasai = MataPelajaranDikuasai(
          id: item['id'],
          mataPelajaran: MataPelajaran(
            id: mapel['id'],
            mataPelajaran: mapel['nama_mata_pelajaran'],
            jenjangMataPelajaran: mapel['jenjang_mata_pelajaran'],
          ),
        );

        mataPelajarans.add(mataPelajaranDikuasai);
      }

      return mataPelajarans;
    }
  }

  storeMataPelajaranDikuasai(int idGuru, int idMataPelajaran) async {
    Uri url = Uri.parse('$mainUrl/add-mata-pelajaran');
    Response response = await post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(
        {
          'id_pengguna': idGuru,
          'id_mata_pelajaran': idMataPelajaran,
        },
      ),
    );

    if (response.statusCode == 200) {
      log('add mata pelajaran berhasil');
    } else {
      log(response.body);
    }
  }

  getMataPelajaran() async {
    Uri url = Uri.parse('$mainUrl/mapel');
    Response response = await get(url);

    var body = json.decode(response.body);
    var data = body['data'];

    List<MataPelajaran> mataPelajarans = [];

    if (response.statusCode == 200) {
      for (var item in data) {
        MataPelajaran mataPelajaran = MataPelajaran(
          id: item['id'],
          mataPelajaran: item['nama_mata_pelajaran'],
          jenjangMataPelajaran: item['jenjang_mata_pelajaran'],
        );

        mataPelajarans.add(mataPelajaran);
      }

      return mataPelajarans;
    }
  }
}
