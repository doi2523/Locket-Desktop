import * as React from 'react';
import { GithubIcon } from '@/components/icons/GithubIcon';

const link = 'rounded text-paper/70 transition-colors hover:text-butter';
const REPO = 'https://github.com/doi2523/Locket-Desktop';

export const Footer: React.FC = () => (
  <footer className="relative z-10 overflow-hidden pt-8">
    <div className="mx-auto grid max-w-7xl gap-10 px-5 sm:px-8 md:grid-cols-[1.4fr_1fr_1fr]">
      <div className="space-y-4">
        <div className="flex items-center gap-3">
          <img src="/app-icon.png" alt="" className="size-10" />
          <span className="font-display text-xl font-extrabold text-paper">Locket Dio Desktop</span>
        </div>
        <p className="max-w-sm text-sm leading-relaxed text-paper/65">
          Ứng dụng Locket độc lập cho Windows và macOS. Dự án cộng đồng, không phải sản phẩm chính thức của Locket.
        </p>
      </div>

      <nav aria-label="Trang" className="text-sm">
        <h2 className="eyebrow text-paper/50">Trang</h2>
        <ul className="mt-4 space-y-2.5">
          <li><a href="#about" className={link}>Giới thiệu</a></li>
          <li><a href="#download" className={link}>Tải xuống</a></li>
          <li><a href="#support" className={link}>Ủng hộ</a></li>
          <li><a href="#features" className={link}>Tính năng</a></li>
          <li><a href="#community" className={link}>Cộng đồng</a></li>
          <li><a href="#explore" className={link}>Khám phá</a></li>
        </ul>
      </nav>

      <nav aria-label="Mã nguồn" className="text-sm">
        <h2 className="eyebrow text-paper/50">Mã nguồn</h2>
        <ul className="mt-4 space-y-2.5">
          <li>
            <a href={REPO} target="_blank" rel="noreferrer" className={`${link} inline-flex items-center gap-2`}>
              <GithubIcon className="size-4" /> GitHub
            </a>
          </li>
          <li><a href={`${REPO}/releases`} target="_blank" rel="noreferrer" className={link}>Các bản phát hành</a></li>
          <li><a href={`${REPO}/issues`} target="_blank" rel="noreferrer" className={link}>Báo lỗi và góp ý</a></li>
        </ul>
      </nav>
    </div>

    <p className="mx-auto mt-8 max-w-7xl px-5 text-xs text-paper/50 sm:px-8">
      © 2026 Locket Dio Project, tác giả doi2523. Apple, macOS và Windows là thương hiệu của chủ sở hữu tương ứng, chỉ dùng để chỉ nền tảng tương thích.
    </p>

    <div aria-hidden="true" className="select-none whitespace-nowrap pt-6 text-center font-display text-[clamp(4rem,19vw,17rem)] font-extrabold leading-[0.8] tracking-tighter text-paper/[0.07]">
      Locket Dio
    </div>
  </footer>
);
