class UserRecipeIngredientRepo {
  String Link;
  String? ID;

  UserRecipeIngredientRepo({required this.Link, this.ID});

  static UserRecipeIngredientRepo fromJson(
      String notId, Map<String, dynamic> data) {
    return UserRecipeIngredientRepo(Link: data["Link"].toString(), ID: notId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Link"] = Link;
    return data;
  }
}
