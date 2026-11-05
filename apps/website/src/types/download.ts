export type PlatformId = 'windows' | 'macos';

export interface DownloadFile {
  id: string;
  name: string;
  filename: string;
  format: 'exe' | 'zip' | 'dmg';
  downloadUrl: string;
  recommended?: boolean;
  description: string;
  /** Các trường dưới đây chỉ có khi GitHub Releases trả về dữ liệu thật. */
  size?: string;
  checksum?: string;
  downloadsCount?: number;
}

export interface PlatformDownload {
  platform: PlatformId;
  name: string;
  osRequirement: string;
  files: DownloadFile[];
  installSteps: string[];
}

export interface ReleaseInfo {
  /** null khi repo chưa có release nào hoặc không gọi được GitHub. */
  version: string | null;
  publishedAt: string | null;
  notes: string | null;
  url: string;
  totalDownloads: number | null;
}

export interface DownloadData {
  platforms: PlatformDownload[];
  release: ReleaseInfo;
  /** 'live' = dữ liệu từ GitHub; 'fallback' = chỉ có liên kết tải mới nhất. */
  source: 'live' | 'fallback';
}
