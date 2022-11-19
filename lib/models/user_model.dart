class UserModel {
  String? id;
  String? username;
  String? nama;
  int? nbf;
  int? exp;
  int? iat;
  String? iss;
  String? aud;

  UserModel(
      {this.id,
        this.username,
        this.nama,
        this.nbf,
        this.exp,
        this.iat,
        this.iss,
        this.aud});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['username'];
    nama = json['nama'];
    nbf = json['nbf'];
    exp = json['exp'];
    iat = json['iat'];
    iss = json['iss'];
    aud = json['aud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['username'] = this.username;
    data['nama'] = this.nama;
    data['nbf'] = this.nbf;
    data['exp'] = this.exp;
    data['iat'] = this.iat;
    data['iss'] = this.iss;
    data['aud'] = this.aud;
    return data;
  }
}