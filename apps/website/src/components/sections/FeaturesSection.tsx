import * as React from 'react';
import { Camera, Flame, LayoutGrid, MessageCircle, Palette, RefreshCw, type LucideIcon } from 'lucide-react';

interface Feature {
  icon: LucideIcon;
  title: string;
  desc: string;
  image: string;
  alt: string;
  span: string;
  chip: string;
}

const FEATURES: Feature[] = [
  {
    icon: LayoutGrid,
    title: 'Feed moment ba cột',
    desc: 'Danh sách bạn bè, feed ảnh và video chất lượng cao nằm trên cùng một màn hình. Ảnh đã xem được lưu trên máy nên mở lại là có ngay.',
    image: '/screenshots/03_locket_feed.png',
    alt: 'Feed moment của bạn bè trên Locket Dio Desktop',
    span: 'lg:col-span-4',
    chip: 'bg-butter text-ink',
  },
  {
    icon: MessageCircle,
    title: 'Nhắn tin tức thì',
    desc: 'Chat 1-1 và nhóm, thả reaction cho moment, tìm lại tin nhắn cũ.',
    image: '/screenshots/02_chat_feed.png',
    alt: 'Cửa sổ chat với dòng thời gian tin nhắn và reaction',
    span: 'lg:col-span-2',
    chip: 'bg-sky text-ink',
  },
  {
    icon: Camera,
    title: 'Studio đăng moment',
    desc: 'Chụp bằng webcam hoặc chọn ảnh, video từ máy. Cắt, xoay, lật, cắt video tối đa 10 giây, thêm chữ và sticker nhạc, rồi xem trước ngay trên khung điện thoại.',
    image: '/screenshots/04_post_moment_editor.png',
    alt: 'Studio đăng moment với khung xem trước điện thoại',
    span: 'lg:col-span-2',
    chip: 'bg-heart text-ink',
  },
  {
    icon: Flame,
    title: 'Lịch streak',
    desc: 'Theo dõi chuỗi ngày gửi ảnh theo tháng. Lỡ một ngày thì đăng moment để khôi phục.',
    image: '/screenshots/07_streak_calendar.png',
    alt: 'Lịch streak theo tháng',
    span: 'lg:col-span-4',
    chip: 'bg-butter text-ink',
  },
  {
    icon: Palette,
    title: '33 biểu tượng, sáng hoặc tối',
    desc: 'Đổi biểu tượng ứng dụng, màu nhấn và chế độ giao diện theo ý bạn.',
    image: '/screenshots/08_theme_and_icons.png',
    alt: 'Cài đặt giao diện và bộ sưu tập biểu tượng ứng dụng',
    span: 'lg:col-span-3',
    chip: 'bg-sky text-ink',
  },
  {
    icon: RefreshCw,
    title: 'Tự cập nhật, chạy nền',
    desc: 'Có bản mới thì cập nhật bằng một cú bấm. Thu nhỏ xuống khay hệ thống để vẫn nhận thông báo moment, reaction và tin nhắn.',
    image: '/screenshots/09_notifications_sound.png',
    alt: 'Cài đặt thông báo và âm thanh',
    span: 'lg:col-span-3',
    chip: 'bg-heart text-ink',
  },
];

export const FeaturesSection: React.FC = () => (
  <section id="features" aria-labelledby="features-title" className="relative z-10 scroll-mt-16 py-20 sm:py-28">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <p className="eyebrow text-heart">Tính năng</p>
        <h2 id="features-title" className="t-h2 mt-3 text-paper">
          Mọi thứ của Locket, <span className="text-butter">rộng chỗ hơn.</span>
        </h2>
      </div>

      <ul className="mt-12 grid grid-cols-1 gap-5 md:grid-cols-2 lg:grid-cols-6">
        {FEATURES.map((f, i) => {
          const Icon = f.icon;
          return (
            <li
              key={f.title}
              className={`reveal group flex flex-col overflow-hidden rounded-3xl border border-paper/10 bg-ink-2 transition-[transform,border-color] duration-300 hover:-translate-y-1 hover:border-paper/30 ${f.span}`}
              style={{ '--d': `${(i % 3) * 0.08}s` } as React.CSSProperties}
            >
              <div className="relative h-52 overflow-hidden bg-ink-3 sm:h-60">
                <img
                  src={f.image}
                  alt={f.alt}
                  loading="lazy"
                  decoding="async"
                  width={1280}
                  height={800}
                  className="size-full object-cover object-left-top transition-transform duration-500 group-hover:scale-[1.03]"
                />
              </div>
              <div className="flex flex-1 flex-col gap-3 p-6">
                <span className={`inline-flex size-10 items-center justify-center rounded-xl ${f.chip}`}>
                  <Icon className="size-5" aria-hidden="true" />
                </span>
                <h3 className="t-h3 text-paper">{f.title}</h3>
                <p className="text-[0.95rem] leading-relaxed text-paper/70">{f.desc}</p>
              </div>
            </li>
          );
        })}
      </ul>
    </div>
  </section>
);
