class PatienceRecord {
  static final columns = ["id", "touchCount", "cateId", "createdAt"];
  String id = "null";
  int touchCount = 0;
  String cateId = "null";
  String createdAt = DateTime.now().toString();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "touchCount": touchCount,
      "cateId": cateId,
      "createdAt": createdAt,
    };
    if (id != "null") {
      map["id"] = id;
    }
    return map;
  }

  static PatienceRecord fromMap(Map map) {
    PatienceRecord record = PatienceRecord();
    record.id = map["id"];
    record.touchCount = map["touchCount"];
    record.cateId = map["cateId"];
    record.createdAt = map["createdAt"];
    return record;
  }
}
