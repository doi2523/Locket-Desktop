import type { DownloadData, DownloadFile, PlatformDownload } from '@/types/download';

const REPO = 'doi2523/Locket-Desktop';
const RELEASES_URL = `https://github.com/${REPO}/releases`;
const LATEST_DOWNLOAD = `${RELEASES_URL}/latest/download`;

type FileTemplate = Omit<DownloadFile, 'downloadUrl'>;

/** Danh mục tệp chính thức (tên tệp theo README). Kích thước, checksum, lượt tải lấy từ GitHub khi có. */
const PLATFORM_TEMPLATES: Array<Omit<PlatformDownload, 'files'> & { files: FileTemplate[] }> = [
  {
    platform: 'macos',
    name: 'macOS',
    osRequirement: 'macOS, Apple Silicon và Intel',
    files: [
      {
        id: 'mac-dmg',
        name: 'Ảnh đĩa DMG',
        filename: 'LocketDio-macOS.dmg',
        format: 'dmg',
        recommended: true,
        description: 'Mở tệp .dmg rồi kéo Locket Dio vào thư mục Applications.',
      },
    ],
    installSteps: [
      'Tải LocketDio-macOS.dmg, mở tệp và kéo Locket Dio vào Applications.',
      'Ứng dụng dùng ký ad-hoc: lần đầu hãy bấm chuột phải vào ứng dụng và chọn Open.',
      'Hoặc chạy lệnh xattr -cr "/Applications/Locket Dio.app" trong Terminal.',
    ],
  },
  {
    platform: 'windows',
    name: 'Windows',
    osRequirement: 'Windows 10 hoặc 11',
    files: [
      {
        id: 'win-installer',
        name: 'Bộ cài đặt',
        filename: 'LocketDio-Windows-Setup.exe',
        format: 'exe',
        recommended: true,
        description: 'Cài đặt chuẩn, có tự động cập nhật OTA. Nên dùng cho hầu hết người dùng.',
      },
      {
        id: 'win-portable',
        name: 'Bản portable',
        filename: 'LocketDio-Windows-Portable.zip',
        format: 'zip',
        description: 'Giải nén và chạy ở bất kỳ đâu, không cần cài đặt.',
      },
    ],
    installSteps: [
      'Tải LocketDio-Windows-Setup.exe và chạy trình cài đặt.',
      'Nếu SmartScreen cảnh báo (chứng chỉ chưa ký), bấm More info rồi Run anyway.',
      'Mở Locket Dio từ Start Menu và đăng nhập tài khoản Locket.',
    ],
  },
];

interface GithubAsset {
  name: string;
  size: number;
  download_count: number;
  browser_download_url: string;
  digest?: string | null;
}

export interface GithubRelease {
  tag_name: string;
  published_at: string | null;
  body: string | null;
  html_url: string;
  assets: GithubAsset[];
}

/** Bản phát hành mới nhất lúc build (xem vite.config.ts). null nếu lúc build không gọi được GitHub. */
const BUILD_RELEASE: GithubRelease | null = typeof __LATEST_RELEASE__ === 'undefined' ? null : __LATEST_RELEASE__;

const RELEASE_KEY = 'locket-gh-release';
const STARS_KEY = 'locket-gh-stars';
/** Giữ kết quả 10 phút để không chạm giới hạn 60 request/giờ/IP của API GitHub khi chưa xác thực. */
const CACHE_TTL_MS = 10 * 60 * 1000;

function readCache<T>(key: string): { value: T; fresh: boolean } | null {
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return null;
    const { t, v } = JSON.parse(raw) as { t: number; v: T };
    return { value: v, fresh: Date.now() - t < CACHE_TTL_MS };
  } catch {
    return null;
  }
}

function writeCache(key: string, value: unknown): void {
  try {
    localStorage.setItem(key, JSON.stringify({ t: Date.now(), v: value }));
  } catch {
    /* storage bị chặn hoặc đầy: bỏ qua */
  }
}

function formatSize(bytes: number): string {
  return `${(bytes / 1024 / 1024).toFixed(1)} MB`;
}

function buildPlatforms(assets: GithubAsset[], withCounts: boolean): PlatformDownload[] {
  return PLATFORM_TEMPLATES.map((p) => ({
    ...p,
    files: p.files.map((f) => {
      const asset = assets.find((a) => a.name === f.filename);
      return {
        ...f,
        downloadUrl: asset?.browser_download_url ?? `${LATEST_DOWNLOAD}/${f.filename}`,
        size: asset ? formatSize(asset.size) : undefined,
        checksum: asset?.digest ?? undefined,
        // Lượt tải thay đổi liên tục nên chỉ hiện khi có dữ liệu trực tiếp.
        downloadsCount: withCounts ? asset?.download_count : undefined,
      };
    }),
  }));
}

function toDownloadData(r: GithubRelease | null, source: DownloadData['source']): DownloadData {
  if (!r) {
    return {
      source: 'fallback',
      platforms: buildPlatforms([], false),
      release: { version: null, publishedAt: null, notes: null, url: RELEASES_URL, totalDownloads: null },
    };
  }
  const live = source === 'live';
  return {
    source,
    platforms: buildPlatforms(r.assets, live),
    release: {
      version: r.tag_name,
      publishedAt: r.published_at,
      notes: r.body?.trim() || null,
      url: r.html_url,
      totalDownloads: live ? r.assets.reduce((sum, a) => sum + a.download_count, 0) : null,
    },
  };
}

/** Dữ liệu hiển thị ngay khi tải trang, trước khi gọi API. Phiên bản lấy từ lúc build, không ghi cứng. */
export const FALLBACK_DATA: DownloadData = toDownloadData(BUILD_RELEASE, 'fallback');

export async function getDownloadData(signal?: AbortSignal): Promise<DownloadData> {
  const cached = readCache<GithubRelease>(RELEASE_KEY);
  if (cached?.fresh) return toDownloadData(cached.value, 'live');

  try {
    const res = await fetch(`https://api.github.com/repos/${REPO}/releases/latest`, {
      signal,
      headers: { Accept: 'application/vnd.github+json' },
    });
    if (!res.ok) throw new Error(`GitHub API ${res.status}`);
    const r = (await res.json()) as GithubRelease;
    writeCache(RELEASE_KEY, r);
    return toDownloadData(r, 'live');
  } catch (err) {
    if (signal?.aborted) throw err;
    // Lỗi mạng hoặc hết giới hạn: ưu tiên bản đã lưu lần trước, sau đó tới bản lúc build.
    return cached ? toDownloadData(cached.value, 'live') : FALLBACK_DATA;
  }
}

/** Số sao của repo. Trả null nếu không lấy được (hết giới hạn API, mất mạng...). */
export async function getStarCount(signal?: AbortSignal): Promise<number | null> {
  const cached = readCache<number>(STARS_KEY);
  if (cached?.fresh) return cached.value;
  try {
    const res = await fetch(`https://api.github.com/repos/${REPO}`, {
      signal,
      headers: { Accept: 'application/vnd.github+json' },
    });
    if (!res.ok) return cached?.value ?? null;
    const { stargazers_count } = (await res.json()) as { stargazers_count?: number };
    if (typeof stargazers_count !== 'number') return cached?.value ?? null;
    writeCache(STARS_KEY, stargazers_count);
    return stargazers_count;
  } catch {
    return cached?.value ?? null;
  }
}
