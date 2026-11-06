import * as React from 'react';
import { Check, Copy, Star } from 'lucide-react';
import { GithubIcon } from '@/components/icons/GithubIcon';
import { Button } from '@/components/ui/button';

const DONATE_IMAGE_URL = '/images/donate_momo.png';
const DEFAULT_MESSAGE = 'Ung ho locket dio';
const ACCOUNT_NAME = 'ĐÀO VĂN ĐÔI';

/** Chép vào clipboard, có phương án dự phòng cho trình duyệt chặn Clipboard API. */
async function copyText(text: string): Promise<boolean> {
  try {
    await navigator.clipboard.writeText(text);
    return true;
  } catch {
    const ta = document.createElement('textarea');
    ta.value = text;
    ta.setAttribute('readonly', '');
    ta.style.position = 'fixed';
    ta.style.opacity = '0';
    document.body.appendChild(ta);
    ta.select();
    try {
      return document.execCommand('copy');
    } catch {
      return false;
    } finally {
      document.body.removeChild(ta);
    }
  }
}

function CopyButton({ text, label, className = '' }: { text: string; label: string; className?: string }) {
  const [state, setState] = React.useState<'idle' | 'copied' | 'failed'>('idle');
  const onClick = async () => {
    setState((await copyText(text)) ? 'copied' : 'failed');
    setTimeout(() => setState('idle'), 2000);
  };
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label={`${label}: ${text}`}
      className={`inline-flex shrink-0 cursor-pointer items-center gap-1.5 rounded-lg bg-paper/10 px-3 py-1.5 text-xs font-semibold text-paper transition-all hover:bg-paper/20 active:scale-95 ${className}`}
    >
      {state === 'copied' ? <Check className="size-3.5 text-butter" aria-hidden="true" /> : <Copy className="size-3.5" aria-hidden="true" />}
      <span aria-live="polite" className={state === 'copied' ? 'text-butter' : ''}>
        {state === 'copied' ? 'Đã chép' : state === 'failed' ? 'Không chép được' : 'Sao chép'}
      </span>
    </button>
  );
}

export const SupportSection: React.FC = () => {
  const [message, setMessage] = React.useState(DEFAULT_MESSAGE);

  return (
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
            {/* Ảnh QR được cắt bỏ dải "Thêm số tiền" của ứng dụng MoMo ở đáy ảnh gốc */}
            <div className="mx-auto w-full max-w-[17rem] overflow-hidden rounded-2xl bg-white p-2.5 shadow-md sm:mx-0">
              <img
                src={DONATE_IMAGE_URL}
                alt={`Mã QR ủng hộ qua MoMo hoặc VietQR, chủ tài khoản ${ACCOUNT_NAME}`}
                width={1290}
                height={1100}
                loading="lazy"
                decoding="async"
                className="aspect-[1290/1100] h-auto w-full rounded-xl object-cover object-top"
              />
            </div>

            <div className="min-w-0 space-y-4">
              <div>
                <h3 className="t-h3 text-paper">Ủng hộ qua MoMo / Chuyển khoản</h3>
                <p className="mt-2 text-sm leading-relaxed text-paper/70">
                  Quét mã QR bằng ứng dụng MoMo hoặc bất kỳ ứng dụng ngân hàng nào hỗ trợ VietQR. Không quét được thì chuyển theo số bên dưới.
                </p>
              </div>


              <div className="space-y-1.5">
                <label htmlFor="donate-message" className="block text-xs font-medium text-paper/70">
                  Nội dung chuyển khoản (gợi ý)
                </label>
                <div className="relative flex items-center">
                  <input
                    id="donate-message"
                    type="text"
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    onFocus={(e) => e.target.select()}
                    aria-describedby="donate-message-hint"
                    className="w-full rounded-xl border border-paper/20 bg-ink-3 px-3.5 py-2.5 pr-28 font-mono text-sm text-paper outline-none transition-colors focus:border-butter focus:ring-1 focus:ring-butter"
                  />
                  <CopyButton text={message} label="Sao chép nội dung chuyển khoản" className="absolute right-1.5 top-1/2 -translate-y-1/2" />
                </div>
                <p id="donate-message-hint" className="text-xs text-paper/50">
                  Dán nội dung này vào ô lời nhắn khi chuyển. Mã QR không tự điền sẵn nội dung.
                </p>
              </div>
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
};
