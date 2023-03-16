class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  PostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.postImage,
    this.text,
    this.image,
  });
  PostModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
      'uId': uId,
      'image': image,
    };
  }
}
