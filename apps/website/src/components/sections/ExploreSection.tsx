import * as React from 'react';
import { ArrowUpRight } from 'lucide-react';

interface ExploreItem {
  tag: string;
  title: string;
  domain: string;
  href: string;
  desc: string;
  cta: string;
  icon: string;
  accent: string;
  /** Nhà tài trợ: gắn nhãn rõ cho người xem và rel="sponsored" cho công cụ tìm kiếm. */
  sponsored?: boolean;
}

const ITEMS: ExploreItem[] = [
  {
    tag: 'Bản web',
    title: 'Locket Dio Web',
    domain: 'locket-dio.com',
    href: 'https://locket-dio.com',
    desc: 'Dùng Locket ngay trên trình duyệt, không cần cài đặt. Tiện khi bạn đang ngồi ở một máy không phải của mình.',
    cta: 'Mở bản web',
    icon: 'https://locket-dio.com/apple-touch-icon.png',
    accent: 'bg-butter',
  },
  {
    tag: 'Nhà tài trợ',
    title: 'WazeMod · Chỉ đường và cảnh báo giao thông',
    domain: 'wazemod.io.vn',
    href: 'https://wazemod.io.vn',
    desc: 'Nhà tài trợ đồng hành cùng Locket Dio. WazeMod là ứng dụng chỉ đường và cảnh báo giao thông, được chỉnh sửa dành riêng cho tài xế Việt.',
    cta: 'Ghé WazeMod',
    icon: 'https://media.chisadin.id.vn/cdn/waze.png',
    accent: 'bg-heart',
    sponsored: true,
  },
];

/** Biểu tượng tải từ site ngoài; nếu lỗi thì hiện chữ cái đầu để thẻ không bị trống. */
const SiteIcon: React.FC<{ src: string; title: string }> = ({ src, title }) => {
  const [failed, setFailed] = React.useState(false);
  return (
    <span className="inline-flex size-14 shrink-0 items-center justify-center overflow-hidden rounded-2xl border border-paper/15 bg-paper/10">
      {failed ? (
        <span aria-hidden="true" className="font-display text-2xl font-extrabold text-paper">
          {title.charAt(0)}
        </span>
      ) : (
        <img
          src={src}
          alt=""
          width={36}
          height={36}
          loading="lazy"
          decoding="async"
          referrerPolicy="no-referrer"
          onError={() => setFailed(true)}
          className="size-9 object-contain"
        />
      )}
    </span>
  );
};

export const ExploreSection: React.FC = () => (
  <section id="explore" aria-labelledby="explore-title" className="relative z-10 pb-16 pt-10 sm:pb-20 sm:pt-14">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <h2 id="explore-title" className="t-h2 text-heart">
          Khám phá
        </h2>
        <p className="t-sub mt-3 text-paper">
          Locket Dio không chỉ có bản máy&nbsp;tính. <span className="text-butter">Còn hai nơi nữa để ghé.</span>
        </p>
      </div>

      <ul className="mt-8 grid gap-5 sm:mt-10 md:grid-cols-2">
        {ITEMS.map((item, i) => (
          <li key={item.domain} className="reveal" style={{ '--d': `${i * 0.1}s` } as React.CSSProperties}>
            <a
              href={item.href}
              target="_blank"
              rel={item.sponsored ? 'sponsored noopener noreferrer' : 'noopener noreferrer'}
              className="group relative flex h-full flex-col gap-6 overflow-hidden rounded-3xl border border-paper/10 bg-ink-2 p-6 transition-[transform,border-color] duration-300 hover:-translate-y-1 hover:border-paper/30 sm:p-8"
            >
              <span aria-hidden="true" className={`absolute inset-x-0 top-0 h-1.5 ${item.accent}`} />

              <div className="flex items-start justify-between gap-4">
                <SiteIcon src={item.icon} title={item.title} />
                <span
                  className={`eyebrow rounded-full border px-3 py-1 ${item.sponsored ? 'border-heart/60 bg-heart/15 text-heart' : 'border-paper/15 text-paper/70'}`}
                >
                  {item.tag}
                </span>
              </div>

              <div className="flex-1">
                <p className="font-display text-[clamp(1.6rem,1.2rem+1.6vw,2.4rem)] font-extrabold leading-tight tracking-tight text-paper transition-colors group-hover:text-butter">
                  {item.domain}
                </p>
                <h3 className="mt-1 text-sm font-semibold text-paper/60">{item.title}</h3>
                <p className="mt-4 leading-relaxed text-paper/75">{item.desc}</p>
              </div>

              <span className="inline-flex items-center gap-1.5 border-t border-paper/10 pt-4 font-semibold text-butter">
                {item.cta}
                <ArrowUpRight className="size-4 transition-transform duration-200 group-hover:-translate-y-0.5 group-hover:translate-x-0.5" aria-hidden="true" />
                <span className="sr-only">(mở trong tab mới)</span>
              </span>
            </a>
          </li>
        ))}
      </ul>
    </div>
  </section>
);
