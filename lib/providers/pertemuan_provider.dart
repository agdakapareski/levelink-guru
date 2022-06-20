import 'package:flutter/cupertino.dart';
import 'package:levelink_guru/api/pertemuan_api.dart';
import 'package:levelink_guru/model/pertemuan_model.dart';

class PertemuanProvider extends ChangeNotifier {
  List<Pertemuan> pertemuans = [];
  Pertemuan pertemuan = Pertemuan();
  bool isLoading = false;

  getPertemuanAktif() async {
    isLoading = true;
    pertemuan = await PertemuanApi().getPertemuanAktif();
    isLoading = false;
    notifyListeners();
  }

  getPertemuan() async {
    isLoading = true;
    pertemuans = await PertemuanApi().getPertemuan();
    isLoading = false;
    notifyListeners();
  }

  storePertemuan(Pertemuan p) async {
    await PertemuanApi().storePertemuan(p);

    pertemuan = await PertemuanApi().getPertemuanAktif();
    notifyListeners();
  }
}
