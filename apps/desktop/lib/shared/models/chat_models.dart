class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final String lastActive;

  const ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
    this.lastActive = 'Vừa xong',
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final String? mediaUrl;
  final String? caption;
  final bool isLocketMoment;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.mediaUrl,
    this.caption,
    this.isLocketMoment = false,
  });
}

class Conversation {
  final String id;
  final ChatUser user;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isPinned;

  const Conversation({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isPinned = false,
  });
}

class LocketMoment {
  final String id;
  final ChatUser author;
  final String imageUrl;
  final String caption;
  final String? musicTitle;
  final DateTime timestamp;
  final int batteryLevel;
  final Map<String, int> reactions;

  const LocketMoment({
    required this.id,
    required this.author,
    required this.imageUrl,
    required this.caption,
    this.musicTitle,
    required this.timestamp,
    this.batteryLevel = 95,
    this.reactions = const {'❤️': 12, '🔥': 5},
  });
}

class FriendRequest {
  final String id;
  final ChatUser user;
  final DateTime timestamp;
  final String? mutualFriends;
  final String? message;
  final bool isSent;

  const FriendRequest({
    required this.id,
    required this.user,
    required this.timestamp,
    this.mutualFriends,
    this.message,
    this.isSent = false,
  });
}
