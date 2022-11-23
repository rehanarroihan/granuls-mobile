class FertilizerResponseModel {
  String? nama;
  String? komposisi;
  String? foto;
  int? takaran;
  int? group;
  String? tipe;

  FertilizerResponseModel(
      {this.nama,
        this.komposisi,
        this.foto,
        this.takaran,
        this.group,
        this.tipe});

  FertilizerResponseModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    komposisi = json['komposisi'];
    foto = json['foto'];
    takaran = json['takaran'];
    group = json['group'];
    tipe = json['tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['komposisi'] = this.komposisi;
    data['foto'] = this.foto;
    data['takaran'] = this.takaran;
    data['group'] = this.group;
    data['tipe'] = this.tipe;
    return data;
  }
}