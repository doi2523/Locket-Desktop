import * as React from 'react';
import { Check, Copy, Download, ExternalLink, FileArchive, HardDrive, ListChecks, TriangleAlert } from 'lucide-react';
import { AppleIcon, WindowsIcon } from '@/components/icons/PlatformIcons';
import { Button } from '@/components/ui/button';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { formatDate } from '@/lib/utils';
import type { DownloadData, DownloadFile, PlatformDownload, PlatformId } from '@/types/download';

interface DownloadSectionProps {
  data: DownloadData;
  loading: boolean;
  platform: PlatformId;
  onPlatformChange: (platform: PlatformId) => void;
  detected: PlatformId | null;
}

function FileIcon({ file }: { file: DownloadFile }) {
  if (file.format === 'dmg') return <AppleIcon className="size-6" />;
  if (file.format === 'zip') return <FileArchive className="size-6" aria-hidden="true" />;
  return <WindowsIcon className="size-5" />;
}

function ChecksumRow({ checksum }: { checksum: string }) {
  const [state, setState] = React.useState<'idle' | 'copied' | 'failed'>('idle');
  const copy = async () => {
    try {
      await navigator.clipboard.writeText(checksum);
      setState('copied');
      setTimeout(() => setState('idle'), 2000);
    } catch {
      setState('failed');
    }
  };
  return (
    <div className="flex items-center justify-between gap-3 rounded-xl bg-ink/[0.06] px-3 py-2.5 t-meta text-ink/70">
      <span className="truncate" title={checksum}>
        {checksum}
      </span>
      <button
        type="button"
        onClick={copy}
        className="inline-flex shrink-0 cursor-pointer items-center gap-1 font-sans font-semibold text-ink underline underline-offset-4 decoration-heart decoration-2"
      >
        {state === 'copied' ? <Check className="size-3.5" aria-hidden="true" /> : <Copy className="size-3.5" aria-hidden="true" />}
        <span aria-live="polite">{state === 'copied' ? 'Đã chép' : state === 'failed' ? 'Không chép được' : 'Chép SHA-256'}</span>
      </button>
    </div>
  );
}

function FileCard({ file, delay }: { file: DownloadFile; delay: number }) {
  const [started, setStarted] = React.useState(false);
  const onClick = () => {
    setStarted(true);
    setTimeout(() => setStarted(false), 3500);
  };

  return (
    <article className="card-hard reveal space-y-4 p-5 sm:p-6" style={{ '--d': `${delay}s` } as React.CSSProperties}>
      <div className="flex items-start gap-4">
        <div className="flex size-12 shrink-0 items-center justify-center rounded-2xl border-2 border-ink bg-butter text-ink">
          <FileIcon file={file} />
        </div>
        <div className="min-w-0 flex-1">
          <h3 className="t-h3 flex flex-wrap items-center gap-2">
            {file.name}
            {file.recommended && (
              <span className="rounded-full bg-heart px-2.5 py-0.5 font-sans text-[11px] font-bold uppercase tracking-wide text-ink">
                Khuyên dùng
              </span>
            )}
          </h3>
          <p className="mt-0.5 break-all t-meta text-ink/60">{file.filename}</p>
        </div>
      </div>

      <p className="text-[0.95rem] leading-relaxed text-ink/75">{file.description}</p>

      {(file.size || file.downloadsCount !== undefined) && (
        <ul className="flex flex-wrap gap-x-5 gap-y-1 text-sm text-ink/70">
          {file.size && (
            <li className="flex items-center gap-1.5">
              <HardDrive className="size-4" aria-hidden="true" />
              {file.size}
            </li>
          )}
          {file.downloadsCount !== undefined && (
            <li className="flex items-center gap-1.5">
              <Download className="size-4" aria-hidden="true" />
              {file.downloadsCount.toLocaleString('vi-VN')} lượt tải
            </li>
          )}
        </ul>
      )}

      <Button asChild variant={file.recommended ? 'glow' : 'outline'} size="lg" className={`w-full gap-2 ${file.recommended ? '' : 'border-2 border-ink bg-transparent text-ink hover:bg-ink hover:text-paper'}`}>
        <a href={file.downloadUrl} onClick={onClick}>
          {started ? (
            <>
              <Check className="size-5" aria-hidden="true" />
              <span role="status">Đang bắt đầu tải…</span>
            </>
          ) : (
            <>
              <Download className="cta-arrow size-5" aria-hidden="true" />
              Tải xuống <span className="font-mono text-[0.85em] opacity-70">.{file.format}</span>
            </>
          )}
        </a>
      </Button>

      {file.checksum && <ChecksumRow checksum={file.checksum} />}
    </article>
  );
}

function PlatformPanel({ platform }: { platform: PlatformDownload }) {
  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-5">
      <div className="space-y-5 lg:col-span-3">
        {platform.files.map((f, i) => (
          <FileCard key={f.id} file={f} delay={i * 0.08} />
        ))}
      </div>
      <aside className="space-y-6 self-start rounded-3xl border-2 border-dashed border-ink/40 p-5 sm:p-6 lg:col-span-2">
        <div>
          <h3 className="eyebrow text-ink/60">Yêu cầu hệ thống</h3>
          <p className="mt-1.5 font-medium">{platform.osRequirement}</p>
        </div>
        <div>
          <h3 className="eyebrow flex items-center gap-2 text-ink/60">
            <ListChecks className="size-4" aria-hidden="true" />
            Cách cài đặt
          </h3>
          <ol className="mt-3 list-decimal space-y-2.5 pl-5 text-[0.95rem] leading-relaxed text-ink/80 marker:font-bold marker:text-heart">
            {platform.installSteps.map((step) => (
              <li key={step}>{step}</li>
            ))}
          </ol>
        </div>
      </aside>
    </div>
  );
}

function ReleaseSummary({ data, loading }: { data: DownloadData; loading: boolean }) {
  const { release, source } = data;
  const link = 'font-semibold underline underline-offset-4 decoration-heart decoration-2';

  if (loading) {
    return <div className="h-14 animate-pulse rounded-2xl bg-ink/10" role="status" aria-label="Đang tải thông tin phiên bản" />;
  }

  if (!release.version) {
    return (
      <div className="flex items-start gap-3 rounded-2xl bg-butter/70 p-4 text-sm leading-relaxed" role="status">
        <TriangleAlert className="mt-0.5 size-5 shrink-0" aria-hidden="true" />
        <p>
          {source === 'fallback' && 'Chưa lấy được thông tin phiên bản từ GitHub. Các nút bên dưới luôn trỏ tới bản phát hành mới nhất. Bạn cũng có thể xem mọi phiên bản trên '}
          <a href={release.url} className={link} target="_blank" rel="noreferrer">
            trang Releases
          </a>
          .
        </p>
      </div>
    );
  }

  return (
    <div className="space-y-3 rounded-2xl bg-ink p-4 text-paper sm:p-5">
      <div className="flex flex-wrap items-center gap-x-5 gap-y-2 text-sm">
        <span className="font-display text-lg font-bold">Phiên bản {release.version}</span>
        {release.publishedAt && <span className="text-paper/70">Phát hành {formatDate(release.publishedAt)}</span>}
        {release.totalDownloads !== null && (
          <span className="text-paper/70">{release.totalDownloads.toLocaleString('vi-VN')} lượt tải</span>
        )}
        <a href={release.url} target="_blank" rel="noreferrer" className="ml-auto inline-flex items-center gap-1 font-semibold text-butter hover:underline">
          Xem trên GitHub <ExternalLink className="size-3.5" aria-hidden="true" />
        </a>
      </div>
      {release.notes && (
        <details className="text-sm text-paper/80">
          <summary className="cursor-pointer font-semibold text-paper">Có gì mới</summary>
          <pre className="mt-2 max-h-56 overflow-auto whitespace-pre-wrap font-sans leading-relaxed">{release.notes}</pre>
        </details>
      )}
    </div>
  );
}

export const DownloadSection: React.FC<DownloadSectionProps> = ({ data, loading, platform, onPlatformChange, detected }) => {
  const trigger =
    'h-full cursor-pointer gap-2.5 rounded-xl px-4 font-display text-lg font-bold text-ink transition-colors data-[state=active]:bg-ink data-[state=active]:text-paper';

  return (
    <section id="download" aria-labelledby="download-title" className="relative z-10 mx-2 rounded-[2rem] bg-paper text-ink sm:mx-4 sm:rounded-[3rem]">
      <div className="mx-auto max-w-5xl space-y-6 px-5 py-12 sm:space-y-8 sm:px-8 sm:py-16">
        <div className="reveal max-w-2xl">
          <h2 id="download-title" className="t-h2">
            Tải xuống
          </h2>
          <p className="t-sub mt-3">Chọn máy của bạn</p>
          <p className="t-lead mt-4 text-ink/75">Mọi tệp đều được phát hành chính thức trên GitHub Releases. Miễn phí, không quảng cáo.</p>
        </div>

        <div className="reveal">
          <ReleaseSummary data={data} loading={loading} />
        </div>

        <Tabs value={platform} onValueChange={(v) => onPlatformChange(v as PlatformId)} className="w-full">
          <TabsList aria-label="Hệ điều hành" className="mb-8 grid h-16 w-full max-w-lg grid-cols-2 gap-1 rounded-2xl border-2 border-ink bg-transparent p-1.5">
            <TabsTrigger value="windows" className={trigger}>
              <WindowsIcon className="size-5" />
              Windows
              {detected === 'windows' && <span className="hidden font-sans text-[11px] font-semibold opacity-70 sm:inline">máy bạn</span>}
            </TabsTrigger>
            <TabsTrigger value="macos" className={trigger}>
              <AppleIcon className="size-5" />
              macOS
              {detected === 'macos' && <span className="hidden font-sans text-[11px] font-semibold opacity-70 sm:inline">máy bạn</span>}
            </TabsTrigger>
          </TabsList>

          {data.platforms.map((p) => (
            <TabsContent key={p.platform} value={p.platform} className="focus-visible:outline-none">
              <PlatformPanel platform={p} />
            </TabsContent>
          ))}
        </Tabs>

        <p className="text-sm text-ink/65">
          Ứng dụng chưa được ký số, nên lần đầu mở hệ điều hành có thể hiện cảnh báo. Đây là hành vi bình thường.
        </p>
      </div>
    </section>
  );
};
