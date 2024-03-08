import 'dart:convert';

class SingleHadithDetailModel {
  int? hadithId;
  String? narrator;
  String? bn;
  String? ar;
  int? gradeId;
  String? grade;
  String? gradeColor;
  dynamic note;
  Chapter? chapter;
  DateTime? timeStamp;

  SingleHadithDetailModel({
    this.hadithId,
    this.narrator,
    this.bn,
    this.ar,
    this.gradeId,
    this.grade,
    this.gradeColor,
    this.note,
    this.chapter,
    this.timeStamp,
  });

  SingleHadithDetailModel copyWith({
    int? hadithId,
    String? narrator,
    String? bn,
    String? ar,
    int? gradeId,
    String? grade,
    String? gradeColor,
    dynamic note,
    Chapter? chapter,
    DateTime? timeStamp,
  }) =>
      SingleHadithDetailModel(
        hadithId: hadithId ?? this.hadithId,
        narrator: narrator ?? this.narrator,
        bn: bn ?? this.bn,
        ar: ar ?? this.ar,
        gradeId: gradeId ?? this.gradeId,
        grade: grade ?? this.grade,
        gradeColor: gradeColor ?? this.gradeColor,
        note: note ?? this.note,
        chapter: chapter ?? this.chapter,
        timeStamp: timeStamp ?? this.timeStamp,
      );

  factory SingleHadithDetailModel.fromRawJson(String str) => SingleHadithDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleHadithDetailModel.fromJson(Map<String, dynamic> json) => SingleHadithDetailModel(
      hadithId: json["hadith_id"],
      narrator: json["narrator"],
      bn: json["bn"],
      ar: json["ar"],
      gradeId: json["grade_id"],
      grade: json["grade"],
      gradeColor: json["grade_color"],
      note: json["note"],
      chapter: json["chapter"] == null ? null : Chapter.fromJson(json["chapter"]),
      timeStamp:json['timeStamp'] != null ? DateTime.tryParse(json['timeStamp']!) : null);

  Map<String, dynamic> toJson() => {
        "hadith_id": hadithId,
        "narrator": narrator,
        "bn": bn,
        "ar": ar,
        "grade_id": gradeId,
        "grade": grade,
        "grade_color": gradeColor,
        "note": note,
        "chapter": chapter?.toJson(),
        "timeStamp": timeStamp?.toIso8601String(),
      };

  Map<String, String> toJsonNotification() => {
        "hadith_id": hadithId?.toString() ?? '',
        "narrator": narrator ?? '',
        "bn": bn ?? '',
        "ar": ar ?? '',
        "grade_id": gradeId?.toString() ?? '',
        "grade": grade ?? '',
        "grade_color": gradeColor ?? '',
        "note": note?.toString() ?? '',
        "chapter": chapter?.toJson().toString() ?? '',
        "timeStamp": timeStamp?.toIso8601String() ?? '',
      };

  SingleHadithDetailModel.fromJsonNotification(Map<String, String?> json) {
    hadithId = int.tryParse(json['hadithId'] ?? ''); // Convert to int
    narrator = json['narrator'];
    bn = json['bn'];
    ar = json['ar'];
    gradeId = int.tryParse(json['gradeId'] ?? ''); // Convert to int
    grade = json['grade'];
    gradeColor = json['gradeColor'];
    note = json['note']; // Leave as dynamic (could be string or other types)
    chapter = json['chapter'] != null ? Chapter.fromJson(jsonDecode(json['chapter']!)) : null;
    timeStamp = json['timeStamp'] != null ? DateTime.tryParse(json['timeStamp']!) : null;
  }
}

class Chapter {
  String? chapterNumber;

  Chapter({
    this.chapterNumber,
  });

  Chapter copyWith({
    String? chapterNumber,
  }) =>
      Chapter(
        chapterNumber: chapterNumber ?? this.chapterNumber,
      );

  factory Chapter.fromRawJson(String str) => Chapter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterNumber: json["chapter_number"],
      );

  Map<String, dynamic> toJson() => {
        "chapter_number": chapterNumber,
      };
}
