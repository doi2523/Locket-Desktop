import * as React from 'react';
import { ArrowUpRight, Globe, Sparkles } from 'lucide-react';

interface EcosystemItem {
  title: string;
  domain: string;
  href: string;
  desc: string;
  tag: string;
  icon: typeof Globe;
  chip: string;
  badge: string;
}

const ITEMS: EcosystemItem[] = [
  {
    title: 'Locket Dio Web',
    domain: 'locket-dio.com',
    href: 'https://locket-dio.com',
    desc: 'Trải nghiệm Locket ngay trên trình duyệt web mà không cần cài đặt. Xem moment bạn bè, nhắn tin và đăng ảnh mọi lúc mọi nơi từ bất kỳ thiết bị nào.',
    tag: 'Bản Web trực tuyến',
    icon: Globe,
    chip: 'bg-sky',
    badge: 'Trực tuyến',
  },
  {
    title: 'WazeMod Community',
    domain: 'wazemod.io.vn',
    href: 'https://wazemod.io.vn',
    desc: 'Cổng thông tin chia sẻ các bản mod, ứng dụng tùy biến độc đáo và tiện ích công nghệ chất lượng cao được tối ưu hóa cho cộng đồng.',
    tag: 'Kho ứng dụng & Tiện ích',
    icon: Sparkles,
    chip: 'bg-butter',
    badge: 'Tiện ích & Mod',
  },
];

export const EcosystemSection: React.FC = () => (
  <section id="ecosystem" aria-labelledby="ecosystem-title" className="relative z-10 pb-16 pt-10 sm:pb-20 sm:pt-14">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <h2 id="ecosystem-title" className="t-h2 text-heart">
          Hệ sinh thái
        </h2>
        <p className="t-sub mt-3 text-paper">
          Khám phá thêm các nền tảng <span className="text-butter">trong cùng hệ sinh thái.</span>
        </p>
        <p className="t-lead mt-4 text-paper/75">
          Bên cạnh phiên bản máy tính, hãy ghé thăm phiên bản web của Locket Dio và các dự án tiện ích công nghệ khác cùng phát triển.
        </p>
      </div>

      <div className="mt-8 grid gap-6 sm:mt-10 md:grid-cols-2">
        {ITEMS.map((item, i) => {
          const Icon = item.icon;
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
                  <span className={`inline-flex size-12 items-center justify-center rounded-2xl text-ink shadow-sm ${item.chip}`}>
                    <Icon className="size-6" aria-hidden="true" />
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

