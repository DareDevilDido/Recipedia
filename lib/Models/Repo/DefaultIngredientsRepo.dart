class DefaultIngredientsRepo {
  String image;
  String Name;
  String timesused;
  String? ID;

  DefaultIngredientsRepo(
      {required this.image,
      required this.Name,
      required this.timesused,
      this.ID});

  static DefaultIngredientsRepo fromJson(
      String notId, Map<String, dynamic> data) {
    return DefaultIngredientsRepo(
        image: data["Image"].toString(),
        timesused: data["TimesUsed"].toString(),
        Name: data["Name"].toString(),
        ID: notId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Image"] = image;
    data["TimesUsed"] = timesused;
    data["Name"] = Name;
    data["TimesUsed"] = 0;
    return data;
  }
}
