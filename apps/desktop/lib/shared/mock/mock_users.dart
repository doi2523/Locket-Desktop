import '../models/chat_models.dart';

class MockUsers {
  static const currentUser = ChatUser(
    id: 'user_me',
    name: 'Đào Văn Đôi',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    isOnline: true,
  );

  static const thaoMy = ChatUser(
    id: 'u1',
    name: 'Nguyễn Thảo My',
    avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
    isOnline: true,
  );

  static const haiDang = ChatUser(
    id: 'u2',
    name: 'Trần Hải Đăng',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    isOnline: true,
  );

  static const lanAnh = ChatUser(
    id: 'u3',
    name: 'Hoàng Lan Anh',
    avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
    isOnline: false,
    lastActive: '15 phút trước',
  );

  static const locketDevTeam = ChatUser(
    id: 'u4',
    name: 'Team Dev Locket Dio 🚀',
    avatarUrl: 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=200',
    isOnline: true,
  );

  static const minhQuan = ChatUser(
    id: 'u5',
    name: 'Lê Minh Quân',
    avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    isOnline: false,
    lastActive: '2 giờ trước',
  );

  static const phuongLinh = ChatUser(
    id: 'u6',
    name: 'Vũ Phương Linh',
    avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200',
    isOnline: true,
  );

  static const anhTuan = ChatUser(
    id: 'u7',
    name: 'Đặng Anh Tuấn',
    avatarUrl: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200',
    isOnline: false,
    lastActive: 'Hôm qua',
  );

  static const khanhHuyen = ChatUser(
    id: 'u8',
    name: 'Mai Khánh Huyền',
    avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200',
    isOnline: true,
  );

  static const giaBao = ChatUser(
    id: 'u9',
    name: 'Phan Gia Bảo',
    avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200',
    isOnline: false,
    lastActive: '3 giờ trước',
  );

  static const List<ChatUser> allUsers = [
    currentUser,
    thaoMy,
    haiDang,
    lanAnh,
    locketDevTeam,
    minhQuan,
    phuongLinh,
    anhTuan,
    khanhHuyen,
    giaBao,
  ];
}
