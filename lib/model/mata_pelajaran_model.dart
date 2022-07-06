import 'package:levelink_guru/model/guru_model.dart';

class MataPelajaran {
  int? id;
  String? mataPelajaran;
  String? jenjangMataPelajaran;

  MataPelajaran({
    this.id,
    this.mataPelajaran,
    this.jenjangMataPelajaran,
  });
}

class MataPelajaranDikuasai {
  int? id;
  Guru? guru;
  MataPelajaran? mataPelajaran;

  MataPelajaranDikuasai({
    this.id,
    this.guru,
    this.mataPelajaran,
  });
}
