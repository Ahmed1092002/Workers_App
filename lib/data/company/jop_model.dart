class JopsModel {
   String? jopid;
   String? title;
   String? description;
    String? companyImageUrl;
   String? location;
   String? Salary;
   String ? jopType;
   String? userEmail;
    List<String>? Skills;
    String? Experience;
    String? jobLevel;
    String? jobShift;
    String ? companyUid;
    String ? workingField;
    String ? jopField;
    String ? companyname;
    String ? companyInfo;
String ? date;
String ?country;





  JopsModel({
    this.jopid,
    this.title,
    this.description,
    this.companyImageUrl,
    this.jobLevel,
    this.jobShift,
    this.Experience,
    this.Skills,
    this.location,
    this.Salary,
    this.userEmail,
    this.jopField,
    this.companyname,
    this.companyInfo,
    this.companyUid,
    this.workingField,
    this.date,
    this.jopType,
    this.country

  });

  JopsModel.fromJson(Map<String, dynamic> json, String id) {
    jopid = id;
    title = json['title'];
    description = json['description'];
    location = json['location'];
    Salary = json['Salary'];
    userEmail = json['userEmail'];
    jopType = json['jopType'];
    jopField = json['jobField'];
    companyname = json['companyname'];
    companyInfo = json['companyInfo'];
    Skills = json['Skills'].cast<String>();
    companyImageUrl = json['companyImageUrl'];
    jobLevel = json['jobLevel'];
    jobShift = json['jobShift'];
    Experience = json['Experience'];
    companyUid = json['companyUid'];
    workingField = json['workingField'];
    date = json['date'];
    country = json['country'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jopid'] = this.jopid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['companyImageUrl'] = this.companyImageUrl;
    data['jobLevel'] = this.jobLevel;
    data['jobShift'] = this.jobShift;

    data['location'] = this.location;
    data['Salary'] = this.Salary;
    data['userEmail'] = this.userEmail;
    data['jopType'] = this.jopType;
    data['jobField'] = this.jopField;
    data['Skills'] = this.Skills;


    data['country'] = this.country;
    data['companyname'] = this.companyname;
    data['Experience'] = this.Experience;
    data['companyUid'] = this.companyUid;
    data['workingField'] = this.workingField;
    data['companyInfo'] = this.companyInfo;
    data['date'] = this.date;
    return data;
  }
}