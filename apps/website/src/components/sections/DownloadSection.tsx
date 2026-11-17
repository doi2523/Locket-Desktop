import * as React from 'react';
import { Check, Copy, Download, ExternalLink, FileArchive, HardDrive, ListChecks, TriangleAlert } from 'lucide-react';
import { AppleIcon, WindowsIcon } from '@/components/icons/PlatformIcons';
import { ReleaseNotes } from '@/components/ReleaseNotes';
import { Button } from '@/components/ui/button';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { formatDate } from '@/lib/utils';
import type { DownloadData, DownloadFile, MacArchitecture, PlatformDownload, PlatformId } from '@/types/download';

interface DownloadSectionProps {
  data: DownloadData;
  loading: boolean;
  platform: PlatformId;
  onPlatformChange: (platform: PlatformId) => void;
  detected: PlatformId | null;
  detectedArch?: MacArchitecture | null;
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
    <div className="flex items-center justify-between gap-3 rounded-2xl border border-paper/10 bg-ink-3/60 px-3.5 py-2.5 t-meta text-paper/70">
      <span className="truncate" title={checksum}>
        {checksum}
      </span>
      <button
        type="button"
        onClick={copy}
        className="inline-flex shrink-0 cursor-pointer items-center gap-1 font-sans font-semibold text-paper underline underline-offset-4 decoration-heart decoration-2 hover:text-heart transition-colors"
      >
        {state === 'copied' ? <Check className="size-3.5 text-butter" aria-hidden="true" /> : <Copy className="size-3.5" aria-hidden="true" />}
        <span aria-live="polite">{state === 'copied' ? 'Đã chép' : state === 'failed' ? 'Không chép được' : 'Chép SHA-256'}</span>
      </button>
    </div>
  );
}

function FileCard({
  file,
  delay,
  detectedArch,
}: {
  file: DownloadFile;
  delay: number;
  detectedArch?: MacArchitecture | null;
}) {
  const [started, setStarted] = React.useState(false);
  const onClick = () => {
    setStarted(true);
    setTimeout(() => setStarted(false), 3500);
  };

  const isMatchedArch = Boolean(file.arch && detectedArch && file.arch === detectedArch);
  const isRecommended = isMatchedArch || (!detectedArch && file.recommended);

  return (
    <article
      className="reveal group flex flex-col justify-between gap-5 rounded-3xl border border-paper/10 bg-ink-2 p-6 transition-[transform,border-color] duration-300 hover:-translate-y-1 hover:border-paper/30 sm:p-8"
      style={{ '--d': `${delay}s` } as React.CSSProperties}
    >
      <div className="space-y-4">
        <div className="flex items-start gap-4">
          <div className="flex size-12 shrink-0 items-center justify-center rounded-2xl bg-butter text-ink shadow-sm">
            <FileIcon file={file} />
          </div>
          <div className="min-w-0 flex-1">
            <h3 className="t-h3 flex flex-wrap items-center gap-2 text-paper">
              {file.name}
              {isMatchedArch && (
                <span className="rounded-full bg-butter px-2.5 py-0.5 font-sans text-[11px] font-bold uppercase tracking-wide text-ink shadow-sm">
                  Chip máy bạn
                </span>
              )}
              {file.recommended && !isMatchedArch && (
                <span className="rounded-full bg-heart px-2.5 py-0.5 font-sans text-[11px] font-bold uppercase tracking-wide text-paper shadow-sm">
                  Khuyên dùng
                </span>
              )}
            </h3>
            <p className="mt-0.5 break-all t-meta text-paper/60">{file.filename}</p>
          </div>
        </div>

        <p className="text-[0.95rem] leading-relaxed text-paper/75">{file.description}</p>

        {(file.size || file.downloadsCount !== undefined) && (
          <ul className="flex flex-wrap gap-x-5 gap-y-1 text-sm text-paper/70">
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
      </div>

      <div className="space-y-3">
        <Button
          asChild
          variant={isRecommended ? 'glow' : 'outline'}
          size="lg"
          className={`w-full gap-2 ${isRecommended ? '' : 'border border-paper/20 bg-paper/5 text-paper hover:bg-paper hover:text-ink'}`}
        >
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
      </div>
    </article>
  );
}

function PlatformPanel({
  platform,
  detectedArch,
}: {
  platform: PlatformDownload;
  detectedArch?: MacArchitecture | null;
}) {
  return (
    <div className="mt-8 grid grid-cols-1 gap-6 sm:mt-10 lg:grid-cols-5">
      <div className="space-y-5 lg:col-span-3">
        {platform.files.map((f, i) => (
          <FileCard key={f.id} file={f} delay={i * 0.08} detectedArch={detectedArch} />
        ))}
      </div>
      <aside className="space-y-6 self-start rounded-3xl border border-paper/10 bg-ink-2 p-6 sm:p-8 lg:col-span-2">
        <div>
          <h3 className="eyebrow text-paper/60">Yêu cầu hệ thống</h3>
          <p className="mt-1.5 font-medium text-paper">{platform.osRequirement}</p>
        </div>
        <div>
          <h3 className="eyebrow flex items-center gap-2 text-paper/60">
            <ListChecks className="size-4" aria-hidden="true" />
            Cách cài đặt
          </h3>
          <ol className="mt-3 list-decimal space-y-2.5 pl-5 text-[0.95rem] leading-relaxed text-paper/80 marker:font-bold marker:text-heart">
            {platform.installSteps.map((step) => (
              <li key={step}>{step}</li>
            ))}
          </ol>
        </div>
        {platform.platform === 'macos' && (
          <div className="rounded-2xl border border-paper/10 bg-ink-3/40 p-4 text-xs leading-relaxed text-paper/70">
            <p className="font-semibold text-paper/90 mb-1">💡 Làm sao để biết máy Mac dùng chip nào?</p>
            Bấm vào biểu tượng quả táo <strong></strong> ở góc trên bên trái màn hình ➔ chọn <strong>About This Mac</strong> (Giới thiệu về máy Mac này). Xem dòng <em>Chip</em> (Apple Silicon M1, M2, M3, M4...) hoặc <em>Processor</em> (Intel).
          </div>
        )}
      </aside>
    </div>
  );
}

function ReleaseSummary({ data, loading }: { data: DownloadData; loading: boolean }) {
  const { release, source } = data;
  const link = 'font-semibold underline underline-offset-4 decoration-heart decoration-2';

  if (loading) {
    return <div className="h-16 animate-pulse rounded-3xl border border-paper/10 bg-ink-2" role="status" aria-label="Đang tải thông tin phiên bản" />;
  }

  if (!release.version) {
    return (
      <div className="flex items-start gap-3 rounded-3xl border border-butter/30 bg-ink-2 p-5 text-sm text-paper leading-relaxed" role="status">
        <TriangleAlert className="mt-0.5 size-5 shrink-0 text-butter" aria-hidden="true" />
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
    <div className="space-y-3.5 rounded-3xl border border-paper/10 bg-ink-2 p-5 sm:p-6 text-paper shadow-sm">
      <div className="flex flex-wrap items-center justify-between gap-x-5 gap-y-3 text-sm">
        {/* Nhóm trái: Phiên bản & Ngày phát hành */}
        <div className="flex flex-wrap items-center gap-x-3.5 gap-y-1.5">
          <span className="font-display text-lg font-bold text-paper">
            Phiên bản {release.version}
          </span>
          {release.publishedAt && (
            <span className="text-paper/60 text-xs sm:text-sm">
              Phát hành {formatDate(release.publishedAt)}
            </span>
          )}
        </div>

        {/* Nhóm phải: Thống kê lượt tải & Xem trên GitHub */}
        <div className="flex flex-wrap items-center gap-x-4 gap-y-2">
          {release.allReleasesTotalDownloads !== null && (
            <span className="inline-flex items-center gap-1.5 rounded-full bg-butter/15 px-3 py-1 font-sans text-xs font-bold text-butter border border-butter/30 shadow-xs">
              <Download className="size-3.5" aria-hidden="true" />
              {release.allReleasesTotalDownloads.toLocaleString('vi-VN')} tổng lượt tải
              {release.totalDownloads !== null && (
                <span className="font-normal opacity-70">
                  ({release.totalDownloads.toLocaleString('vi-VN')} ở bản này)
                </span>
              )}
            </span>
          )}
          <a
            href={release.url}
            target="_blank"
            rel="noreferrer"
            className="inline-flex items-center gap-1 text-xs sm:text-sm font-semibold text-butter hover:underline transition-colors"
          >
            Xem trên GitHub <ExternalLink className="size-3.5" aria-hidden="true" />
          </a>
        </div>
      </div>

      {release.notes && (
        <details className="text-sm text-paper/80 pt-2.5 border-t border-paper/10">
          <summary className="cursor-pointer font-semibold text-paper/90 hover:text-butter transition-colors">
            Có gì mới ở bản {release.version}?
          </summary>
          <div className="mt-3 max-h-72 overflow-auto pr-1">
            <ReleaseNotes markdown={release.notes} />
          </div>
        </details>
      )}
    </div>
  );
}

export const DownloadSection: React.FC<DownloadSectionProps> = ({ data, loading, platform, onPlatformChange, detected, detectedArch }) => {
  const trigger =
    'h-full cursor-pointer gap-2.5 rounded-xl px-4 font-display text-lg font-bold text-paper/70 transition-all data-[state=active]:bg-butter data-[state=active]:text-ink data-[state=active]:shadow-md hover:text-paper';

  return (
    <section id="download" aria-labelledby="download-title" className="relative z-10 pb-10 pt-10 sm:pb-14 sm:pt-16">
      <div className="mx-auto max-w-7xl px-5 sm:px-8">
        <div className="reveal max-w-3xl">
          <h2 id="download-title" className="t-h2 text-heart">
            Tải xuống
          </h2>
          <p className="t-sub mt-3 text-paper">
            Chọn máy của bạn, <span className="text-butter">cài đặt trong tích tắc.</span>
          </p>
          <p className="t-lead mt-4 text-paper/75">
            Mọi tệp đều được phát hành chính thức trên GitHub Releases. Miễn phí, không quảng cáo.
          </p>
        </div>

        <div className="reveal mt-8 sm:mt-10">
          <ReleaseSummary data={data} loading={loading} />
        </div>

        <Tabs value={platform} onValueChange={(v) => onPlatformChange(v as PlatformId)} className="mt-8 sm:mt-10 w-full">
          <TabsList aria-label="Hệ điều hành" className="grid h-16 w-full max-w-lg grid-cols-2 gap-1 rounded-2xl border border-paper/10 bg-ink-2 p-1.5">
            <TabsTrigger value="windows" className={trigger}>
              <WindowsIcon className="size-5" />
              Windows
              {detected === 'windows' && <span className="hidden font-sans text-[11px] font-semibold opacity-70 sm:inline">máy bạn</span>}
            </TabsTrigger>
            <TabsTrigger value="macos" className={trigger}>
              <AppleIcon className="size-5" />
              macOS
              {detected === 'macos' && (
                <span className="hidden font-sans text-[11px] font-semibold opacity-70 sm:inline">
                  {detectedArch ? `máy bạn (${detectedArch === 'x64' ? 'Intel' : 'Chip M'})` : 'máy bạn'}
                </span>
              )}
            </TabsTrigger>
          </TabsList>

          {data.platforms.map((p) => (
            <TabsContent key={p.platform} value={p.platform} className="focus-visible:outline-none">
              <PlatformPanel platform={p} detectedArch={detectedArch} />
            </TabsContent>
          ))}
        </Tabs>

        <p className="mt-8 text-sm text-paper/60 sm:mt-10">
          * Ứng dụng chưa được ký số, nên lần đầu mở hệ điều hành có thể hiện cảnh báo. Đây là hành vi bình thường.
        </p>
      </div>
    </section>
  );
};
