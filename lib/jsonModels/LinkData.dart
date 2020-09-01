class LinkData {
  String self;
  String first;
  String last;

  LinkData({this.self, this.first, this.last});

  LinkData.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}