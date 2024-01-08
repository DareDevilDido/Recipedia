class InstructionsRepo {
  String Description;
  String Step;
  String ID;
  InstructionsRepo(
      {required this.Description, required this.Step, required this.ID});

  static InstructionsRepo fromJson(String notId, Map<String, dynamic> data) {
    return InstructionsRepo(
        ID: notId,
        Description: data["Description"].toString(),
        Step: data["Step"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Description"] = Description;
    data["Step"] = Step;
    return data;
  }
}
