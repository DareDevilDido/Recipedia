class instructionsRepo{
  String? ID;
  String Description;

instructionsRepo(
      {required this.ID,
      required this.Description});
static instructionsRepo fromJson(String notId, Map<String, dynamic> data) 
{
    return instructionsRepo(
        ID: notId,
        Description: data["Description"].toString());
       
}
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Description"] = Description;
    return data;
  }
}
