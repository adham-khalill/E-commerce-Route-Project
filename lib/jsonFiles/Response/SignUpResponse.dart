/// message : "success"
/// user : {"name":"Ahmed Abd Al-Muti","email":"ahmedmut@mail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZGM3MmJjNWFmMzQwMjllN2I4NzIzOSIsIm5hbWUiOiJBaG1lZCBBYmQgQWwtTXV0aSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzI1NzIzMzI0LCJleHAiOjE3MzM0OTkzMjR9.SBtQI3Vic140xCNhqxzTkuKj8wZVtIk61oPz2WMePq0"

class SignUpResponse {
  SignUpResponse({
      this.message, 
      this.user, 
      this.token,
      this.statusMsg});

  SignUpResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
  }
  String? message;
  User? user;
  String? token;
  String? statusMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}

/// name : "Ahmed Abd Al-Muti"
/// email : "ahmedmut@mail.com"
/// role : "user"

class User {
  User({
      this.name, 
      this.email, 
      this.role,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
  String? name;
  String? email;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    return map;
  }

}