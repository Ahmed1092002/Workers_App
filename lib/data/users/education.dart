class Education{

  String? name;
  String? from;
  String? to;
  String? description;
  String? degree;
  String? field;
  String? grade;

  String? id;
  Education({
    this.name,
    this.from,
    this.to,
    this.description,
    this.degree,
    this.field,
    this.grade,

    this.id,
  });
  Education.fromJson(Map<String, dynamic> json, String id)
  {
    name = json['name'];
    from = json['from'];
    to = json['to'];
    description = json['description'];
    degree = json['degree'];
    field = json['field'];
    grade = json['grade'];

    this.id = id;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']=this.name;
    data['from']=this.from;
    data['to']=this.to;
    data['description']=this.description;
    data['degree']=this.degree;
    data['field']=this.field;
    data['grade']=this.grade;

    return data;
  }


}