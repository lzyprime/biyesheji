enum EnumSex { male, female, obscure }

class UserData {
  static final Map<int, UserData> _cache = {};

  int id;
  String username;
  String email;
  EnumSex sex;

  UserData({this.id, this.username, this.email, this.sex}) {
    _cache[id] = this;
  }

  UserData.fromJson(json)
      : id = json["id"] ?? 0,
        username = json["username"] ?? "",
        email = json["email"] ?? "",
        sex = EnumSex.values[json["sex"] ?? 2] {
    _cache[id] = this;
  }

  factory UserData.fromCache(int uid) => _cache[uid] ?? UserData(id: 0);
}
