import 'package:levelink_guru/model/kelas_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';

class Jadwal {
  int? id;
  Siswa? siswa;
  Kelas? kelas;
  int? isAktif;

  Jadwal({
    this.id,
    this.siswa,
    this.kelas,
    this.isAktif,
  });
}
