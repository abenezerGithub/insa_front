// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String uid;
  final String name;
  final String username;
  final String token;
  User({
    required this.id,
    required this.uid,
    required this.name,
    required this.username,
    required this.token,
  });
  

  User copyWith({
    int? id,
    String? uid,
    String? name,
    String? username,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
      'username': username,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      uid: map['uid'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, uid: $uid, name: $name, username: $username, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.uid == uid &&
      other.name == name &&
      other.username == username &&
      other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      name.hashCode ^
      username.hashCode ^
      token.hashCode;
  }
}
