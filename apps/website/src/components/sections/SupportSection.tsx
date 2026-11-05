import * as React from 'react';
import { Check, Copy, Heart, QrCode, Star } from 'lucide-react';
import { GithubIcon } from '@/components/icons/GithubIcon';
import { Button } from '@/components/ui/button';

interface SupportSectionProps {
  onOpenDonateModal: () => void;
}

const ACCOUNT = '0369882523';

function CopyButton({ value, idle, done }: { value: string; idle: string; done: string }) {
  const [state, setState] = React.useState<'idle' | 'copied' | 'failed'>('idle');
  const copy = async () => {
    try {
      await navigator.clipboard.writeText(value);
      setState('copied');
      setTimeout(() => setState('idle'), 2000);
    } catch {
      setState('failed');
    }
  };
  return (
    <Button type="button" variant="outline" onClick={copy} className="w-full gap-2 border-paper/30 bg-transparent text-paper hover:bg-paper/10">
      {state === 'copied' ? <Check className="size-4" aria-hidden="true" /> : <Copy className="size-4" aria-hidden="true" />}
      <span aria-live="polite">{state === 'copied' ? done : state === 'failed' ? 'Không chép được, hãy chép thủ công' : idle}</span>
    </Button>
  );
}

const cardCls = 'reveal flex flex-col justify-between gap-6 rounded-3xl border border-paper/10 bg-ink-2 p-6 sm:p-7';

export const SupportSection: React.FC<SupportSectionProps> = ({ onOpenDonateModal }) => (
  <section id="support" aria-labelledby="support-title" className="relative z-10 scroll-mt-16 py-20 sm:py-28">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <p className="eyebrow text-heart">Ủng hộ</p>
        <h2 id="support-title" className="t-h2 mt-3 text-paper">
          Một cốc cà phê cho <span className="text-butter">người làm ra nó.</span>
        </h2>
        <p className="t-lead mt-4 text-paper/75">
          Locket Dio Desktop là dự án cộng đồng, do một người phát triển và duy trì. Ủng hộ giúp dự án có thêm thời gian cho tính năng mới. Không ủng hộ cũng không sao, bạn vẫn dùng đầy đủ.
        </p>
      </div>

      <div className="mt-12 grid gap-5 md:grid-cols-3">
        <div className={cardCls}>
          <div className="space-y-4">
            <span className="inline-flex size-11 items-center justify-center rounded-xl bg-heart text-ink">
              <QrCode className="size-5" aria-hidden="true" />
            </span>
            <h3 className="t-h3 text-paper">Chuyển khoản ngân hàng</h3>
            <dl className="rounded-2xl bg-ink-3 p-4 text-sm">
              <dt className="text-paper/60">MB Bank</dt>
              <dd className="mt-1 font-mono text-xl font-bold tracking-wider text-paper">{ACCOUNT}</dd>
              <dd className="mt-1 text-paper/60">ĐÀO VĂN ĐỢI</dd>
            </dl>
          </div>
          <div className="space-y-2">
            <CopyButton value={ACCOUNT} idle="Chép số tài khoản" done="Đã chép số tài khoản" />
            <Button type="button" variant="glow" onClick={onOpenDonateModal} className="w-full gap-2">
              <QrCode className="size-4" aria-hidden="true" /> Xem mã QR
            </Button>
          </div>
        </div>

        <div className={cardCls} style={{ '--d': '0.08s' } as React.CSSProperties}>
          <div className="space-y-4">
            <span className="inline-flex size-11 items-center justify-center rounded-xl bg-butter text-ink">
              <Heart className="size-5 fill-current" aria-hidden="true" />
            </span>
            <h3 className="t-h3 text-paper">Ví MoMo</h3>
            <dl className="rounded-2xl bg-ink-3 p-4 text-sm">
              <dt className="text-paper/60">Số điện thoại MoMo</dt>
              <dd className="mt-1 font-mono text-xl font-bold tracking-wider text-paper">{ACCOUNT}</dd>
              <dd className="mt-1 text-paper/60">ĐÀO VĂN ĐỢI</dd>
            </dl>
          </div>
          <div className="space-y-2">
            <CopyButton value={ACCOUNT} idle="Chép số MoMo" done="Đã chép số MoMo" />
            <Button type="button" variant="glow" onClick={onOpenDonateModal} className="w-full gap-2">
              <QrCode className="size-4" aria-hidden="true" /> Quét QR MoMo
            </Button>
          </div>
        </div>

        <div className={cardCls} style={{ '--d': '0.16s' } as React.CSSProperties}>
          <div className="space-y-4">
            <span className="inline-flex size-11 items-center justify-center rounded-xl bg-sky text-ink">
              <Star className="size-5 fill-current" aria-hidden="true" />
            </span>
            <h3 className="t-h3 text-paper">Tặng sao, kể bạn bè</h3>
            <p className="text-[0.95rem] leading-relaxed text-paper/70">
              Cách ủng hộ không tốn tiền: tặng một sao trên GitHub hoặc giới thiệu cho bạn bè cũng dùng Locket.
            </p>
          </div>
          <Button asChild variant="outline" className="w-full gap-2 border-paper/30 bg-transparent text-paper hover:bg-paper/10">
            <a href="https://github.com/doi2523/Locket-Desktop" target="_blank" rel="noreferrer">
              <GithubIcon className="size-4" /> Tặng sao trên GitHub
            </a>
          </Button>
        </div>
      </div>
    </div>
  </section>
);
