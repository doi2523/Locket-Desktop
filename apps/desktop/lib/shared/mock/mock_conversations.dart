import '../models/chat_models.dart';
import 'mock_users.dart';

class MockConversations {
  static final List<Conversation> conversations = [
    Conversation(
      id: 'c1',
      user: MockUsers.thaoMy,
      lastMessage: 'Vừa gửi bạn một khoảnh khắc Locket 💛',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 2)),
      unreadCount: 2,
      isPinned: true,
    ),
    Conversation(
      id: 'c2',
      user: MockUsers.haiDang,
      lastMessage: 'Tối nay đi cafe bàn về tính năng mới nhé bro!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 18)),
      unreadCount: 0,
      isPinned: true,
    ),
    Conversation(
      id: 'c3',
      user: MockUsers.lanAnh,
      lastMessage: 'Caption ảnh này đẹp quá, chỉ mình cách chỉnh với 🥰',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 1,
    ),
    Conversation(
      id: 'c4',
      user: MockUsers.locketDevTeam,
      lastMessage: 'Build Windows & iOS đã sync thành công qua GitHub Actions!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 0,
    ),
    Conversation(
      id: 'c5',
      user: MockUsers.minhQuan,
      lastMessage: 'Ok bạn ơi, mai hẹn gặp lúc 9h sáng nhé!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
      unreadCount: 0,
    ),
    Conversation(
      id: 'c6',
      user: MockUsers.phuongLinh,
      lastMessage: 'Đã xem ảnh dạo phố của cậu rồi nè, siêu xinh!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 7)),
      unreadCount: 3,
    ),
    Conversation(
      id: 'c7',
      user: MockUsers.anhTuan,
      lastMessage: 'Cuối tuần đi Ba Vì săn mây không ông?',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
    ),
    Conversation(
      id: 'c8',
      user: MockUsers.khanhHuyen,
      lastMessage: 'Gửi mình xin link bài hát trong moment với nha 🎵',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
    ),
  ];
}
