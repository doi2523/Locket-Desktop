import * as React from 'react';
import {
  Check,
  Coffee,
  Copy,
  Heart,
  QrCode,
  ShieldCheck,
  Sparkles,
} from 'lucide-react';
import { GithubIcon } from '@/components/icons/GithubIcon';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';

interface SupportSectionProps {
  onOpenDonateModal: () => void;
}

export const SupportSection: React.FC<SupportSectionProps> = ({ onOpenDonateModal }) => {
  const [copiedBank, setCopiedBank] = React.useState(false);

  const copyText = (text: string) => {
    navigator.clipboard.writeText(text);
    setCopiedBank(true);
    setTimeout(() => setCopiedBank(false), 2000);
  };

  return (
    <section id="support" className="py-24 relative z-10 overflow-hidden">
      {/* Decorative gradient glow */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-rose-500/10 rounded-full blur-3xl pointer-events-none" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center max-w-3xl mx-auto mb-16 space-y-4">
          <Badge variant="secondary" className="px-3.5 py-1 text-xs border-0 bg-rose-500/15 text-rose-500">
            <Heart className="w-3.5 h-3.5 fill-rose-500" /> Đồng hành & Ủng hộ
          </Badge>
          <h2 className="text-3xl sm:text-5xl font-extrabold tracking-tight text-foreground">
            Tiếp Sức Cho Dự Án Locket Dio
          </h2>
          <p className="text-base sm:text-lg text-muted-foreground leading-relaxed">
            Locket Dio Desktop là dự án cộng đồng độc lập, được phát triển và duy trì với tâm huyết nhằm mang lại trải nghiệm máy tính tốt nhất cho bạn. Mọi sự ủng hộ của bạn là động lực to lớn giúp duy trì máy chủ và phát triển các tính năng mới!
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mx-auto">
          {/* Method 1: VietQR / Chuyển khoản ngân hàng */}
          <Card className="border-0 bg-card/35 hover:bg-card/65 backdrop-blur-2xl rounded-3xl shadow-none transition-all duration-300">
            <CardContent className="p-7 flex flex-col justify-between h-full space-y-6">
              <div className="space-y-4">
                <div className="w-12 h-12 rounded-2xl bg-rose-500/10 text-rose-500 flex items-center justify-center">
                  <QrCode className="w-6 h-6" />
                </div>
                <div>
                  <h3 className="font-bold text-lg text-foreground">
                    Chuyển Khoản Ngân Hàng / VietQR
                  </h3>
                  <p className="text-xs text-muted-foreground mt-1">
                    Ủng hộ trực tiếp qua mã QR thanh toán nhanh liên ngân hàng Napas 24/7.
                  </p>
                </div>

                <div className="bg-white/[0.04] p-4 rounded-2xl text-xs space-y-1.5 font-mono">
                  <div className="text-muted-foreground font-sans text-[11px]">Ngân hàng Quân Đội (MB Bank)</div>
                  <div className="text-foreground font-bold text-base tracking-wider">0369882523</div>
                  <div className="text-muted-foreground font-sans text-[11px]">Chủ TK: ĐÀO VĂN ĐỢI</div>
                </div>
              </div>

              <div className="space-y-2">
                <Button
                  variant="secondary"
                  size="sm"
                  onClick={() => copyText('0369882523')}
                  className="w-full text-xs gap-1.5 cursor-pointer border-0 bg-white/[0.06] hover:bg-white/[0.12]"
                >
                  {copiedBank ? (
                    <>
                      <Check className="w-3.5 h-3.5 text-emerald-500" />
                      <span className="text-emerald-500">Đã chép số tài khoản</span>
                    </>
                  ) : (
                    <>
                      <Copy className="w-3.5 h-3.5" />
                      <span>Sao chép STK MB Bank</span>
                    </>
                  )}
                </Button>
                <Button
                  variant="glow"
                  size="sm"
                  onClick={onOpenDonateModal}
                  className="w-full text-xs gap-1.5 cursor-pointer"
                >
                  <QrCode className="w-3.5 h-3.5" />
                  <span>Xem mã QR Quét Nhanh</span>
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* Method 2: MoMo Ví Điện Tử */}
          <Card className="border-0 bg-card/35 hover:bg-card/65 backdrop-blur-2xl rounded-3xl shadow-none transition-all duration-300">
            <CardContent className="p-7 flex flex-col justify-between h-full space-y-6">
              <div className="space-y-4">
                <div className="w-12 h-12 rounded-2xl bg-pink-500/10 text-pink-500 flex items-center justify-center">
                  <Heart className="w-6 h-6 fill-pink-500" />
                </div>
                <div>
                  <h3 className="font-bold text-lg text-foreground">
                    Ví Điện Tử MoMo
                  </h3>
                  <p className="text-xs text-muted-foreground mt-1">
                    Gửi tặng cốc cafe hoặc lời nhắn khích lệ tác giả qua ví MoMo.
                  </p>
                </div>

                <div className="bg-white/[0.04] p-4 rounded-2xl text-xs space-y-1.5 font-mono">
                  <div className="text-muted-foreground font-sans text-[11px]">Ví điện tử MoMo</div>
                  <div className="text-foreground font-bold text-base tracking-wider">0369882523</div>
                  <div className="text-muted-foreground font-sans text-[11px]">Tên: ĐÀO VĂN ĐỢI</div>
                </div>
              </div>

              <div className="space-y-2">
                <Button
                  variant="secondary"
                  size="sm"
                  onClick={() => copyText('0369882523')}
                  className="w-full text-xs gap-1.5 cursor-pointer border-0 bg-white/[0.06] hover:bg-white/[0.12]"
                >
                  {copiedBank ? (
                    <>
                      <Check className="w-3.5 h-3.5 text-emerald-500" />
                      <span className="text-emerald-500">Đã chép số MoMo</span>
                    </>
                  ) : (
                    <>
                      <Copy className="w-3.5 h-3.5" />
                      <span>Sao chép SĐT MoMo</span>
                    </>
                  )}
                </Button>
                <Button
                  variant="glow"
                  size="sm"
                  onClick={onOpenDonateModal}
                  className="w-full text-xs gap-1.5 cursor-pointer"
                >
                  <QrCode className="w-3.5 h-3.5" />
                  <span>Quét QR MoMo</span>
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* Method 3: GitHub Star & Chia sẻ */}
          <Card className="border-0 bg-card/35 hover:bg-card/65 backdrop-blur-2xl rounded-3xl shadow-none transition-all duration-300">
            <CardContent className="p-7 flex flex-col justify-between h-full space-y-6">
              <div className="space-y-4">
                <div className="w-12 h-12 rounded-2xl bg-amber-500/10 text-amber-500 flex items-center justify-center">
                  <Coffee className="w-6 h-6" />
                </div>
                <div>
                  <h3 className="font-bold text-lg text-foreground">
                    Tặng Sao & Chia Sẻ Bạn Bè
                  </h3>
                  <p className="text-xs text-muted-foreground mt-1">
                    Nếu bạn thấy ứng dụng hữu ích, hãy tặng 1 Star trên GitHub hoặc giới thiệu cho bạn bè cùng dùng!
                  </p>
                </div>

                <div className="space-y-2.5 text-xs text-muted-foreground">
                  <div className="flex items-center gap-2">
                    <Sparkles className="w-4 h-4 text-amber-500 shrink-0" />
                    <span>Miễn phí và mã nguồn mở</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <ShieldCheck className="w-4 h-4 text-emerald-500 shrink-0" />
                    <span>Cập nhật và cải tiến liên tục</span>
                  </div>
                </div>
              </div>

              <div className="space-y-2">
                <a
                  href="https://github.com/doi2523/Locket-Desktop"
                  target="_blank"
                  rel="noreferrer"
                  className="block w-full"
                >
                  <Button
                    variant="secondary"
                    size="sm"
                    className="w-full text-xs gap-2 cursor-pointer border-0 bg-white/[0.06] hover:bg-white/[0.12]"
                  >
                    <GithubIcon className="w-4 h-4" />
                    <span>Tặng Star trên GitHub</span>
                  </Button>
                </a>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </section>
  );
};
