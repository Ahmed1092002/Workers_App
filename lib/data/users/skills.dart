class SKills {
   String? name;
   String? id;



  SKills({this.name, this.id});

  SKills.fromJson(Map<String, dynamic> json, String id) {
    name = json['name'];
    this.id = id;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']=this.name;
    return data;
  }
}