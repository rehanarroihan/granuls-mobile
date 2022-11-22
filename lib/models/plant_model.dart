class PlantModel {
  String? id;
  String? namaTumbuhan;

  PlantModel({this.id, this.namaTumbuhan});

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaTumbuhan = json['nama_tumbuhan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_tumbuhan'] = this.namaTumbuhan;
    return data;
  }
}