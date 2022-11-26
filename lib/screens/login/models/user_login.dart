class UserLogin {
  String userId;
  String username;
  String deviceId;

  UserLogin(
      {required this.userId, required this.username, required this.deviceId});

  factory UserLogin.fromJson(Map<String, dynamic> jsonData) {
    return UserLogin(
      userId: jsonData['id'] ?? '',
      username: jsonData['username'] ?? '',
      deviceId: jsonData['deviceid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'username': username,
      'deviceid': deviceId,
    };
  }
}
