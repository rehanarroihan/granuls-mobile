class PengujianTanahRequest {
  String? id;
  String? title;
  String? idUser;
  String? idTumbuhan;
  String? idDevice;
  String? idTipeTanah;
  int? n;
  int? p;
  int? k;
  int? ph;

  PengujianTanahRequest(
      {this.id,
        this.title,
        this.idUser,
        this.idTumbuhan,
        this.idDevice,
        this.idTipeTanah,
        this.n,
        this.p,
        this.k,
        this.ph});

  PengujianTanahRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    idUser = json['id_user'];
    idTumbuhan = json['id_tumbuhan'];
    idDevice = json['id_device'];
    idTipeTanah = json['id_tipe_tanah'];
    n = json['n'];
    p = json['p'];
    k = json['k'];
    ph = json['ph'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['id_user'] = this.idUser;
    data['id_tumbuhan'] = this.idTumbuhan;
    data['id_device'] = this.idDevice;
    data['id_tipe_tanah'] = this.idTipeTanah;
    data['n'] = this.n;
    data['p'] = this.p;
    data['k'] = this.k;
    data['ph'] = this.ph;
    return data;
  }
}