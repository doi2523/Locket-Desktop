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
    <div className="flex flex-col items-center gap-4" style={{ animation: 'splash-logo 0.9s cubic-bezier(0.2,0.8,0.2,1) both' }}>
      <div className="rounded-[1.6rem] bg-paper p-2 pb-6 shadow-[0_18px_40px_-10px_rgb(0_0_0/0.6)] -rotate-3">
        <img src="/app-icon.png" alt="" className="size-24 rounded-xl" />
      </div>
      <span className="font-display text-2xl font-extrabold tracking-tight text-paper">Locket Dio</span>
    </div>
  </div>
);
