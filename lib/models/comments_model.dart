class CommentsModel {
  String? userName;
  String? userImage;
  String? postId;
  String? dateTime;
  String? text;

  CommentsModel({
    this.userName,
    this.userImage,
    this.postId,
    this.dateTime,
    this.text,
  });
  CommentsModel.fromjson(Map<String, dynamic> json) {
    userName = json['userName'];
    postId = json['postId'];
    userImage = json['userImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImage': userImage,
      'dateTime': dateTime,
      'text': text,
      'postId': postId,
    };
  }
}
