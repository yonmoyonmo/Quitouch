class Category {
  static final columns = ["id", "name"];
  String id = "null";
  String name = "null";

  Category();
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": name,
    };
    if (id != "null") {
      map["id"] = id;
    }
    return map;
  }

  static Category fromMap(Map map) {
    Category cate = Category();
    cate.id = map["id"];
    cate.name = map["name"];
    return cate;
  }
}
