import * as React from 'react';
import { Check, Copy, Star } from 'lucide-react';
import { GithubIcon } from '@/components/icons/GithubIcon';
import { Button } from '@/components/ui/button';

const ACCOUNT = '0369882523';
const VIETQR_URL =
  'https://img.vietqr.io/image/MB-0369882523-compact2.png?amount=0&addInfo=Ung%20ho%20Locket%20Dio&accountName=DAO%20VAN%20DOI';

function CopyAccount() {
  const [state, setState] = React.useState<'idle' | 'copied' | 'failed'>('idle');
  const copy = async () => {
    try {
      await navigator.clipboard.writeText(ACCOUNT);
      setState('copied');
      setTimeout(() => setState('idle'), 2000);
    } catch {
      setState('failed');
    }
  };
  return (
    <Button type="button" variant="outline" onClick={copy} className="w-full gap-2 border-paper/30 bg-transparent text-paper hover:bg-paper/10">
      {state === 'copied' ? <Check className="size-4" aria-hidden="true" /> : <Copy className="size-4" aria-hidden="true" />}
      <span aria-live="polite">
        {state === 'copied' ? 'Đã chép số tài khoản' : state === 'failed' ? 'Không chép được, hãy chép thủ công' : 'Chép số tài khoản'}
      </span>
    </Button>
  );
}

export const SupportSection: React.FC = () => (
  <section id="support" aria-labelledby="support-title" className="relative z-10 pb-6 pt-14 sm:pb-8 sm:pt-20">
    <div className="mx-auto max-w-7xl px-5 sm:px-8">
      <div className="reveal max-w-3xl">
        <h2 id="support-title" className="t-h2 text-heart">
          Ủng hộ
        </h2>
        <p className="t-sub mt-3 text-paper">
          Một cốc cà phê cho <span className="text-butter">người làm ra nó.</span>
        </p>
        <p className="t-lead mt-4 text-paper/75">
          Locket Dio Desktop là dự án cộng đồng, do một người phát triển và duy trì. Ủng hộ giúp dự án có thêm thời gian cho tính năng mới. Không ủng hộ cũng không sao, bạn vẫn dùng đầy đủ.
        </p>
      </div>

      <div className="mt-8 grid gap-5 sm:mt-10 lg:grid-cols-[1.5fr_1fr]">
        <div className="reveal grid gap-6 rounded-3xl border border-paper/10 bg-ink-2 p-6 sm:grid-cols-[auto_1fr] sm:items-center sm:gap-8 sm:p-8">
          <div className="mx-auto w-full max-w-[16rem] rounded-2xl bg-white p-3 sm:mx-0">
            <img
              src={VIETQR_URL}
              alt="Mã QR VietQR chuyển khoản tới MB Bank, tài khoản 0369882523, chủ tài khoản Đào Văn Đợi"
              width={512}
              height={640}
              loading="lazy"
              decoding="async"
              className="h-auto w-full"
            />
          </div>
          <div className="space-y-5">
            <div>
              <h3 className="t-h3 text-paper">Chuyển khoản ngân hàng</h3>
              <p className="mt-1 text-sm text-paper/65">Quét mã bằng app ngân hàng bất kỳ hỗ trợ VietQR.</p>
            </div>
            <dl className="rounded-2xl bg-ink-3 p-4 text-sm">
              <dt className="text-paper/60">MB Bank</dt>
              <dd className="mt-1 break-all font-mono text-xl font-bold tracking-wider text-paper">{ACCOUNT}</dd>
              <dd className="mt-1 text-paper/60">ĐÀO VĂN ĐÔI</dd>
            </dl>
            <CopyAccount />
          </div>
        </div>

        <div className="reveal flex flex-col justify-between gap-6 rounded-3xl border border-paper/10 bg-ink-2 p-6 sm:p-8" style={{ '--d': '0.08s' } as React.CSSProperties}>
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
