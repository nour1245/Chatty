class MessageModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderId,
    this.reciverId,
    this.dateTime,
    this.text,
  });
  MessageModel.fromjson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    reciverId = json['reciverId'];

    dateTime = json['dateTime'];

    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'dateTime': dateTime,
      'text': text,
      'reciverId': reciverId,
    };
  }
}
