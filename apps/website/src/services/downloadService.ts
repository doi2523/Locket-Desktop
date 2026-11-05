import type { DownloadData, DownloadFile, PlatformDownload, ReleaseInfo } from '@/types/download';

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

interface GithubRelease {
  tag_name: string;
  published_at: string | null;
  body: string | null;
  html_url: string;
  assets: GithubAsset[];
}

function formatSize(bytes: number): string {
  return `${(bytes / 1024 / 1024).toFixed(1)} MB`;
}

function buildPlatforms(assets: GithubAsset[]): PlatformDownload[] {
  return PLATFORM_TEMPLATES.map((p) => ({
    ...p,
    files: p.files.map((f) => {
      const asset = assets.find((a) => a.name === f.filename);
      return {
        ...f,
        downloadUrl: asset?.browser_download_url ?? `${LATEST_DOWNLOAD}/${f.filename}`,
        size: asset ? formatSize(asset.size) : undefined,
        checksum: asset?.digest ?? undefined,
        downloadsCount: asset?.download_count,
      };
    }),
  }));
}

const FALLBACK_RELEASE: ReleaseInfo = {
  version: null,
  publishedAt: null,
  notes: null,
  url: RELEASES_URL,
  totalDownloads: null,
};

export async function getDownloadData(signal?: AbortSignal): Promise<DownloadData> {
  try {
    const res = await fetch(`https://api.github.com/repos/${REPO}/releases/latest`, {
      signal,
      headers: { Accept: 'application/vnd.github+json' },
    });
    if (!res.ok) throw new Error(`GitHub API ${res.status}`);
    const r = (await res.json()) as GithubRelease;
    return {
      source: 'live',
      platforms: buildPlatforms(r.assets),
      release: {
        version: r.tag_name,
        publishedAt: r.published_at,
        notes: r.body?.trim() || null,
        url: r.html_url,
        totalDownloads: r.assets.reduce((sum, a) => sum + a.download_count, 0),
      },
    };
  } catch (err) {
    if (signal?.aborted) throw err;
    // Chưa có release hoặc lỗi mạng: vẫn cung cấp liên kết "latest" hợp lệ, không bịa số liệu.
    return { source: 'fallback', platforms: buildPlatforms([]), release: FALLBACK_RELEASE };
  }
}

export const FALLBACK_DATA: DownloadData = {
  source: 'fallback',
  platforms: buildPlatforms([]),
  release: FALLBACK_RELEASE,
};
