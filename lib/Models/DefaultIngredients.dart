class DefaultIngredientsRepo {
  String image;
  String Name;
  String? ID;

  DefaultIngredientsRepo(
      {required this.image,
      required this.Name,
      this.ID});

  static DefaultIngredientsRepo fromJson(
      String notId, Map<String, dynamic> data) {
    return DefaultIngredientsRepo(
        image: data["Image"].toString(),
        Name: data["Name"].toString(),
        ID: notId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Image"] = image;
    data["Name"] = Name;
    return data;
  }
}
