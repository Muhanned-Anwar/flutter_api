class StudentImage {
  late String image;
  late int studentId;
  late int id;

  StudentImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    studentId = json['student_id'];
    id = json['id'];
  }
}
