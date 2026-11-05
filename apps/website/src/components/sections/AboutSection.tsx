import * as React from 'react';
import { Code2, Gift, Monitor } from 'lucide-react';
import { Placeholder } from '@/components/Placeholder';

const FACTS = [
  { icon: Monitor, text: 'Chạy trên Windows và macOS', chip: 'bg-sky' },
  { icon: Gift, text: 'Miễn phí, không quảng cáo', chip: 'bg-butter' },
  { icon: Code2, text: 'Mã nguồn mở trên GitHub', chip: 'bg-heart' },
] as const;

export const AboutSection: React.FC = () => (
  <section id="about" aria-labelledby="about-title" className="relative z-10 pb-14 pt-6 sm:pb-20 sm:pt-10">
    <div className="mx-auto grid max-w-7xl gap-10 px-5 sm:px-8 lg:grid-cols-2 lg:gap-14">
      <div className="reveal">
        <h2 id="about-title" className="t-h2 text-heart">
          Giới thiệu
        </h2>
        <p className="t-sub mt-3 text-paper">
          Locket dành cho máy tính, <span className="text-butter">do cộng đồng làm ra.</span>
        </p>
        <div className="mt-6 space-y-4 text-paper/75">
          <p className="t-lead">
            Locket Dio Desktop đưa trải nghiệm Locket lên Windows và macOS. Bạn xem moment của bạn bè theo thời gian thực, nhắn tin, đăng ảnh và video ngay từ máy tính mà không cần cầm điện thoại.
          </p>
          <p>
            Đây là dự án độc lập do một người phát triển và duy trì, không phải sản phẩm chính thức của Locket.
          </p>
        </div>
        <ul className="mt-8 space-y-3">
          {FACTS.map(({ icon: Icon, text, chip }) => (
            <li key={text} className="flex items-center gap-3 font-medium text-paper">
              <span className={`inline-flex size-9 shrink-0 items-center justify-center rounded-xl text-ink ${chip}`}>
                <Icon className="size-4" aria-hidden="true" />
              </span>
              {text}
            </li>
          ))}
        </ul>
      </div>

      <div className="reveal self-center" style={{ '--d': '0.1s' } as React.CSSProperties}>
        <Placeholder
          title="Video giới thiệu"
          hint="Video demo ngắn về ứng dụng sẽ được đặt ở đây."
          className="aspect-video w-full"
        />
      </div>
    </div>
  </section>
);
