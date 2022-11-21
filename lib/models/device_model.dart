class DeviceModel {
  String? idDevice;
  String? versi;
  String? createdAt;
  String? kodeDevice;

  DeviceModel({this.idDevice, this.versi, this.createdAt, this.kodeDevice});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    idDevice = json['id_device'];
    versi = json['versi'];
    createdAt = json['created_at'];
    kodeDevice = json['kode_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_device'] = this.idDevice;
    data['versi'] = this.versi;
    data['created_at'] = this.createdAt;
    data['kode_device'] = this.kodeDevice;
    return data;
  }
}