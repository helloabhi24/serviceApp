class ChatRoomModel {
  String? chatroomId;
  Map<String, dynamic>? participents;
  String? lastMessage;
  ChatRoomModel({this.lastMessage, this.chatroomId, this.participents});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomId = map["chatroomId"];
    participents = map["participents"];
  }

  Map<String, dynamic> toMap() {
    return {"chatroomId": chatroomId, "participents": participents};
  }
}