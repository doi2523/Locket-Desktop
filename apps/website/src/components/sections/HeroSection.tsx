import * as React from 'react';
import { ArrowDown, Download } from 'lucide-react';
import { AppleIcon, WindowsIcon } from '@/components/icons/PlatformIcons';
import { Button } from '@/components/ui/button';
import { formatDate } from '@/lib/utils';
import type { PlatformDownload, PlatformId, ReleaseInfo } from '@/types/download';

interface HeroSectionProps {
  release: ReleaseInfo;
  platforms: PlatformDownload[];
  detected: PlatformId | null;
  onSelectPlatform: (platform: PlatformId) => void;
}

const PLATFORM = {
  macos: { Icon: AppleIcon, label: 'macOS', ext: '.dmg' },
  windows: { Icon: WindowsIcon, label: 'Windows', ext: '.exe' },
} as const;

const PRINTS = [
  {
    src: '/screenshots/02_chat_feed.webp',
    alt: 'Màn hình chat của Locket Dio: danh sách hội thoại, tin nhắn và moment được chia sẻ',
    caption: 'Chat · tin nhắn',
    cls: 'left-0 top-[8%] w-[64%] z-20',
    rot: '-4deg',
    depth: 10,
    delay: '0.25s',
  },
  {
    src: '/screenshots/03_locket_feed.webp',
    alt: 'Feed Locket trên máy tính với bộ lọc bạn bè',
    caption: 'Feed · moment của bạn bè',
    cls: 'right-0 top-0 w-[54%] z-10',
    rot: '6deg',
    depth: 20,
    delay: '0.45s',
  },
  {
    src: '/screenshots/04_post_moment_editor.webp',
    alt: 'Studio đăng moment với khung xem trước điện thoại',
    caption: 'Studio · đăng moment',
    cls: 'bottom-0 left-[30%] w-[56%] z-30',
    rot: '-1.5deg',
    depth: 30,
    delay: '0.65s',
  },
] as const;

export const HeroSection: React.FC<HeroSectionProps> = ({ release, platforms, detected, onSelectPlatform }) => {
  const order: PlatformId[] = detected === 'macos' ? ['macos', 'windows'] : ['windows', 'macos'];
  const fileFor = (id: PlatformId) => platforms.find((p) => p.platform === id)?.files.find((f) => f.recommended);
  const stageRef = React.useRef<HTMLDivElement>(null);

  const onMove = (e: React.PointerEvent<HTMLDivElement>) => {
    if (e.pointerType !== 'mouse') return;
    const r = e.currentTarget.getBoundingClientRect();
    e.currentTarget.style.setProperty('--mx', String(((e.clientX - r.left) / r.width - 0.5) * 2));
    e.currentTarget.style.setProperty('--my', String(((e.clientY - r.top) / r.height - 0.5) * 2));
  };
  const onLeave = () => {
    stageRef.current?.style.setProperty('--mx', '0');
    stageRef.current?.style.setProperty('--my', '0');
  };

  return (
    <section id="hero" className="relative isolate pt-20 sm:pt-24 pb-10 lg:pb-12">
      <div className="mx-auto grid max-w-7xl items-center gap-12 px-5 sm:px-8 lg:grid-cols-[1.05fr_1fr] lg:gap-8">
        <div>
          <p
            className="enter eyebrow inline-flex items-center gap-2 rounded-full border border-paper/20 px-3.5 py-1.5 font-semibold text-paper/90"
            style={{ '--d': '0s' } as React.CSSProperties}
          >
            <span className="size-2 rounded-full bg-heart" aria-hidden="true" />
            <span className="font-semibold">
              {release.version
                ? `${release.version}${release.publishedAt ? ` · ${formatDate(release.publishedAt)}` : ''}`
                : 'Miễn phí · mã nguồn mở'}
            </span>
          </p>

          <h1 className="t-hero mt-6 text-paper">
            <span className="enter block" style={{ '--d': '0.1s' } as React.CSSProperties}>Locket,</span>
            <span className="enter block" style={{ '--d': '0.2s' } as React.CSSProperties}>nhưng trên</span>
            <span className="enter block" style={{ '--d': '0.3s' } as React.CSSProperties}>
              <span className="mark">
                <span className="relative z-10 text-butter">máy tính.</span>
              </span>
            </span>
          </h1>

          <p className="enter t-lead mt-7 max-w-xl text-paper/75" style={{ '--d': '0.45s' } as React.CSSProperties}>
            Xem moment của bạn bè, nhắn tin và đăng ảnh ngay từ Windows hoặc macOS. Không cần mở điện thoại.
          </p>

          <div className="enter mt-9 flex flex-col gap-4 sm:flex-row sm:items-center" style={{ '--d': '0.6s' } as React.CSSProperties}>
            {order.map((id, i) => {
              const { Icon, label, ext } = PLATFORM[id];
              const primary = i === 0;
              return (
                <Button
                  key={id}
                  asChild
                  variant={primary ? 'glow' : 'outline'}
                  size="xl"
                  className={`group justify-start gap-3 sm:justify-center ${primary ? '' : 'border-paper/30 bg-transparent text-paper hover:bg-paper/10'}`}
                >
                  <a href={fileFor(id)?.downloadUrl} onClick={() => onSelectPlatform(id)}>
                    <Icon className="size-6 shrink-0" />
                    <span className="text-left leading-tight">
                      <span className="block text-[11px] font-medium uppercase tracking-wider opacity-70">
                        {primary && detected ? 'Dành cho máy của bạn' : 'Tải xuống cho'}
                      </span>
                      <span className="block text-lg">
                        {label} <span className="font-mono text-sm opacity-60">{ext}</span>
                      </span>
                    </span>
                    <Download className="ml-auto size-5 shrink-0 transition-transform group-hover:translate-y-0.5 sm:ml-1" aria-hidden="true" />
                  </a>
                </Button>
              );
            })}
          </div>

          <p className="enter mt-6 max-w-xl text-sm text-paper/60" style={{ '--d': '0.75s' } as React.CSSProperties}>
            {detected
              ? 'Tải trực tiếp từ GitHub Releases. '
              : 'Locket Dio chỉ chạy trên máy tính: hãy mở trang này bằng Windows hoặc macOS. '}
            <a href="#download" className="inline-flex items-center gap-1 font-medium text-paper underline decoration-heart decoration-2 underline-offset-4 hover:text-butter">
              Bản portable và hướng dẫn cài đặt
              <ArrowDown className="size-3.5" aria-hidden="true" />
            </a>
          </p>
        </div>

        {/* Cụm polaroid: ảnh chụp màn hình thật của ứng dụng */}
        <div
          ref={stageRef}
          onPointerMove={onMove}
          onPointerLeave={onLeave}
          className="relative mx-auto aspect-[5/4.4] w-full max-w-[34rem] lg:max-w-none"
        >
          {PRINTS.map((p) => (
            <div
              key={p.src}
              className={`polaroid-float absolute ${p.cls}`}
              style={{ '--rot': p.rot, '--depth': p.depth } as React.CSSProperties}
            >
              <div className="enter-develop" style={{ '--d': p.delay } as React.CSSProperties}>
                <figure className="polaroid m-0">
                  <img
                    src={p.src}
                    alt={p.alt}
                    width={1280}
                    height={960}
                    className="shot"
                    fetchPriority={p.src.includes('02_') ? 'high' : undefined}
                  />
                  <figcaption>{p.caption}</figcaption>
                </figure>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
