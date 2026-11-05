import * as React from 'react';
import { Apple, DownloadCloud, Monitor, Star, TrendingUp, Users } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import type { DownloadStats } from '@/types/download';

interface StatsSectionProps {
  stats: DownloadStats;
  loading?: boolean;
}

export const StatsSection: React.FC<StatsSectionProps> = ({ stats, loading = false }) => {
  return (
    <section className="py-20 relative z-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col sm:flex-row items-center justify-between gap-4 mb-10">
          <div>
            <div className="flex items-center gap-2 mb-1.5">
              <Badge variant="amber" className="text-xs border-0 bg-amber-500/15">
                <TrendingUp className="w-3 h-3" /> Số liệu thực tế
              </Badge>
              <span className="text-xs text-muted-foreground">
                Cập nhật lần cuối: {stats.releaseDate}
              </span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-extrabold tracking-tight text-foreground">
              Thống Kê Lượt Tải & Cộng Đồng Người Dùng
            </h2>
          </div>
          <p className="text-sm text-muted-foreground max-w-sm sm:text-right">
            Dữ liệu tải về từ kho ứng dụng chính thức và hệ thống phát hành Locket Dio Desktop.
          </p>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-6">
          {/* Total Downloads */}
          <Card className="border-0 bg-card/35 hover:bg-card/60 backdrop-blur-xl transition-all duration-300 hover:scale-[1.02] shadow-none">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">
                  Tổng lượt tải
                </span>
                <div className="w-10 h-10 rounded-2xl bg-amber-500/10 text-amber-500 flex items-center justify-center">
                  <DownloadCloud className="w-5 h-5" />
                </div>
              </div>
              <div className="text-2xl sm:text-3xl font-extrabold tracking-tight text-foreground">
                {loading ? '...' : `${stats.totalDownloads.toLocaleString()}+`}
              </div>
              <p className="text-xs text-muted-foreground mt-1">
                Toàn bộ các phiên bản phát hành
              </p>
            </CardContent>
          </Card>

          {/* Windows Downloads */}
          <Card className="border-0 bg-card/35 hover:bg-card/60 backdrop-blur-xl transition-all duration-300 hover:scale-[1.02] shadow-none">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">
                  Bản Windows
                </span>
                <div className="w-10 h-10 rounded-2xl bg-sky-500/10 text-sky-500 flex items-center justify-center">
                  <Monitor className="w-5 h-5" />
                </div>
              </div>
              <div className="text-2xl sm:text-3xl font-extrabold tracking-tight text-foreground">
                {loading ? '...' : `${stats.windowsDownloads.toLocaleString()}+`}
              </div>
              <p className="text-xs text-muted-foreground mt-1">
                Bao gồm Setup.exe & Portable
              </p>
            </CardContent>
          </Card>

          {/* macOS Downloads */}
          <Card className="border-0 bg-card/35 hover:bg-card/60 backdrop-blur-xl transition-all duration-300 hover:scale-[1.02] shadow-none">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">
                  Bản macOS
                </span>
                <div className="w-10 h-10 rounded-2xl bg-purple-500/10 text-purple-500 flex items-center justify-center">
                  <Apple className="w-5 h-5" />
                </div>
              </div>
              <div className="text-2xl sm:text-3xl font-extrabold tracking-tight text-foreground">
                {loading ? '...' : `${stats.macosDownloads.toLocaleString()}+`}
              </div>
              <p className="text-xs text-muted-foreground mt-1">
                Apple Silicon & Intel DMG
              </p>
            </CardContent>
          </Card>

          {/* Rating / Active Users */}
          <Card className="border-0 bg-card/35 hover:bg-card/60 backdrop-blur-xl transition-all duration-300 hover:scale-[1.02] shadow-none">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">
                  Đánh giá người dùng
                </span>
                <div className="w-10 h-10 rounded-2xl bg-emerald-500/10 text-emerald-500 flex items-center justify-center">
                  <Star className="w-5 h-5 fill-emerald-500/30" />
                </div>
              </div>
              <div className="text-2xl sm:text-3xl font-extrabold tracking-tight text-foreground flex items-baseline gap-2">
                <span>{loading ? '...' : stats.rating.toFixed(1)}</span>
                <span className="text-xs text-muted-foreground font-normal">/ 5.0 ⭐</span>
              </div>
              <p className="text-xs text-muted-foreground mt-1 flex items-center gap-1">
                <Users className="w-3.5 h-3.5" />
                <span>{stats.reviewsCount.toLocaleString()}+ đánh giá tích cực</span>
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    </section>
  );
};
