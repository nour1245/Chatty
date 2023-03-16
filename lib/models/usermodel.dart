import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? uId;

  @HiveField(5)
  bool? isVerfied;

  String? image;
  String? bio;
  String? cover;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.bio,
    this.image,
    this.cover,
    this.isVerfied,
  });
  UserModel.fromjson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    uId = json['uId'];
    cover = json['cover'];
    isVerfied = json['isVerfied'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover': cover,
      'image': image,
      'bio': bio,
      'isVerfied': isVerfied,
    };
  }
}
