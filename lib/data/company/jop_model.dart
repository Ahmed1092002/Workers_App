class JopsModel {
   String? jopid;
   String? title;
   String? description;
   String? imageUrl;
   String? location;
   int? Salary;
   String ? jopType;
   String? userEmail;
   String? Requirements;
    String? Skills;
    String? Experience;
    String ? companyUid;
    String ? workingField;
    String ? jopField;
    String ? companyname;
    String ? companyInfo;
String ? date;






  JopsModel({
    this.jopid,
    this.title,
    this.description,
    this.imageUrl,
    this.location,
    this.Salary,
    this.userEmail,
    this.jopField,
    this.companyname,
    this.companyInfo,


    this.Requirements,
    this.Skills,
    this.Experience,
    this.companyUid,
    this.workingField,
    this.date,
    this.jopType,

  });

  JopsModel.fromJson(Map<String, dynamic> json, String id) {
    jopid = id;
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    location = json['location'];
    Salary = json['Salary'];
    userEmail = json['userEmail'];
    jopType = json['jopType'];
    jopField = json['jopField'];
    companyname = json['companyname'];
    companyInfo = json['companyInfo'];

    Requirements = json['Requirements'];
    Skills = json['Skills'];
    Experience = json['Experience'];
    companyUid = json['companyUid'];
    workingField = json['workingField'];
    date = json['date'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jopid'] = this.jopid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['location'] = this.location;
    data['Salary'] = this.Salary;
    data['userEmail'] = this.userEmail;
    data['jopType'] = this.jopType;
    data['jopField'] = this.jopField;
    data['Requirements'] = this.Requirements;
    data['Skills'] = this.Skills;

    data['companyname'] = this.companyname;
    data['Experience'] = this.Experience;
    data['companyUid'] = this.companyUid;
    data['workingField'] = this.workingField;
    data['companyInfo'] = this.companyInfo;
    data['date'] = this.date;
    return data;
  }
}