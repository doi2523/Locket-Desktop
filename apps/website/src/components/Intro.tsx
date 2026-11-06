import * as React from 'react';

/**
 * Màn chào ngắn (~1,4s). Không chặn tương tác: overlay có pointer-events-none,
 * nội dung trang bên dưới vẫn dùng được ngay.
 */
export const Intro: React.FC<{ onDone: () => void }> = ({ onDone }) => (
  <div
    aria-hidden="true"
    onAnimationEnd={(e) => {
      if (e.animationName === 'splash-out') onDone();
    }}
    className="pointer-events-none fixed inset-0 z-[100] flex items-center justify-center bg-ink"
    style={{ animation: 'splash-out 1.4s cubic-bezier(0.7,0,0.2,1) forwards' }}
  >
    <div
      className="flex flex-col items-center gap-5"
      style={{ animation: 'splash-logo 0.9s cubic-bezier(0.2,0.8,0.2,1) both' }}
    >
      <img
        src="/app-icon.png"
        alt="Locket Dio"
        className="size-32 sm:size-36"
      />
      <div className="flex flex-col items-center gap-1">
        <span className="font-display text-3xl sm:text-4xl font-extrabold tracking-tight text-paper">
          Locket Dio
        </span>
        <span className="font-mono text-xs uppercase tracking-widest text-paper/60">
          Desktop
        </span>
      </div>
    </div>
  </div>
);
