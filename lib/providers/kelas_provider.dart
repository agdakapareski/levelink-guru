import 'package:flutter/material.dart';
import 'package:levelink_guru/api/cart_api.dart';
import 'package:levelink_guru/api/kelas_api.dart';
import 'package:levelink_guru/model/kelas_model.dart';

class KelasProvider extends ChangeNotifier {
  List<Kelas> kelas = [];
  bool loading = false;

  getDaftarKelas() async {
    kelas = [];
    loading = true;
    kelas = await KelasApi().getKelas();
    loading = false;

    notifyListeners();
  }

  requestKelas(
    String idSiswa,
    String idGuru,
    String totalHarga,
    List<Kelas> detail,
  ) async {
    await CartApi().storeCart(idSiswa, idGuru, totalHarga, detail);

    kelas = await KelasApi().getKelas();
    notifyListeners();
  }
}
