import { useEffect } from 'react';

const INTRO_KEY = 'locket-intro-seen';

export function prefersReducedMotion(): boolean {
  return typeof window !== 'undefined' && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
}

/** Intro chỉ chạy ở lần mở đầu tiên của phiên và khi người dùng không tắt chuyển động. */
export function shouldPlayIntro(): boolean {
  if (prefersReducedMotion()) return false;
  try {
    if (sessionStorage.getItem(INTRO_KEY)) return false;
    sessionStorage.setItem(INTRO_KEY, '1');
  } catch {
    /* storage bị chặn: vẫn phát intro một lần */
  }
  return true;
}

/** Bật chế độ chuyển động, quan sát .reveal và cập nhật biến parallax cuộn. */
export function useMotion(): void {
  useEffect(() => {
    const root = document.documentElement;
    if (prefersReducedMotion()) return;
    root.classList.add('motion');

    const io = new IntersectionObserver(
      (entries) => {
        for (const e of entries) {
          if (e.isIntersecting) {
            e.target.setAttribute('data-in', '');
            io.unobserve(e.target);
          }
        }
      },
      { rootMargin: '0px 0px -8% 0px', threshold: 0.08 },
    );
    const watch = (node: ParentNode) => {
      if (node instanceof Element && node.classList.contains('reveal')) io.observe(node);
      node.querySelectorAll('.reveal:not([data-in])').forEach((el) => io.observe(el));
    };
    watch(document);
    // Tab/nội dung mount muộn cũng phải được quan sát, nếu không sẽ bị ẩn vĩnh viễn.
    const mo = new MutationObserver((records) => {
      for (const r of records) r.addedNodes.forEach((n) => n instanceof Element && watch(n));
    });
    mo.observe(document.body, { childList: true, subtree: true });

    let raf = 0;
    const onScroll = () => {
      if (raf) return;
      raf = requestAnimationFrame(() => {
        root.style.setProperty('--sy', String(window.scrollY));
        raf = 0;
      });
    };
    window.addEventListener('scroll', onScroll, { passive: true });

    return () => {
      io.disconnect();
      mo.disconnect();
      window.removeEventListener('scroll', onScroll);
      if (raf) cancelAnimationFrame(raf);
      root.classList.remove('motion');
    };
  }, []);
}
