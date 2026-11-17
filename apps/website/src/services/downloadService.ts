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
    osRequirement: 'macOS 11.0 trở lên (tương thích riêng Apple Silicon và Intel)',
    files: [
      {
        id: 'mac-arm64',
        name: 'Apple Silicon (Chip M)',
        filename: 'LocketDio-macOS-AppleSilicon.dmg',
        format: 'dmg',
        recommended: true,
        arch: 'arm64',
        description: 'Bản tối ưu hiệu năng và thời lượng pin cho máy Mac dùng chip Apple Silicon (M1, M2, M3, M4...). Mở tệp .dmg rồi kéo vào Applications.',
      },
      {
        id: 'mac-intel',
        name: 'Intel (Chip x86_64)',
        filename: 'LocketDio-macOS-Intel.dmg',
        format: 'dmg',
        recommended: false,
        arch: 'x64',
        description: 'Dành cho các dòng máy Mac sử dụng chip Intel (Core i5, Core i7, Core i9...). Mở tệp .dmg rồi kéo vào Applications.',
      },
    ],
    installSteps: [
      'Chọn đúng phiên bản chip máy Mac của bạn (Apple Silicon M-series hoặc Intel).',
      'Tải tệp .dmg tương ứng, mở tệp và kéo Locket Dio vào thư mục Applications.',
      'Ứng dụng dùng ký ad-hoc: lần đầu hãy bấm chuột phải (hoặc Control + bấm) vào ứng dụng và chọn Open (Mở).',
      'Nếu xuất hiện cảnh báo hỏng tệp hoặc không mở được, chạy lệnh sau trong Terminal: xattr -cr "/Applications/Locket Dio.app"',
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
  prerelease?: boolean;
  draft?: boolean;
  assets: GithubAsset[];
  all_releases_total_downloads?: number;
}

/** Bản phát hành mới nhất lúc build (xem vite.config.ts). null nếu lúc build không gọi được GitHub. */
const BUILD_RELEASE: GithubRelease | null = typeof __LATEST_RELEASE__ === 'undefined' ? null : __LATEST_RELEASE__;

interface CachedReleasesData {
  latest: GithubRelease;
  allDownloads: number;
}

const RELEASES_CACHE_KEY = 'locket-gh-releases-v2';
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
      let asset = assets.find((a) => a.name === f.filename);
      // Fallback tương thích ngược: nếu release cũ chỉ có file chung LocketDio-macOS.dmg
      if (!asset && f.format === 'dmg') {
        asset = assets.find((a) => a.name === 'LocketDio-macOS.dmg');
      }
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

function toDownloadData(
  r: GithubRelease | null,
  allDownloads: number | null,
  source: DownloadData['source']
): DownloadData {
  if (!r) {
    return {
      source: 'fallback',
      platforms: buildPlatforms([], false),
      release: {
        version: null,
        publishedAt: null,
        notes: null,
        url: RELEASES_URL,
        totalDownloads: null,
        allReleasesTotalDownloads: null,
      },
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
      allReleasesTotalDownloads: allDownloads ?? r.all_releases_total_downloads ?? null,
    },
  };
}

/** Dữ liệu hiển thị ngay khi tải trang, trước khi gọi API. Phiên bản lấy từ lúc build, không ghi cứng. */
export const FALLBACK_DATA: DownloadData = toDownloadData(
  BUILD_RELEASE,
  BUILD_RELEASE?.all_releases_total_downloads ?? null,
  'fallback'
);

export async function getDownloadData(signal?: AbortSignal): Promise<DownloadData> {
  const cached = readCache<CachedReleasesData>(RELEASES_CACHE_KEY);
  if (cached?.fresh) {
    return toDownloadData(cached.value.latest, cached.value.allDownloads, 'live');
  }

  try {
    const res = await fetch(`https://api.github.com/repos/${REPO}/releases`, {
      signal,
      headers: { Accept: 'application/vnd.github+json' },
    });
    if (!res.ok) throw new Error(`GitHub API ${res.status}`);
    const list = (await res.json()) as GithubRelease[];
    if (!Array.isArray(list) || list.length === 0) throw new Error('No releases');

    const latest = list.find((r) => !r.prerelease && !r.draft) ?? list[0];
    const allDownloads = list.reduce(
      (sum, rel) => sum + (rel.assets ? rel.assets.reduce((s, a) => s + (a.download_count || 0), 0) : 0),
      0
    );

    writeCache(RELEASES_CACHE_KEY, { latest, allDownloads });
    return toDownloadData(latest, allDownloads, 'live');
  } catch (err) {
    if (signal?.aborted) throw err;
    // Lỗi mạng hoặc hết giới hạn: ưu tiên bản đã lưu lần trước, sau đó tới bản lúc build.
    return cached
      ? toDownloadData(cached.value.latest, cached.value.allDownloads, 'live')
      : FALLBACK_DATA;
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
