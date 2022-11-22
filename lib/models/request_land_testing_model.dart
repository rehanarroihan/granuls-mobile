class RequestLandTestingModel {
  String? id;
  String? deviceId;
  String? title;
  String? tester;
  String? startAt;
  String? endAt;
  double? lat;
  double? lng;
  String? kab;

  RequestLandTestingModel(
      {this.id,
        this.deviceId,
        this.title,
        this.tester,
        this.startAt,
        this.endAt,
        this.lat,
        this.lng,
        this.kab});

  RequestLandTestingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    title = json['title'];
    tester = json['tester'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    lat = json['lat'];
    lng = json['lng'];
    kab = json['kab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['title'] = this.title;
    data['tester'] = this.tester;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['kab'] = this.kab;
    return data;
  }
}