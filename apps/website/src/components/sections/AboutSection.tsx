import * as React from 'react';
import { Code2, Heart, Monitor, ShieldCheck } from 'lucide-react';

const HIGHLIGHTS = [
  {
    icon: Monitor,
    title: 'Đa nền tảng',
    desc: 'Tương thích hoàn hảo cả Windows và macOS.',
    chip: 'bg-sky text-ink',
  },
  {
    icon: ShieldCheck,
    title: 'Miễn phí & Riêng tư',
    desc: 'Không quảng cáo, bảo mật dữ liệu an toàn.',
    chip: 'bg-butter text-ink',
  },
  {
    icon: Code2,
    title: 'Mã nguồn mở',
    desc: 'Minh bạch 100% trên GitHub cộng đồng.',
    chip: 'bg-heart text-ink',
  },
] as const;

export const AboutSection: React.FC = () => (
  <section id="about" aria-labelledby="about-title" className="relative z-10 pb-14 pt-8 sm:pb-20 sm:pt-12">
    <div className="mx-auto grid max-w-7xl items-center gap-12 px-5 sm:px-8 lg:grid-cols-2 lg:gap-14">
      {/* Cột trái: Nội dung giới thiệu & điểm nổi bật */}
      <div className="reveal">
        <h2 id="about-title" className="t-h2 text-heart">
          Giới thiệu
        </h2>
        <p className="t-sub mt-3 text-paper">
          Locket dành cho máy tính, <span className="text-butter">do cộng đồng làm ra.</span>
        </p>
        <div className="mt-5 space-y-3.5 text-paper/75">
          <p className="t-lead">
            Locket Dio Desktop đưa trải nghiệm kết nối thân mật của Locket lên màn hình máy tính. Bạn có thể xem moment mới của bạn bè theo thời gian thực, nhắn tin, đăng ảnh và video ngay trong lúc làm việc mà không cần cầm điện thoại.
          </p>
          <p className="text-[0.95rem] leading-relaxed">
            Dự án độc lập được xây dựng từ nhu cầu thực tế, chú trọng sự mượt mà, tốc độ phản hồi nhanh và tôn trọng tối đa quyền riêng tư của bạn.
          </p>
        </div>

        <div className="mt-8 grid gap-3 sm:grid-cols-3">
          {HIGHLIGHTS.map(({ icon: Icon, title, desc, chip }) => (
            <div key={title} className="rounded-2xl border border-paper/10 bg-ink-2 p-4 transition-colors hover:border-paper/20">
              <span className={`inline-flex size-9 items-center justify-center rounded-xl shadow-sm ${chip}`}>
                <Icon className="size-4" aria-hidden="true" />
              </span>
              <p className="mt-3 font-display text-sm font-bold text-paper">{title}</p>
              <p className="mt-1 text-xs text-paper/65 leading-relaxed">{desc}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Cột phải: Mockup giao diện ứng dụng desktop thực tế */}
      <div className="reveal relative" style={{ '--d': '0.15s' } as React.CSSProperties}>
        <div className="overflow-hidden rounded-3xl border border-paper/15 bg-ink-2 shadow-2xl shadow-black/50">
          {/* Thanh tiêu đề cửa sổ hệ điều hành */}
          <div className="flex items-center justify-between border-b border-paper/10 bg-ink-3/80 px-4 py-3 backdrop-blur-sm">
            <div className="flex items-center gap-2">
              <span className="size-3 rounded-full bg-[#ff5f56]" />
              <span className="size-3 rounded-full bg-[#ffbd2e]" />
              <span className="size-3 rounded-full bg-[#27c93f]" />
            </div>
            <span className="font-mono text-xs font-medium text-paper/60">Locket Dio Desktop</span>
            <span className="inline-flex items-center gap-1 rounded-full bg-paper/10 px-2 py-0.5 font-mono text-[10px] font-semibold text-paper/70">
              Feed bạn bè
            </span>
          </div>

          {/* Ảnh chụp màn hình ứng dụng thực tế */}
          <div className="relative aspect-[16/10] overflow-hidden bg-ink-3">
            <img
              src="/screenshots/03_locket_feed.webp"
              alt="Giao diện Locket Dio Desktop với danh sách bạn bè và feed moment"
              width={1280}
              height={800}
              loading="lazy"
              decoding="async"
              className="h-full w-full object-cover object-top transition-transform duration-500 hover:scale-[1.02]"
            />
          </div>
        </div>

        {/* Thẻ nổi chú thích góc dưới */}
        <div className="absolute -bottom-4 -left-4 hidden items-center gap-3 rounded-2xl border border-paper/15 bg-ink-3/95 px-4 py-3 shadow-xl backdrop-blur-md sm:flex">
          <span className="flex size-9 items-center justify-center rounded-xl bg-heart text-ink">
            <Heart className="size-5 fill-current" aria-hidden="true" />
          </span>
          <div>
            <p className="font-display text-sm font-bold text-paper">Không lỡ khoảnh khắc</p>
            <p className="text-xs text-paper/60">Xem ngay khi đang làm việc trên máy tính</p>
          </div>
        </div>
      </div>
    </div>
  </section>
);
