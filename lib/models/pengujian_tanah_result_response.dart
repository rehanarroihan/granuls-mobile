class PengujianTanahResultResponse {
  double? n;
  double? p;
  double? k;
  String? kualitas;
  String? idTipeTanah;

  PengujianTanahResultResponse(
      {this.n, this.p, this.k, this.kualitas, this.idTipeTanah});

  PengujianTanahResultResponse.fromJson(Map<String, dynamic> json) {
    n = json['n'].toDouble();
    p = json['p'].toDouble();
    k = json['k'].toDouble();
    kualitas = json['kualitas'];
    idTipeTanah = json['id_tipe_tanah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n'] = this.n;
    data['p'] = this.p;
    data['k'] = this.k;
    data['kualitas'] = this.kualitas;
    data['id_tipe_tanah'] = this.idTipeTanah;
    return data;
  }
}