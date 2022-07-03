import 'package:levelink_guru/model/guru_model.dart';
import 'package:levelink_guru/model/siswa_model.dart';

class Rating {
  int? id;
  Siswa? siswa;
  Guru? guru;
  double? rating;
  String? evaluasi;

  Rating({
    this.id,
    this.siswa,
    this.guru,
    this.rating,
    this.evaluasi,
  });
}

class SummaryRating {
  List<Rating>? rating;
  double? rataRating;

  SummaryRating({
    this.rating,
    this.rataRating,
  });
}
