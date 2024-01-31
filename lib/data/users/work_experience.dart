class WorkExperience {
 String? company;
 String? position;
 String? period;
 String? description;
 String? startDate;
 String? endDate;
 String? id;



  WorkExperience({
     this.company,
     this.position,
     this.period,
     this.description,
    this.startDate,
    this.endDate,
    this.id,

  });

  WorkExperience.fromJson(Map<String, dynamic> json, String id) {
    company = json['company'];
    position = json['position'];
    period = json['period'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['position'] = this.position;
    data['period'] = this.period;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}