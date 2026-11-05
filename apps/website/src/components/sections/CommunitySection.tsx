import * as React from 'react';
import { Mail, Send, type LucideIcon } from 'lucide-react';
import { GithubIcon } from '@/components/icons/GithubIcon';
import { Placeholder } from '@/components/Placeholder';

type IconType = LucideIcon | typeof GithubIcon;

interface Channel {
  icon: IconType;
  title: string;
  desc: string;
  cta: string;
  href: string;
  external: boolean;
  chip: string;
}

const CHANNELS: Channel[] = [
  {
    icon: Send,
    title: 'Nhóm Telegram',
    desc: 'Trò chuyện, hỏi đáp và nhận thông báo bản mới cùng những người dùng khác.',
    cta: 'Tham gia nhóm',
    href: 'https://t.me/+MjfI6qspzYZmNzRl',
    external: true,
    chip: 'bg-sky',
  },
  {
    icon: GithubIcon,
    title: 'GitHub Issues',
    desc: 'Báo lỗi, đề xuất tính năng và theo dõi tiến độ xử lý công khai.',
    cta: 'Mở Issues',
    href: 'https://github.com/doi2523/Locket-Desktop/issues',
    external: true,
    chip: 'bg-butter',
  },
  {
    icon: Mail,
    title: 'Email tác giả',
    desc: 'Dành cho góp ý riêng hoặc những việc không tiện nói công khai.',
    cta: 'doibncm2003@gmail.com',
    href: 'mailto:doibncm2003@gmail.com',
    external: false,
    chip: 'bg-heart',
  },
];

export const CommunitySection: React.FC = () => (
  <section id="community" aria-labelledby="community-title" className="relative z-10 pb-14 pt-10 sm:pb-16 sm:pt-14">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <h2 id="community-title" className="t-h2 text-heart">
          Cộng đồng
        </h2>
        <p className="t-sub mt-3 text-paper">
          Hỏi, góp ý, báo lỗi, <span className="text-butter">hoặc chỉ ghé chơi.</span>
        </p>
      </div>

      <div className="mt-8 grid gap-5 sm:mt-10 md:grid-cols-3">
        {CHANNELS.map((c, i) => {
          const Icon = c.icon;
          return (
            <a
              key={c.title}
              href={c.href}
              {...(c.external ? { target: '_blank', rel: 'noreferrer' } : {})}
              className="reveal group flex flex-col gap-4 rounded-3xl border border-paper/10 bg-ink-2 p-6 transition-[transform,border-color] duration-300 hover:-translate-y-1 hover:border-paper/30"
              style={{ '--d': `${i * 0.08}s` } as React.CSSProperties}
            >
              <span className={`inline-flex size-11 items-center justify-center rounded-xl text-ink ${c.chip}`}>
                <Icon className="size-5" aria-hidden="true" />
              </span>
              <h3 className="t-h3 text-paper">{c.title}</h3>
              <p className="flex-1 text-[0.95rem] leading-relaxed text-paper/70">{c.desc}</p>
              <span className="break-all text-sm font-semibold text-butter underline decoration-heart decoration-2 underline-offset-4">
                {c.cta}
              </span>
            </a>
          );
        })}

        <Placeholder
          title="Người đóng góp"
          hint="Danh sách những người đã góp code, bản dịch và ý tưởng sẽ hiện ở đây."
          className="reveal md:col-span-3"
        />
      </div>
    </div>
  </section>
);
