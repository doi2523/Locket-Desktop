import * as React from 'react';
import {
  Camera,
  Flame,
  LayoutGrid,
  MessageCircle,
  Palette,
  RefreshCw,
  Sparkles,
} from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';

const FEATURES = [
  {
    icon: LayoutGrid,
    title: 'Locket Feed 3 Cột Trực Quan',
    desc: 'Bố cục chuẩn desktop giúp bạn vừa duyệt danh sách bạn bè, vừa xem feed hình ảnh/video chất lượng cao với bộ nhớ đệm mượt mà.',
    tag: 'Chuẩn Desktop',
    color: 'text-amber-500 bg-amber-500/10',
    image: '/screenshots/03_locket_feed.png',
  },
  {
    icon: MessageCircle,
    title: 'Nhắn Tin Tức Thì & Thả Reaction',
    desc: 'Trò chuyện 1-1 và chat nhóm thời gian thực qua công nghệ SSE, phản hồi moment bạn bè bằng icon biểu cảm độc quyền.',
    tag: 'Thời gian thực',
    color: 'text-sky-500 bg-sky-500/10',
    image: '/screenshots/02_chat_feed.png',
  },
  {
    icon: Camera,
    title: 'Studio Moment iPhone 14 Pro Max',
    desc: 'Chụp trực tiếp từ webcam máy tính, cắt ảnh tự do, cắt ngắn video 10s trực quan và chèn sticker nhạc Spotify & Apple Music.',
    tag: 'Độc quyền',
    color: 'text-rose-500 bg-rose-500/10',
    image: '/screenshots/04_post_moment_editor.png',
  },
  {
    icon: Flame,
    title: 'Lịch Streak Kỷ Niệm Ngọn Lửa',
    desc: 'Theo dõi chuỗi ngày gửi ảnh liên tiếp với bạn bè thân thiết theo lịch tháng và hỗ trợ đăng bù để khôi phục chuỗi streak.',
    tag: 'Theo dõi chuỗi',
    color: 'text-orange-500 bg-orange-500/10',
    image: '/screenshots/07_streak_calendar.png',
  },
  {
    icon: Palette,
    title: '33 Biểu Tượng Ứng Dụng & Giao Diện',
    desc: 'Tự do lựa chọn trong bộ sưu tập 33 icon độc đáo, tùy chỉnh màu nhấn và hỗ trợ chế độ Dark Mode / Light Mode bảo vệ mắt.',
    tag: 'Cá nhân hóa',
    color: 'text-purple-500 bg-purple-500/10',
    image: '/screenshots/08_theme_and_icons.png',
  },
  {
    icon: RefreshCw,
    title: 'Tự Cập Nhật (OTA) & Chạy Ngầm',
    desc: 'Tự động kiểm tra và nâng cấp phiên bản mới chỉ bằng 1 cú nhấp chuột. Thu nhỏ xuống khay hệ thống (System Tray) nhẹ nhàng.',
    tag: 'Tối ưu hiệu năng',
    color: 'text-emerald-500 bg-emerald-500/10',
    image: '/screenshots/09_notifications_sound.png',
  },
];

export const FeaturesSection: React.FC = () => {
  return (
    <section id="features" className="py-24 relative z-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center max-w-3xl mx-auto mb-16 space-y-4">
          <Badge variant="amber" className="px-3.5 py-1 text-xs border-0 bg-amber-500/15">
            <Sparkles className="w-3.5 h-3.5" /> Giới thiệu tính năng
          </Badge>
          <h2 className="text-3xl sm:text-5xl font-extrabold tracking-tight text-foreground">
            Trải Nghiệm Đỉnh Cao Dành Riêng Cho Máy Tính
          </h2>
          <p className="text-base sm:text-lg text-muted-foreground leading-relaxed">
            Kết hợp sức mạnh đồ họa của Flutter cùng hệ thống truyền phát Go cục bộ, Locket Dio Desktop mang lại tốc độ phản hồi tức thì và sự tiện lợi tuyệt đối.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8">
          {FEATURES.map((item, idx) => {
            const Icon = item.icon;
            return (
              <Card
                key={idx}
                className="group border-0 bg-card/35 hover:bg-card/65 backdrop-blur-xl transition-all duration-300 flex flex-col justify-between overflow-hidden rounded-3xl hover:scale-[1.01] shadow-none"
              >
                <div className="relative aspect-[16/10] overflow-hidden bg-black/20">
                  <img
                    src={item.image}
                    alt={item.title}
                    className="w-full h-full object-cover object-top transition-transform duration-500 group-hover:scale-105"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-background/90 via-background/20 to-transparent" />
                  <div className="absolute top-3 right-3">
                    <Badge variant="secondary" className="border-0 backdrop-blur-md bg-black/40 text-[11px] text-white">
                      {item.tag}
                    </Badge>
                  </div>
                </div>

                <CardContent className="p-6 flex-1 flex flex-col justify-between space-y-4">
                  <div className="space-y-2">
                    <div className="flex items-center gap-2.5">
                      <div className={`p-2 rounded-xl ${item.color}`}>
                        <Icon className="w-4 h-4" />
                      </div>
                      <h3 className="font-bold text-lg text-foreground tracking-tight">
                        {item.title}
                      </h3>
                    </div>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      {item.desc}
                    </p>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>
    </section>
  );
};
