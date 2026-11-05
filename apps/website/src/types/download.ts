export interface DownloadStats {
  totalDownloads: number;
  windowsDownloads: number;
  macosDownloads: number;
  latestVersion: string;
  releaseDate: string;
  rating: number;
  reviewsCount: number;
  activeUsers: number;
  githubStars: number;
}

export interface DownloadFile {
  id: string;
  name: string;
  filename: string;
  format: 'exe' | 'zip' | 'dmg';
  size: string;
  downloadUrl: string;
  recommended?: boolean;
  description: string;
  checksum: string;
  downloadsCount: number;
}

export interface PlatformDownload {
  platform: 'windows' | 'macos';
  name: string;
  icon: 'windows' | 'apple';
  osRequirement: string;
  architecture: string;
  latestVersion: string;
  releaseDate: string;
  files: DownloadFile[];
  installSteps: string[];
}

