// To parse this JSON data, do
//
//     final symptoms = symptomsFromJson(jsonString);

import 'dart:convert';

List<Symptoms> symptomsFromJson(String str) =>
    List<Symptoms>.from(json.decode(str).map((x) => Symptoms.fromJson(x)));

String symptomsToJson(List<Symptoms> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Symptoms {
  Symptoms({
    this.id,
    this.pId,
    this.fever,
    this.cough,
    this.difficultyBreathing,
    this.chills,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String pId;
  String fever;
  String cough;
  String difficultyBreathing;
  String chills;
  DateTime createdAt;
  DateTime updatedAt;

  factory Symptoms.fromJson(Map<String, dynamic> json) => Symptoms(
        id: json["id"],
        pId: json["p_id"],
        fever: json["fever"],
        cough: json["cough"],
        difficultyBreathing: json["difficulty_breathing"],
        chills: json["chills"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "p_id": pId,
        "fever": fever,
        "cough": cough,
        "difficulty_breathing": difficultyBreathing,
        "chills": chills,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
