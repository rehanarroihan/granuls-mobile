class PengujianTanahResponse {
  String? id;
  String? idUser;
  String? idTumbuhan;
  String? idDevice;
  String? idTipeTanah;
  int? ph;
  String? title;
  int? n;
  int? p;
  int? k;
  String? tipe;

  PengujianTanahResponse(
      {this.id,
        this.idUser,
        this.idTumbuhan,
        this.idDevice,
        this.idTipeTanah,
        this.n,
        this.p,
        this.k,
        this.ph,
        this.title,
        this.tipe});

  PengujianTanahResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idTumbuhan = json['id_tumbuhan'];
    idDevice = json['id_device'];
    idTipeTanah = json['id_tipe_tanah'];
    ph = json['Ph'];
    title = json['title'];
    n = json['n'].toDouble();
    p = json['p'].toDouble();
    k = json['k'].toDouble();
    tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_tumbuhan'] = this.idTumbuhan;
    data['id_device'] = this.idDevice;
    data['id_tipe_tanah'] = this.idTipeTanah;
    data['N'] = this.n;
    data['P'] = this.p;
    data['K'] = this.k;
    data['Ph'] = this.ph;
    data['title'] = this.title;
    data['n'] = this.n;
    data['p'] = this.p;
    data['k'] = this.k;
    data['tipe'] = this.tipe;
    return data;
  }
}