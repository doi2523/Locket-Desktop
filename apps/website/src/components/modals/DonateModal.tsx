import * as React from 'react';
import { Check, Copy, Heart } from 'lucide-react';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';

interface DonateModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export const DonateModal: React.FC<DonateModalProps> = ({ open, onOpenChange }) => {
  const [copiedBank, setCopiedBank] = React.useState(false);
  const [activeTab, setActiveTab] = React.useState<'mb' | 'momo'>('mb');

  const copyText = (text: string) => {
    navigator.clipboard.writeText(text);
    setCopiedBank(true);
    setTimeout(() => setCopiedBank(false), 2000);
  };

  // VietQR standard URL for fast QR generation
  const vietQrUrl =
    'https://img.vietqr.io/image/MB-0369882523-compact2.png?amount=0&addInfo=Ung%20ho%20Locket%20Dio&accountName=DAO%20VAN%20DOI';

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md sm:max-w-lg">
        <DialogHeader>
          <div className="flex items-center gap-2 mb-1">
            <Badge variant="secondary" className="text-rose-500 border-rose-500/30">
              <Heart className="w-3.5 h-3.5 fill-rose-500" /> Ủng Hộ Tác Giả
            </Badge>
          </div>
          <DialogTitle className="text-2xl font-bold">
            Ủng Hộ Phát Triển Locket Dio
          </DialogTitle>
          <DialogDescription className="text-xs sm:text-sm">
            Quét mã QR dưới đây bằng ứng dụng Ngân hàng (VietQR) hoặc ví MoMo để gửi tiền ủng hộ máy chủ.
          </DialogDescription>
        </DialogHeader>

        {/* Tab switcher */}
        <div className="flex justify-center my-1">
          <div className="grid grid-cols-2 w-full max-w-xs bg-muted p-1 rounded-xl">
            <button
              onClick={() => setActiveTab('mb')}
              className={`py-1.5 text-xs font-bold rounded-lg transition-all ${
                activeTab === 'mb'
                  ? 'bg-background text-foreground shadow-sm'
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              Ngân Hàng MB Bank
            </button>
            <button
              onClick={() => setActiveTab('momo')}
              className={`py-1.5 text-xs font-bold rounded-lg transition-all ${
                activeTab === 'momo'
                  ? 'bg-background text-foreground shadow-sm'
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              Ví Điện Tử MoMo
            </button>
          </div>
        </div>

        {/* QR Display */}
        <div className="flex flex-col items-center justify-center p-4 bg-white/[0.04] rounded-3xl border-0">
          <div className="relative p-2 bg-white rounded-2xl shadow-md">
            <img
              src={vietQrUrl}
              alt="Mã QR Chuyển khoản ủng hộ"
              className="w-56 h-auto rounded-xl object-contain mx-auto"
            />
          </div>

          {/* Account info */}
          <div className="mt-4 text-center space-y-1">
            <div className="text-xs text-muted-foreground">
              {activeTab === 'mb' ? 'Ngân hàng Quân Đội (MB Bank)' : 'Ví Điện Tử MoMo'}
            </div>
            <div className="text-lg font-mono font-extrabold text-foreground tracking-wider">
              0369882523
            </div>
            <div className="text-xs font-bold text-foreground">
              Chủ tài khoản: ĐÀO VĂN ĐỢI
            </div>
          </div>
        </div>

        <div className="flex flex-col sm:flex-row gap-2 pt-1">
          <Button
            variant="outline"
            size="default"
            onClick={() => copyText('0369882523')}
            className="flex-1 text-xs gap-1.5 cursor-pointer"
          >
            {copiedBank ? (
              <>
                <Check className="w-3.5 h-3.5 text-emerald-500" />
                <span className="text-emerald-500 font-semibold">Đã sao chép 0369882523</span>
              </>
            ) : (
              <>
                <Copy className="w-3.5 h-3.5" />
                <span>Sao chép số tài khoản (0369882523)</span>
              </>
            )}
          </Button>
          <Button
            variant="secondary"
            size="default"
            onClick={() => onOpenChange(false)}
            className="cursor-pointer text-xs"
          >
            Đóng
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
};
