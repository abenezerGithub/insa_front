// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Attachment {
  final int id;
  final String image;
  Attachment({
    required this.id,
    required this.image,
  });
  

  Attachment copyWith({
    int? id,
    String? image,
  }) {
    return Attachment(
      id: id ?? this.id,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      id: map['id'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) => Attachment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Attachment(id: $id, image: $image)';

  @override
  bool operator ==(covariant Attachment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ image.hashCode;
}
