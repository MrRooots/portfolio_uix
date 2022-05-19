class RecordModel {
  final int? wordsCount;

  // Todo: implement dates
  final DateTime? date;

  const RecordModel({required final this.wordsCount, final this.date});

  factory RecordModel.fromJson({required final Map<String, dynamic> json}) =>
      RecordModel(wordsCount: json['wordsCount']);

  Map<String, dynamic> toJson() => {'wordsCount': wordsCount};

  RecordModel copyWith({final int? wordsCount}) =>
      RecordModel(wordsCount: wordsCount ?? this.wordsCount);
}
