/// @author jd

class Message {
  const Message({
    this.time,
    this.message,
    this.isMe,
    this.name,
  });
  final String time;
  final String message;
  final bool isMe;
  final String name;
}
