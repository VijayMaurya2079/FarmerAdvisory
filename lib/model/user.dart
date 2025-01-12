class User {
  String employeeId;
  String departmentName;
  String designationName;
  String typeName;
  String employeeName;
  String profileImage;
  String todayVisits;
  String monthVisit;
  String totalVisit;

  User({
    this.departmentName = "",
    this.designationName = "",
    this.typeName = "",
    this.employeeName = "",
    this.profileImage = "",
    this.todayVisits = "",
    this.monthVisit = "",
    this.totalVisit = "",
    this.employeeId = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      employeeId: json["pk_hrm_emp_employee_id"].toString(),
      departmentName: json["department_name"].toString(),
      designationName: json["designation_name"].toString(),
      typeName: json["type_name"].toString(),
      employeeName: json["employee_name"].toString(),
      profileImage: json["profile_image"].toString(),
      todayVisits: json["today_visits"].toString(),
      monthVisit: json["month_visit"].toString(),
      totalVisit: json["total_visit"].toString(),
    );
  }
}
