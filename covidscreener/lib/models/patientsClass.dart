// To parse this JSON data, do
//
//     final patients = patientsFromJson(jsonString);

import 'dart:convert';

List<Patients> patientsFromJson(String str) =>
    List<Patients>.from(json.decode(str).map((x) => Patients.fromJson(x)));

String patientsToJson(List<Patients> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patients {
  Patients({
    this.id,
    this.pName,
    this.pEmail,
    this.pUsername,
    this.pPhoneNumber,
    this.pPassword,
    this.pDob,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String pName;
  String pEmail;
  String pUsername;
  String pPhoneNumber;
  String pPassword;
  DateTime pDob;
  DateTime createdAt;
  DateTime updatedAt;

  factory Patients.fromJson(Map<String, dynamic> json) => Patients(
        id: json["id"],
        pName: json["p_name"],
        pEmail: json["p_email"],
        pUsername: json["p_username"],
        pPhoneNumber: json["p_phone_number"],
        pPassword: json["p_password"],
        pDob: DateTime.parse(json["p_dob"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "p_name": pName,
        "p_email": pEmail,
        "p_username": pUsername,
        "p_phone_number": pPhoneNumber,
        "p_password": pPassword,
        "p_dob":
            "${pDob.year.toString().padLeft(4, '0')}-${pDob.month.toString().padLeft(2, '0')}-${pDob.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
