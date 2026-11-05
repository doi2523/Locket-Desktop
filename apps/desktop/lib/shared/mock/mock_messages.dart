import '../models/chat_models.dart';
import 'mock_users.dart';

class MockMessages {
  static final Map<String, List<ChatMessage>> messages = {
    // c1: Thảo My
    'c1': [
      ChatMessage(
        id: 'm1_1',
        senderId: MockUsers.thaoMy.id,
        text: 'Alo Đôi ơi, check Locket Dio mới xem!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        isMe: false,
      ),
      ChatMessage(
        id: 'm1_2',
        senderId: MockUsers.currentUser.id,
        text: 'Đang mở nè, UI giao diện Zalo kết hợp Locket nhìn mượt phết!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
        isMe: true,
      ),
      ChatMessage(
        id: 'm1_3',
        senderId: MockUsers.thaoMy.id,
        text: 'Vừa đăng một moment hoàng hôn chiều nay nè 🌅',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isMe: false,
        isLocketMoment: true,
        mediaUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
        caption: 'Chiều hoàng hôn lộng gió bên bờ hồ Tây ✨',
      ),
      ChatMessage(
        id: 'm1_4',
        senderId: MockUsers.currentUser.id,
        text: 'Góc chụp này đỉnh quá, thêm bài hát của Bray nữa chuẩn bài luôn 💛',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isMe: true,
      ),
    ],

    // c2: Hải Đăng
    'c2': [
      ChatMessage(
        id: 'm2_1',
        senderId: MockUsers.haiDang.id,
        text: 'Bro xem qua bản build Windows x64 mới nhất chưa?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: false,
      ),
      ChatMessage(
        id: 'm2_2',
        senderId: MockUsers.currentUser.id,
        text: 'Chạy ngon lắm, đã cấu hình xong installer Inno Setup rồi nhé.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
        isMe: true,
      ),
      ChatMessage(
        id: 'm2_3',
        senderId: MockUsers.haiDang.id,
        text: 'Đang ngồi cày đêm fix nốt animation Hero zoom ảnh nè 💻',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        isMe: false,
        isLocketMoment: true,
        mediaUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
        caption: 'Code thâu đêm cùng Locket Dio team 🚀',
      ),
      ChatMessage(
        id: 'm2_4',
        senderId: MockUsers.haiDang.id,
        text: 'Tối nay đi cafe bàn về tính năng mới nhé bro!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
        isMe: false,
      ),
    ],

    // c3: Lan Anh
    'c3': [
      ChatMessage(
        id: 'm3_1',
        senderId: MockUsers.lanAnh.id,
        text: 'Hôm nay đi quán cafe tone trắng xinh cực kì nè!',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isMe: false,
        isLocketMoment: true,
        mediaUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
        caption: 'Check in quán cafe mới decor xinh xỉu ☕',
      ),
      ChatMessage(
        id: 'm3_2',
        senderId: MockUsers.currentUser.id,
        text: 'Quán này ở mạn nào thế Lan Anh?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: true,
      ),
      ChatMessage(
        id: 'm3_3',
        senderId: MockUsers.lanAnh.id,
        text: 'Caption ảnh này đẹp quá, chỉ mình cách chỉnh với 🥰',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isMe: false,
      ),
    ],

    // c4: Team Dev Locket Dio
    'c4': [
      ChatMessage(
        id: 'm4_1',
        senderId: MockUsers.locketDevTeam.id,
        text: 'Workflow GitHub Actions build DMG macOS và EXE Windows đã chạy thành công.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isMe: false,
      ),
      ChatMessage(
        id: 'm4_2',
        senderId: MockUsers.currentUser.id,
        text: 'Đã test flutter analyze và responsive layout, không còn warning nào!',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isMe: true,
      ),
      ChatMessage(
        id: 'm4_3',
        senderId: MockUsers.locketDevTeam.id,
        text: 'Build Windows & iOS đã sync thành công qua GitHub Actions!',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isMe: false,
      ),
    ],

    // c5: Lê Minh Quân
    'c5': [
      ChatMessage(
        id: 'm5_1',
        senderId: MockUsers.currentUser.id,
        text: 'Mai cậu rảnh không, qua văn phòng test thử bản desktop app nhé.',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        isMe: true,
      ),
      ChatMessage(
        id: 'm5_2',
        senderId: MockUsers.minhQuan.id,
        text: 'Ok bạn ơi, mai hẹn gặp lúc 9h sáng nhé!',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isMe: false,
      ),
    ],

    // c6: Phương Linh
    'c6': [
      ChatMessage(
        id: 'm6_1',
        senderId: MockUsers.phuongLinh.id,
        text: 'Gửi bạn ảnh chiều thu Hà Nội lộng gió nè 🍃',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        isMe: false,
        isLocketMoment: true,
        mediaUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
        caption: 'Cuối tuần đi dạo phố phường Hà Nội 🍃',
      ),
      ChatMessage(
        id: 'm6_2',
        senderId: MockUsers.phuongLinh.id,
        text: 'Đã xem ảnh dạo phố của cậu rồi nè, siêu xinh!',
        timestamp: DateTime.now().subtract(const Duration(hours: 7)),
        isMe: false,
      ),
    ],

    // c7: Anh Tuấn
    'c7': [
      ChatMessage(
        id: 'm7_1',
        senderId: MockUsers.anhTuan.id,
        text: 'Cuối tuần đi Ba Vì săn mây không ông?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isMe: false,
      ),
      ChatMessage(
        id: 'm7_2',
        senderId: MockUsers.currentUser.id,
        text: 'Đi chứ, chuẩn bị máy ảnh sẵn sàng luôn rồi!',
        timestamp: DateTime.now().subtract(const Duration(hours: 20)),
        isMe: true,
      ),
    ],

    // c8: Khánh Huyền
    'c8': [
      ChatMessage(
        id: 'm8_1',
        senderId: MockUsers.khanhHuyen.id,
        text: 'Gửi mình xin link bài hát trong moment với nha 🎵',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isMe: false,
      ),
      ChatMessage(
        id: 'm8_2',
        senderId: MockUsers.currentUser.id,
        text: 'Bài "Waiting For You" của MONO đấy cậu!',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 22)),
        isMe: true,
      ),
    ],
  };
}
