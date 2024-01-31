class Projects {
   String?name;
   String?description;

   String?url;
   String?id;

  Projects({this.name, this.description,  this.url,this.id});

  Projects.fromJson(Map<String, dynamic> json, String id) {
    name = json['name'];
    description = json['description'];
    url = json['url'];
    this.id = id;

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']=this.name;
    data['description']=this.description;
    data['url']=this.url;
    return data;
  }


}