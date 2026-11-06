import * as React from 'react';
import {
  Camera,
  Eye,
  Flame,
  LayoutGrid,
  MessageCircle,
  Palette,
  RefreshCw,
  X,
  type LucideIcon,
} from 'lucide-react';
import * as RadixDialog from '@radix-ui/react-dialog';

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
    image: '/screenshots/03_locket_feed.webp',
    alt: 'Feed moment của bạn bè trên Locket Dio Desktop',
    span: 'lg:col-span-4',
    chip: 'bg-butter text-ink',
  },
  {
    icon: MessageCircle,
    title: 'Nhắn tin tức thì',
    desc: 'Chat 1-1 và nhóm, thả reaction cho moment, tìm lại tin nhắn cũ.',
    image: '/screenshots/02_chat_feed.webp',
    alt: 'Cửa sổ chat với dòng thời gian tin nhắn và reaction',
    span: 'lg:col-span-2',
    chip: 'bg-sky text-ink',
  },
  {
    icon: Camera,
    title: 'Studio đăng moment',
    desc: 'Chụp bằng webcam hoặc chọn ảnh, video từ máy. Cắt, xoay, lật, cắt video tối đa 10 giây, thêm chữ và sticker nhạc, rồi xem trước ngay trên khung điện thoại.',
    image: '/screenshots/04_post_moment_editor.webp',
    alt: 'Studio đăng moment với khung xem trước điện thoại',
    span: 'lg:col-span-2',
    chip: 'bg-heart text-ink',
  },
  {
    icon: Flame,
    title: 'Lịch streak',
    desc: 'Theo dõi chuỗi ngày gửi ảnh theo tháng. Lỡ một ngày thì đăng moment để khôi phục.',
    image: '/screenshots/07_streak_calendar.webp',
    alt: 'Lịch streak theo tháng',
    span: 'lg:col-span-4',
    chip: 'bg-butter text-ink',
  },
  {
    icon: Palette,
    title: '33 biểu tượng, sáng hoặc tối',
    desc: 'Đổi biểu tượng ứng dụng, màu nhấn và chế độ giao diện theo ý bạn.',
    image: '/screenshots/08_theme_and_icons.webp',
    alt: 'Cài đặt giao diện và bộ sưu tập biểu tượng ứng dụng',
    span: 'lg:col-span-3',
    chip: 'bg-sky text-ink',
  },
  {
    icon: RefreshCw,
    title: 'Tự cập nhật, chạy nền',
    desc: 'Có bản mới thì cập nhật bằng một cú bấm. Thu nhỏ xuống khay hệ thống để vẫn nhận thông báo moment, reaction và tin nhắn.',
    image: '/screenshots/09_notifications_sound.webp',
    alt: 'Cài đặt thông báo và âm thanh',
    span: 'lg:col-span-3',
    chip: 'bg-heart text-ink',
  },
];

export const FeaturesSection: React.FC = () => {
  const [selectedFeature, setSelectedFeature] = React.useState<Feature | null>(null);
  const [isOpen, setIsOpen] = React.useState(false);

  const handleOpen = (f: Feature) => {
    setSelectedFeature(f);
    setIsOpen(true);
  };

  return (
    <section id="features" aria-labelledby="features-title" className="relative z-10 pb-6 pt-10 sm:pb-8 sm:pt-14">
      <div className="mx-auto max-w-7xl px-5 sm:px-8">
        <div className="reveal max-w-3xl">
          <h2 id="features-title" className="t-h2 text-heart">
            Tính năng
          </h2>
          <p className="t-sub mt-3 text-paper">
            Mọi thứ của Locket, <span className="text-butter">rộng chỗ hơn.</span>
          </p>
        </div>

        <ul className="mt-8 grid sm:mt-10 grid-cols-1 gap-5 md:grid-cols-2 lg:grid-cols-6">
          {FEATURES.map((f, i) => {
            const Icon = f.icon;
            return (
              <li
                key={f.title}
                className={`reveal group flex flex-col overflow-hidden rounded-3xl border border-paper/10 bg-ink-2 transition-[transform,border-color] duration-300 hover:-translate-y-1 hover:border-paper/30 ${f.span}`}
                style={{ '--d': `${(i % 3) * 0.08}s` } as React.CSSProperties}
              >
                <div
                  role="button"
                  tabIndex={0}
                  onClick={() => handleOpen(f)}
                  onKeyDown={(e) => {
                    if (e.key === 'Enter' || e.key === ' ') {
                      e.preventDefault();
                      handleOpen(f);
                    }
                  }}
                  className="group/img relative h-52 w-full cursor-pointer overflow-hidden bg-ink-3 text-left focus:outline-none focus-visible:ring-2 focus-visible:ring-butter sm:h-60"
                  aria-label={`Xem ảnh: ${f.title}`}
                >
                  <img
                    src={f.image}
                    alt={f.alt}
                    loading="lazy"
                    decoding="async"
                    width={1280}
                    height={800}
                    className="size-full object-cover object-left-top transition-transform duration-500 group-hover/img:scale-[1.05]"
                  />
                  <div className="absolute inset-0 flex items-center justify-center bg-ink/35 opacity-0 backdrop-blur-[2px] transition-all duration-300 group-hover/img:opacity-100">
                    <span className="inline-flex size-11 items-center justify-center rounded-2xl border border-paper/20 bg-ink-2/80 text-butter shadow-xl backdrop-blur-md transition-transform duration-300 group-hover/img:scale-110">
                      <Eye className="size-5" aria-hidden="true" />
                    </span>
                  </div>
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

      <RadixDialog.Root open={isOpen} onOpenChange={setIsOpen}>
        {selectedFeature && (
          <RadixDialog.Portal>
            <RadixDialog.Overlay className="fixed inset-0 z-50 bg-black/80 backdrop-blur-md duration-200 ease-out data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0" />
            <RadixDialog.Content
              className="fixed left-[50%] top-[50%] z-50 flex max-h-[92vh] w-[95vw] max-w-5xl translate-x-[-50%] translate-y-[-50%] flex-col overflow-hidden rounded-3xl border border-paper/15 bg-ink-2 shadow-2xl backdrop-blur-2xl duration-200 ease-out data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 focus:outline-none"
              aria-describedby="feature-dialog-desc"
            >
              {/* Header */}
              <div className="flex items-center justify-between gap-4 border-b border-paper/10 bg-ink-2 px-5 py-4 sm:px-6">
                <div className="flex min-w-0 items-center gap-3">
                  <span className={`inline-flex size-9 shrink-0 items-center justify-center rounded-xl ${selectedFeature.chip}`}>
                    {React.createElement(selectedFeature.icon, { className: 'size-4.5', 'aria-hidden': true })}
                  </span>
                  <div className="min-w-0">
                    <RadixDialog.Title className="t-h3 truncate text-paper">
                      {selectedFeature.title}
                    </RadixDialog.Title>
                    <RadixDialog.Description
                      id="feature-dialog-desc"
                      className="mt-0.5 line-clamp-1 text-xs text-paper/70 sm:text-sm"
                    >
                      {selectedFeature.desc}
                    </RadixDialog.Description>
                  </div>
                </div>
                <RadixDialog.Close
                  aria-label="Đóng"
                  className="inline-flex size-9 shrink-0 cursor-pointer items-center justify-center rounded-xl border border-paper/15 bg-ink-3/60 text-paper/80 transition-colors hover:bg-paper/10 hover:text-paper focus:outline-none"
                >
                  <X className="size-4.5" />
                </RadixDialog.Close>
              </div>

              {/* Image Preview Container */}
              <div className="relative flex flex-1 items-center justify-center overflow-auto bg-ink/70 p-3 sm:p-6">
                <img
                  src={selectedFeature.image}
                  alt={selectedFeature.alt}
                  width={1280}
                  height={800}
                  className="max-h-[75vh] w-auto max-w-full rounded-2xl object-contain shadow-2xl ring-1 ring-paper/10"
                />
              </div>
            </RadixDialog.Content>
          </RadixDialog.Portal>
        )}
      </RadixDialog.Root>
    </section>
  );
};
