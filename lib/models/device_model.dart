class DeviceModel {
  String? id;
  String? idDevice;
  String? versi;
  String? createdAt;
  String? kodeDevice;

  DeviceModel({this.id, this.idDevice, this.versi, this.createdAt, this.kodeDevice});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idDevice = json['id_device'];
    versi = json['versi'];
    createdAt = json['created_at'];
    kodeDevice = json['kode_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_device'] = this.idDevice;
    data['versi'] = this.versi;
    data['created_at'] = this.createdAt;
    data['kode_device'] = this.kodeDevice;
    return data;
  }
}