import * as React from 'react';
import { Apple, ArrowRight, CheckCircle2, Download, Monitor, ShieldCheck, Sparkles } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import type { DownloadStats } from '@/types/download';

interface HeroSectionProps {
  stats: DownloadStats;
  onSelectPlatform: (platform: 'windows' | 'macos') => void;
}

export const HeroSection: React.FC<HeroSectionProps> = ({ stats, onSelectPlatform }) => {
  return (
    <section id="hero" className="relative min-h-screen flex items-center pt-28 pb-20">
      <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
        <div className="text-center max-w-4xl mx-auto space-y-6">
          {/* Top Announcement Badge */}
          <div className="inline-flex items-center gap-2">
            <Badge
              variant="amber"
              className="px-4 py-1.5 text-xs sm:text-sm font-semibold rounded-full border-0 bg-amber-500/15 backdrop-blur-md"
            >
              <Sparkles className="w-3.5 h-3.5 text-amber-500 animate-pulse" />
              <span>Phiên bản mới {stats.latestVersion} chính thức ra mắt</span>
              <span className="text-muted-foreground hidden sm:inline">• Miễn phí 100%</span>
            </Badge>
          </div>

          {/* Main Headline */}
          <h1 className="text-4xl sm:text-6xl lg:text-7xl font-extrabold tracking-tight text-foreground leading-[1.15]">
            Locket Ngay Trên{' '}
            <span className="bg-gradient-to-r from-amber-500 via-orange-500 to-amber-600 bg-clip-text text-transparent">
              Màn Hình Máy Tính
            </span>
          </h1>

          {/* Subtitle */}
          <p className="text-lg sm:text-xl text-muted-foreground max-w-2xl mx-auto leading-relaxed">
            Xem trọn vẹn feed bạn bè theo thời gian thực, nhắn tin cực nhanh qua SSE và đăng moment sống động với Studio iPhone 14 Pro Max độc quyền trên <span className="font-semibold text-foreground">Windows</span> & <span className="font-semibold text-foreground">macOS</span>.
          </p>

          {/* 2 Main Download Buttons (Windows & macOS) */}
          <div className="pt-4 flex flex-col sm:flex-row items-center justify-center gap-4">
            {/* macOS Button */}
            <a
              href="https://github.com/doi2523/Locket-Desktop/releases/latest/download/LocketDio-macOS.dmg"
              onClick={() => onSelectPlatform('macos')}
              className="w-full sm:w-auto"
            >
              <Button
                variant="glow"
                size="xl"
                className="w-full sm:w-auto gap-3 text-base shadow-xl group cursor-pointer"
              >
                <Apple className="w-6 h-6 fill-current transition-transform group-hover:scale-110" />
                <div className="text-left">
                  <div className="text-[11px] uppercase tracking-wider text-white/80 font-medium">
                    Tải về cho
                  </div>
                  <div className="text-base font-bold leading-none">macOS (.dmg)</div>
                </div>
                <Download className="w-5 h-5 ml-1 transition-transform group-hover:translate-y-0.5" />
              </Button>
            </a>

            {/* Windows Button */}
            <a
              href="https://github.com/doi2523/Locket-Desktop/releases/latest/download/LocketDio-Windows-Setup.exe"
              onClick={() => onSelectPlatform('windows')}
              className="w-full sm:w-auto"
            >
              <Button
                variant="secondary"
                size="xl"
                className="w-full sm:w-auto gap-3 text-base shadow-lg border-0 bg-card/60 hover:bg-card/90 backdrop-blur-xl group cursor-pointer"
              >
                <Monitor className="w-6 h-6 text-sky-500 transition-transform group-hover:scale-110" />
                <div className="text-left">
                  <div className="text-[11px] uppercase tracking-wider text-muted-foreground font-medium">
                    Tải về cho
                  </div>
                  <div className="text-base font-bold text-foreground leading-none">
                    Windows (.exe)
                  </div>
                </div>
                <Download className="w-5 h-5 ml-1 text-muted-foreground group-hover:text-foreground transition-transform group-hover:translate-y-0.5" />
              </Button>
            </a>
          </div>

          {/* Value props pills */}
          <div className="pt-2 flex flex-wrap items-center justify-center gap-y-2 gap-x-6 text-xs sm:text-sm text-muted-foreground">
            <span className="flex items-center gap-1.5">
              <CheckCircle2 className="w-4 h-4 text-emerald-500" />
              <span>Hơn {stats.totalDownloads.toLocaleString()} lượt tải</span>
            </span>
            <span className="flex items-center gap-1.5">
              <ShieldCheck className="w-4 h-4 text-sky-500" />
              <span>Không chứa quảng cáo</span>
            </span>
            <span className="flex items-center gap-1.5">
              <Sparkles className="w-4 h-4 text-amber-500" />
              <span>Tự cập nhật OTA 1 chạm</span>
            </span>
          </div>

          {/* Secondary CTA to full downloads */}
          <div className="pt-1">
            <a
              href="#download"
              className="inline-flex items-center gap-1.5 text-xs text-muted-foreground hover:text-amber-500 font-medium transition-colors"
            >
              <span>Xem chi tiết file nén Portable, mã Checksum SHA-256 & hướng dẫn</span>
              <ArrowRight className="w-3.5 h-3.5" />
            </a>
          </div>
        </div>

        {/* Hero App Mockup / Screenshot Showcase */}
        <div className="mt-14 relative max-w-5xl mx-auto">
          {/* Ambient Glow behind the mockup */}
          <div className="absolute -inset-1.5 bg-gradient-to-r from-amber-500/20 via-sky-500/20 to-purple-500/20 rounded-3xl blur-2xl opacity-75" />

          {/* Window Frame - Borderless Modern Floating Glass */}
          <div className="relative rounded-3xl border-0 bg-card/40 shadow-2xl backdrop-blur-2xl overflow-hidden">
            {/* Window titlebar */}
            <div className="flex items-center justify-between px-5 py-3.5 bg-white/[0.04] select-none">
              <div className="flex items-center gap-2">
                <div className="w-3 h-3 rounded-full bg-rose-500/80" />
                <div className="w-3 h-3 rounded-full bg-amber-500/80" />
                <div className="w-3 h-3 rounded-full bg-emerald-500/80" />
              </div>
              <div className="text-xs font-semibold text-muted-foreground tracking-wide flex items-center gap-2">
                <img src="/app-icon.png" alt="Icon" className="w-4 h-4 rounded" />
                <span>Locket Dio Desktop — Giao diện 3 cột trực quan</span>
              </div>
              <div className="text-xs text-muted-foreground font-mono">
                {stats.latestVersion}
              </div>
            </div>

            {/* Window Image content */}
            <div className="relative aspect-[16/9] w-full overflow-hidden bg-background/20">
              <img
                src="/screenshots/02_chat_feed.png"
                alt="Locket Dio Desktop Giao diện chính"
                className="w-full h-full object-cover object-top hover:scale-[1.01] transition-transform duration-500"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
