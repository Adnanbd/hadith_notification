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
    );

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
    };
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
