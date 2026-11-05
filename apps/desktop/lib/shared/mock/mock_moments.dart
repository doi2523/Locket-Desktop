import '../models/chat_models.dart';
import 'mock_users.dart';

class MockMoments {
  static const List<Map<String, String>> sampleFriendMoments = [
    {
      'url': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
      'caption': 'Chiều hoàng hôn lộng gió bên bờ hồ Tây ✨',
      'time': '18:30 - Hôm nay',
      'music': 'Anh Luôn Như Vậy - Bray',
    },
    {
      'url': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
      'caption': 'Code thâu đêm cùng Locket Dio team 🚀',
      'time': '12:45 - Hôm nay',
      'music': 'See Tình - Hoàng Thùy Linh',
    },
    {
      'url': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
      'caption': 'Check in quán cafe mới decor xinh xỉu ☕',
      'time': '09:15 - Hôm qua',
      'music': 'Cắt Đôi Nỗi Sầu - Tăng Duy Tân',
    },
    {
      'url': 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
      'caption': 'Cuối tuần đi dạo phố phường Hà Nội 🍃',
      'time': '17:20 - 28/10',
      'music': 'Bật Tình Yêu Lên - Hòa Minzy',
    },
    {
      'url': 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
      'caption': 'Bình minh trên đỉnh núi Ba Vì mờ sương 🌄',
      'time': '06:00 - 26/10',
      'music': 'Nơi Này Có Anh - Sơn Tùng M-TP',
    },
    {
      'url': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
      'caption': 'Thác nước hùng vĩ giữa rừng xanh mát lành 🌊',
      'time': '14:10 - 24/10',
      'music': 'Waiting For You - MONO',
    },
    {
      'url': 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      'caption': 'Góc làm việc chill cuối tuần cùng headphone 🎧',
      'time': '21:05 - 23/10',
      'music': 'Chuyện Đôi Ta - Emcee L, Muộii',
    },
    {
      'url': 'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?w=800',
      'caption': 'Mùa thu rụng lá vàng rực con đường Phan Đình Phùng 🍂',
      'time': '16:40 - 22/10',
      'music': 'Thu Cuối - Mr.T, Yanbi',
    },
    {
      'url': 'https://images.unsplash.com/photo-1518495973542-4542c06a5843?w=800',
      'caption': 'Tia nắng chiều len qua tán lá sồi 🌿',
      'time': '15:20 - 20/10',
      'music': 'Ánh Nắng Của Anh - Đức Phúc',
    },
    {
      'url': 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800',
      'caption': 'Chuyến road trip ven biển ngắm mây trời 🚗🌊',
      'time': '10:00 - 18/10',
      'music': 'Bài Này Chill Phết - Đen Vâu, Min',
    },
    {
      'url': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800',
      'caption': 'Fix xong bug Flutter Web CanvasKit cực mượt 💻',
      'time': '02:30 - 16/10',
      'music': 'Đi Về Nhà - Đen Vâu, JustaTee',
    },
    {
      'url': 'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800',
      'caption': 'Hoàng hôn Santorini ngắm biển Aegean rực rỡ 🏛️',
      'time': '19:15 - 14/10',
      'music': 'Có Em Chờ - Min',
    },
  ];

  static final List<LocketMoment> feedMoments = [
    LocketMoment(
      id: 'lm1',
      author: MockUsers.thaoMy,
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
      caption: 'Chiều hoàng hôn lộng gió bên bờ hồ Tây ✨',
      musicTitle: 'Anh Luôn Như Vậy - Bray',
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      batteryLevel: 88,
      reactions: const {'❤️': 24, '🔥': 15, '✨': 8},
    ),
    LocketMoment(
      id: 'lm2',
      author: MockUsers.haiDang,
      imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
      caption: 'Code thâu đêm cùng Locket Dio team 🚀',
      musicTitle: 'See Tình - Hoàng Thùy Linh',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      batteryLevel: 62,
      reactions: const {'🔥': 32, '⚡': 18, '💻': 9},
    ),
    LocketMoment(
      id: 'lm3',
      author: MockUsers.lanAnh,
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
      caption: 'Check in quán cafe mới decor xinh xỉu ☕',
      musicTitle: 'Cắt Đôi Nỗi Sầu - Tăng Duy Tân',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      batteryLevel: 95,
      reactions: const {'❤️': 18, '🥰': 12},
    ),
    LocketMoment(
      id: 'lm4',
      author: MockUsers.phuongLinh,
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
      caption: 'Cuối tuần đi dạo phố phường Hà Nội 🍃',
      musicTitle: 'Bật Tình Yêu Lên - Hòa Minzy',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      batteryLevel: 73,
      reactions: const {'❤️': 45, '🍃': 20},
    ),
    LocketMoment(
      id: 'lm5',
      author: MockUsers.anhTuan,
      imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
      caption: 'Bình minh trên đỉnh núi Ba Vì mờ sương 🌄',
      musicTitle: 'Nơi Này Có Anh - Sơn Tùng M-TP',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      batteryLevel: 54,
      reactions: const {'🌄': 29, '🔥': 14},
    ),
    LocketMoment(
      id: 'lm6',
      author: MockUsers.khanhHuyen,
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
      caption: 'Thác nước hùng vĩ giữa rừng xanh mát lành 🌊',
      musicTitle: 'Waiting For You - MONO',
      timestamp: DateTime.now().subtract(const Duration(hours: 9)),
      batteryLevel: 81,
      reactions: const {'🌊': 38, '💙': 21},
    ),
  ];

  static const List<Map<String, String>> myMoments = [
    {
      'url': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
      'caption': 'Code thâu đêm hoàn thiện Locket Dio Desktop 💻💛',
      'time': '01:30 - Hôm nay',
      'music': 'See Tình - Hoàng Thùy Linh',
    },
    {
      'url': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
      'caption': 'Bình minh bên bờ biển Đà Nẵng tuyệt đẹp 🌅',
      'time': '06:15 - Hôm qua',
      'music': 'Nơi Này Có Anh - Sơn Tùng M-TP',
    },
    {
      'url': 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      'caption': 'Góc setup làm việc 2 màn hình chill chill 🎧✨',
      'time': '14:20 - 28/10',
      'music': 'Chuyện Đôi Ta - Emcee L',
    },
    {
      'url': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800',
      'caption': 'Fix xong bug Flutter Web mượt như lụa 🚀',
      'time': '20:45 - 25/10',
      'music': 'Đi Về Nhà - Đen Vâu',
    },
    {
      'url': 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
      'caption': 'Leo núi Ba Vì săn mây cùng bạn bè 🏔️',
      'time': '09:00 - 22/10',
      'music': 'Bài Này Chill Phết - Đen Vâu',
    },
  ];

  static List<Map<String, String>> getMomentsForUser(String userId) {
    if (userId == MockUsers.currentUser.id || userId == 'user_me') {
      return myMoments;
    }

    // Distribute sample moments deterministically per user
    final hash = userId.hashCode.abs();
    final count = 4 + (hash % 6); // 4 to 9 moments
    final startIndex = hash % sampleFriendMoments.length;

    final results = <Map<String, String>>[];
    for (int i = 0; i < count; i++) {
      final index = (startIndex + i) % sampleFriendMoments.length;
      results.add(sampleFriendMoments[index]);
    }
    return results;
  }

  static List<Map<String, String>> getAllMomentsWithAuthors() {
    final list = <Map<String, String>>[];

    // 1. My Moments
    for (final m in myMoments) {
      list.add({
        ...m,
        'authorName': 'Bạn',
        'authorAvatarUrl': MockUsers.currentUser.avatarUrl,
        'authorId': MockUsers.currentUser.id,
      });
    }

    // 2. Moments from feedMoments
    for (final m in feedMoments) {
      list.add({
        'url': m.imageUrl,
        'caption': m.caption,
        'time': '${m.timestamp.hour.toString().padLeft(2, '0')}:${m.timestamp.minute.toString().padLeft(2, '0')} - Hôm nay',
        if (m.musicTitle != null) 'music': m.musicTitle!,
        'authorName': m.author.name,
        'authorAvatarUrl': m.author.avatarUrl,
        'authorId': m.author.id,
      });
    }

    return list;
  }
}

