import 'package:flutter/cupertino.dart';
import 'package:levelink_guru/api/mata_pelajaran_api.dart';
import 'package:levelink_guru/model/mata_pelajaran_model.dart';

class MataPelajaranProvider extends ChangeNotifier {
  List<MataPelajaranDikuasai> mataPelajaranDikuasai = [];
  bool isLoading = false;
  List<MataPelajaran> mataPelajaran = [];

  getMataPelajaranDikuasai(int idGuru) async {
    isLoading = true;
    mataPelajaranDikuasai =
        await MataPelajaranApi().getMataPelajaranDikuasai(idGuru);
    isLoading = false;

    notifyListeners();
  }

  storeMataPelajaranDikuasai(int idGuru, int idMataPelajaran) async {
    await MataPelajaranApi().storeMataPelajaranDikuasai(
      idGuru,
      idMataPelajaran,
    );

    mataPelajaranDikuasai =
        await MataPelajaranApi().getMataPelajaranDikuasai(idGuru);
    notifyListeners();
  }

  getMataPelajaran() async {
    isLoading = true;
    mataPelajaran = await MataPelajaranApi().getMataPelajaran();

    notifyListeners();
  }
}
