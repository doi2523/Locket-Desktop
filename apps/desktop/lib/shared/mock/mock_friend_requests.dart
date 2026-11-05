import '../models/chat_models.dart';

class MockFriendRequests {
  static final List<FriendRequest> receivedRequests = [
    FriendRequest(
      id: 'req_r1',
      user: const ChatUser(
        id: 'u_r1',
        name: 'Lê Hoàng Nam',
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
        isOnline: true,
      ),
      timestamp: DateTime.now().subtract(const Duration(minutes: 42)),
      mutualFriends: '4 bạn chung (có Thảo My, Hải Đăng)',
      message: 'Chào bạn, mình thấy bạn trên Locket trường Đại học Bách Khoa 👋',
      isSent: false,
    ),
    FriendRequest(
      id: 'req_r2',
      user: const ChatUser(
        id: 'u_r2',
        name: 'Đỗ Thu Trang',
        avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
        isOnline: false,
        lastActive: '30 phút trước',
      ),
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      mutualFriends: '2 bạn chung (có Lan Anh)',
      message: 'Kết bạn Locket share khoảnh khắc cafe mỗi ngày nhé! ☕💛',
      isSent: false,
    ),
    FriendRequest(
      id: 'req_r3',
      user: const ChatUser(
        id: 'u_r3',
        name: 'Nguyễn Đức Huy',
        avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
        isOnline: true,
      ),
      timestamp: DateTime.now().subtract(const Duration(hours: 18)),
      mutualFriends: 'Từ danh bạ điện thoại của bạn',
      message: 'Mình là Huy bên team Designer nè!',
      isSent: false,
    ),
  ];

  static final List<FriendRequest> sentRequests = [
    FriendRequest(
      id: 'req_s1',
      user: const ChatUser(
        id: 'u_s1',
        name: 'Bùi Quỳnh Nga',
        avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200',
        isOnline: true,
      ),
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isSent: true,
    ),
    FriendRequest(
      id: 'req_s2',
      user: const ChatUser(
        id: 'u_s2',
        name: 'Phạm Quốc Bảo',
        avatarUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=200',
        isOnline: false,
        lastActive: 'Hôm qua',
      ),
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      mutualFriends: '1 bạn chung',
      message: null,
      isSent: true,
    ),
  ];
}
