import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:levelink_guru/list_data.dart';
import 'package:levelink_guru/model/kelas_model.dart';

class KelasApi {
  /// Fungsi untuk mengambil list kelas dari database
  getKelas() async {
    var url = Uri.parse('$mainUrl/kelas/$currentid');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var datas = body['data'];

      List<Kelas> kelass = [];

      for (var data in datas) {
        kelass.add(Kelas.fromJson(data));
      }

      return kelass;
    }
  }
}
