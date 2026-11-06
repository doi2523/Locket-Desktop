import * as React from 'react';
import { ArrowUpRight } from 'lucide-react';

interface ExploreItem {
  title: string;
  domain: string;
  href: string;
  desc: string;
  tag: string;
  image: string;
  chip: string;
  badge: string;
}

const ITEMS: ExploreItem[] = [
  {
    title: 'Locket Dio Web',
    domain: 'locket-dio.com',
    href: 'https://locket-dio.com',
    desc: 'Dùng Locket nhanh ngay trên trình duyệt mà không cần cài đặt. Xem moment, nhắn tin và chia sẻ khoảnh khắc với bạn bè ở bất cứ đâu.',
    tag: 'Bản Web trực tuyến',
    image: 'https://locket-dio.com/apple-touch-icon.png',
    chip: 'bg-paper/10 border border-paper/15',
    badge: 'Trực tuyến',
  },
  {
    title: 'WazeMod Community',
    domain: 'wazemod.io.vn',
    href: 'https://wazemod.io.vn',
    desc: 'Cổng chia sẻ các ứng dụng tùy biến, tiện ích công nghệ và các bản mod hữu ích được phát triển dành riêng cho cộng đồng.',
    tag: 'Kho ứng dụng & Tiện ích',
    image: 'https://media.chisadin.id.vn/cdn/waze.png',
    chip: 'bg-paper/10 border border-paper/15',
    badge: 'Tiện ích & Mod',
  },
];

export const ExploreSection: React.FC = () => (
  <section id="explore" aria-labelledby="explore-title" className="relative z-10 pb-16 pt-10 sm:pb-20 sm:pt-14">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <h2 id="explore-title" className="t-h2 text-heart">
          Khám phá
        </h2>
        <p className="t-sub mt-3 text-paper">
          Không chỉ có trên máy tính, <span className="text-butter">vẫn còn nhiều điều thú vị.</span>
        </p>
        <p className="t-lead mt-4 text-paper/75">
          Dùng Locket trực tiếp trên trình duyệt web tại locket-dio.com, hoặc ghé wazemod.io.vn để khám phá thêm các ứng dụng và tiện ích hay ho khác.
        </p>
      </div>

      <div className="mt-8 grid gap-6 sm:mt-10 md:grid-cols-2">
        {ITEMS.map((item, i) => {
          return (
            <a
              key={item.domain}
              href={item.href}
              target="_blank"
              rel="noreferrer"
              className="reveal group relative flex flex-col justify-between rounded-3xl border border-paper/10 bg-ink-2 p-6 sm:p-8 transition-all duration-300 hover:-translate-y-1.5 hover:border-paper/30 hover:shadow-xl hover:shadow-black/25"
              style={{ '--d': `${i * 0.1}s` } as React.CSSProperties}
            >
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <span className={`inline-flex size-12 items-center justify-center overflow-hidden rounded-2xl shadow-sm ${item.chip}`}>
                    <img
                      src={item.image}
                      alt=""
                      width={32}
                      height={32}
                      loading="lazy"
                      className="size-8 rounded-lg object-contain"
                    />
                  </span>
                  <span className="rounded-full border border-paper/15 bg-paper/5 px-3 py-1 font-mono text-xs font-semibold text-paper/75">
                    {item.badge}
                  </span>
                </div>

                <div>
                  <span className="font-mono text-xs font-bold uppercase tracking-wider text-butter/90">
                    {item.domain}
                  </span>
                  <h3 className="t-h3 mt-1 text-paper transition-colors group-hover:text-butter">
                    {item.title}
                  </h3>
                  <p className="mt-3 text-[0.95rem] leading-relaxed text-paper/70">
                    {item.desc}
                  </p>
                </div>
              </div>

              <div className="mt-6 flex items-center gap-1.5 border-t border-paper/10 pt-4 text-sm font-semibold text-butter transition-colors group-hover:text-paper">
                <span>Ghé thăm {item.domain}</span>
                <ArrowUpRight className="size-4 transition-transform duration-200 group-hover:-translate-y-0.5 group-hover:translate-x-0.5" aria-hidden="true" />
              </div>
            </a>
          );
        })}
      </div>
    </div>
  </section>
);

