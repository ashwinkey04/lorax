class Links {
  String self;
  String plant;
  String genus;

  Links({this.self, this.plant, this.genus});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    plant = json['plant'];
    genus = json['genus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['plant'] = this.plant;
    data['genus'] = this.genus;
    return data;
  }
}

