class FAQModel {
  int? id;
  String? question;
  String? answer;
  bool? enabled;

  FAQModel({this.id, this.question, this.answer, this.enabled});

  FAQModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    answer = json["answer"];
    enabled = json["enabled"];
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "question": question, "answer": answer, "enabled": enabled};
}
