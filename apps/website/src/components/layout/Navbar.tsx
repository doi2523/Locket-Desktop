import * as React from 'react';
import { Download, Heart, Menu, Star, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { GithubIcon } from '@/components/icons/GithubIcon';
import { getStarCount } from '@/services/downloadService';

/** Thứ tự link trùng với thứ tự các mục trên trang. */
const LINKS: ReadonlyArray<{ href: string; label: string; heart?: boolean }> = [
  { href: '#hero', label: 'Trang chủ' },
  { href: '#about', label: 'Giới thiệu' },
  { href: '#download', label: 'Tải xuống' },
  { href: '#support', label: 'Ủng hộ', heart: true },
  { href: '#features', label: 'Tính năng' },
  { href: '#community', label: 'Cộng đồng' },
];

export const Navbar: React.FC = () => {
  const [open, setOpen] = React.useState(false);
  const [scrolled, setScrolled] = React.useState(false);
  const [stars, setStars] = React.useState<number | null>(null);

  React.useEffect(() => {
    const controller = new AbortController();
    getStarCount(controller.signal).then(setStars);
    return () => controller.abort();
  }, []);

  React.useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 16);
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  React.useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => e.key === 'Escape' && setOpen(false);
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [open]);

  const linkCls =
    'rounded-full px-4 py-2 text-sm font-semibold text-paper/80 transition-colors hover:bg-paper/10 hover:text-paper';

  return (
    <header
      className={`fixed inset-x-0 top-0 z-50 transition-colors duration-300 ${
        scrolled || open ? 'bg-ink/85 backdrop-blur-md' : 'bg-transparent'
      }`}
    >
      <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-5 sm:px-8">
        <a href="#hero" className="flex items-center gap-3" aria-label="Locket Dio Desktop, về đầu trang">
          <img src="/app-icon.png" alt="" className="size-9" />
          <span className="font-display text-lg font-extrabold tracking-tight text-paper">
            Locket Dio <span className="font-medium text-paper/60">Desktop</span>
          </span>
        </a>

        <nav aria-label="Điều hướng chính" className="hidden items-center gap-0.5 lg:flex">
          {LINKS.map((l) => (
            <a key={l.href} href={l.href} className={`${linkCls} inline-flex items-center gap-1.5`}>
              {l.heart && <Heart className="size-3.5 fill-heart text-heart" aria-hidden="true" />}
              {l.label}
            </a>
          ))}
        </nav>

        <div className="flex items-center gap-2">
          <a
            href="https://github.com/doi2523/Locket-Desktop"
            target="_blank"
            rel="noreferrer"
            aria-label={stars === null ? "Mã nguồn trên GitHub" : `Mã nguồn trên GitHub, ${stars} sao`}
            className="hidden items-center gap-2 rounded-full p-2.5 text-paper/80 transition-colors hover:bg-paper/10 hover:text-paper sm:inline-flex"
          >
            <GithubIcon className="size-5" />
            {stars !== null && (
              <span className="inline-flex items-center gap-1 pr-1 text-sm font-semibold tabular-nums">
                <Star className="size-3.5 fill-butter text-butter" aria-hidden="true" />
                {stars.toLocaleString("vi-VN")}
              </span>
            )}
          </a>
          <Button asChild variant="glow" size="sm" className="h-10 px-4">
            <a href="#download">
              <Download className="size-4" aria-hidden="true" />
              Tải xuống
            </a>
          </Button>
          <button
            type="button"
            onClick={() => setOpen((v) => !v)}
            aria-expanded={open}
            aria-controls="mobile-nav"
            aria-label={open ? 'Đóng menu' : 'Mở menu'}
            className="inline-flex size-10 cursor-pointer items-center justify-center rounded-full text-paper hover:bg-paper/10 lg:hidden"
          >
            {open ? <X className="size-6" /> : <Menu className="size-6" />}
          </button>
        </div>
      </div>

      {open && (
        <nav id="mobile-nav" aria-label="Điều hướng di động" className="border-t border-paper/10 px-5 pb-6 pt-3 lg:hidden">
          <ul className="flex flex-col">
            {LINKS.map((l) => (
              <li key={l.href}>
                <a
                  href={l.href}
                  onClick={() => setOpen(false)}
                  className="flex items-center gap-2 rounded-xl px-3 py-3 font-display text-2xl font-bold text-paper hover:bg-paper/10"
                >
                  {l.label}
                  {l.heart && <Heart className="size-5 fill-heart text-heart" aria-hidden="true" />}
                </a>
              </li>
            ))}
            <li className="mt-2 border-t border-paper/10 pt-4">
              <a
                href="https://github.com/doi2523/Locket-Desktop"
                target="_blank"
                rel="noreferrer"
                className="flex items-center gap-2 px-3 text-sm text-paper/70 hover:text-paper"
              >
                <GithubIcon className="size-4" /> doi2523/Locket-Desktop
              </a>
            </li>
          </ul>
        </nav>
      )}
    </header>
  );
};
