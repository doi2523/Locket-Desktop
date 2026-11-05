import * as React from 'react';
import { Heart, Shield, Sparkles, Terminal } from 'lucide-react';
import { GithubIcon } from '@/components/icons/GithubIcon';

interface FooterProps {
  onOpenDonate?: () => void;
}

export const Footer: React.FC<FooterProps> = ({ onOpenDonate }) => {
  return (
    <footer className="border-0 pt-20 pb-12 relative z-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-10 mb-12">
          {/* Col 1: Brand */}
          <div className="md:col-span-2 space-y-4">
            <div className="flex items-center gap-3">
              <img
                src="/app-icon.png"
                alt="Locket Dio Icon"
                className="w-9 h-9 rounded-2xl shadow-sm"
              />
              <span className="font-extrabold text-xl tracking-tight text-foreground">
                Locket Dio Desktop
              </span>
            </div>
            <p className="text-sm text-muted-foreground leading-relaxed max-w-md">
              Ứng dụng Locket độc lập cho máy tính Windows & macOS. Xem khoảnh khắc bạn bè theo thời gian thực, nhắn tin cực nhanh qua SSE và đăng moment chất lượng cao với Studio chuyên nghiệp.
            </p>
            <div className="flex items-center gap-4 text-xs text-muted-foreground pt-2">
              <span className="inline-flex items-center gap-1.5">
                <Shield className="w-4 h-4 text-emerald-500" /> Miễn phí & An toàn
              </span>
              <span className="inline-flex items-center gap-1.5">
                <Terminal className="w-4 h-4 text-sky-500" /> Flutter + Go Backend
              </span>
              <span className="inline-flex items-center gap-1.5">
                <Sparkles className="w-4 h-4 text-amber-500" /> Tự động OTA
              </span>
            </div>
          </div>

          {/* Col 2: Navigation */}
          <div className="space-y-3">
            <h4 className="text-sm font-bold text-foreground tracking-wider uppercase">
              Điều Hướng
            </h4>
            <ul className="space-y-2 text-sm text-muted-foreground">
              <li>
                <a href="#hero" className="hover:text-foreground transition-colors">
                  Trang chủ
                </a>
              </li>
              <li>
                <a href="#features" className="hover:text-foreground transition-colors">
                  Giới thiệu tính năng
                </a>
              </li>
              <li>
                <a href="#download" className="hover:text-foreground transition-colors">
                  Tải cho Windows
                </a>
              </li>
              <li>
                <a href="#download" className="hover:text-foreground transition-colors">
                  Tải cho macOS
                </a>
              </li>
              <li>
                <button
                  onClick={onOpenDonate}
                  className="hover:text-rose-400 transition-colors text-left cursor-pointer"
                >
                  Ủng hộ nhà phát triển
                </button>
              </li>
            </ul>
          </div>

          {/* Col 3: Resources & Community */}
          <div className="space-y-3">
            <h4 className="text-sm font-bold text-foreground tracking-wider uppercase">
              Cộng Đồng & Mã Nguồn
            </h4>
            <ul className="space-y-2 text-sm text-muted-foreground">
              <li>
                <a
                  href="https://github.com/doi2523/Locket-Desktop"
                  target="_blank"
                  rel="noreferrer"
                  className="flex items-center gap-2 hover:text-foreground transition-colors"
                >
                  <GithubIcon className="w-4 h-4" /> GitHub Repository
                </a>
              </li>
              <li>
                <a
                  href="https://github.com/doi2523/Locket-Desktop/releases/latest"
                  target="_blank"
                  rel="noreferrer"
                  className="hover:text-foreground transition-colors"
                >
                  Bản phát hành mới nhất (Releases)
                </a>
              </li>
              <li>
                <a
                  href="https://github.com/doi2523/Locket-Desktop/issues"
                  target="_blank"
                  rel="noreferrer"
                  className="hover:text-foreground transition-colors"
                >
                  Báo cáo lỗi & Góp ý tính năng
                </a>
              </li>
            </ul>
          </div>
        </div>

        <div className="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-muted-foreground">
          <p>© 2026 Locket Dio Project. Bản quyền thuộc về tác giả doi2523.</p>
          <div className="flex items-center gap-1.5">
            <span>Được xây dựng với</span>
            <Heart className="w-3.5 h-3.5 text-rose-500 fill-rose-500" />
            <span>dành cho cộng đồng người dùng Locket</span>
          </div>
        </div>
      </div>
    </footer>
  );
};
