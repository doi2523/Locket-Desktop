import type { DownloadStats, PlatformDownload } from '@/types/download';

export const MOCK_DOWNLOAD_STATS: DownloadStats = {
  totalDownloads: 128450,
  windowsDownloads: 85200,
  macosDownloads: 43250,
  latestVersion: 'v1.2.0',
  releaseDate: '04/11/2026',
  rating: 4.9,
  reviewsCount: 3240,
  activeUsers: 64800,
  githubStars: 1850,
};

export const MOCK_PLATFORM_DOWNLOADS: PlatformDownload[] = [
  {
    platform: 'windows',
    name: 'Windows',
    icon: 'windows',
    osRequirement: 'Windows 10 / 11 (64-bit)',
    architecture: 'x64 / ARM64',
    latestVersion: 'v1.2.0',
    releaseDate: '04/11/2026',
    files: [
      {
        id: 'win-installer',
        name: 'Bộ Cài Đặt Tự Động (Setup)',
        filename: 'LocketDio-Windows-Setup.exe',
        format: 'exe',
        size: '68.4 MB',
        downloadUrl: 'https://github.com/doi2523/Locket-Desktop/releases/latest/download/LocketDio-Windows-Setup.exe',
        recommended: true,
        description: 'Tự động thiết lập đường dẫn, tạo icon Desktop và hỗ trợ cập nhật một chạm (OTA).',
        checksum: 'sha256: 7f8a9b2c3d4e5f6a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a',
        downloadsCount: 62450,
      },
      {
        id: 'win-portable',
        name: 'Bản Nén Chạy Ngay (Portable)',
        filename: 'LocketDio-Windows-Portable.zip',
        format: 'zip',
        size: '74.1 MB',
        downloadUrl: 'https://github.com/doi2523/Locket-Desktop/releases/latest/download/LocketDio-Windows-Portable.zip',
        recommended: false,
        description: 'Giải nén và chạy ngay lập tức không cần quyền Administrator, phù hợp lưu trữ USB.',
        checksum: 'sha256: 3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d',
        downloadsCount: 22750,
      },
    ],
    installSteps: [
      'Tải tệp LocketDio-Windows-Setup.exe về máy tính.',
      'Nhấp đúp chuột để mở trình cài đặt tự động.',
      'Đăng nhập tài khoản Locket hoặc trải nghiệm chế độ Khách ngay lập tức.',
    ],
  },
  {
    platform: 'macos',
    name: 'macOS',
    icon: 'apple',
    osRequirement: 'macOS 12.0 (Monterey) trở lên',
    architecture: 'Apple Silicon (M1/M2/M3/M4) & Intel',
    latestVersion: 'v1.2.0',
    releaseDate: '04/11/2026',
    files: [
      {
        id: 'mac-dmg',
        name: 'Gói Cài Đặt Ảnh Đĩa (DMG)',
        filename: 'LocketDio-macOS.dmg',
        format: 'dmg',
        size: '62.8 MB',
        downloadUrl: 'https://github.com/doi2523/Locket-Desktop/releases/latest/download/LocketDio-macOS.dmg',
        recommended: true,
        description: 'Định dạng chuẩn macOS, tương thích hoàn hảo Apple Silicon và Intel, tối ưu Retina Display.',
        checksum: 'sha256: 9e8d7c6b5a4f3e2d1c0b9a8f7e6d5c4b3a2f1e0d9c8b7a6f5e4d3c2b1a0f9e8d',
        downloadsCount: 43250,
      },
    ],
    installSteps: [
      'Tải tệp LocketDio-macOS.dmg về thư mục Downloads.',
      'Mở tệp .dmg và kéo biểu tượng Locket Dio vào thư mục Applications.',
      'Mở ứng dụng từ Launchpad hoặc Spotlight để bắt đầu trải nghiệm.',
    ],
  },
];

/**
 * Lấy số liệu thống kê tải ứng dụng (hiện dùng mock data, có thể kết nối backend/GitHub API)
 */
export async function getDownloadStats(): Promise<DownloadStats> {
  // Giả lập delay mạng nhẹ 200ms để hiệu ứng loading mượt mà
  await new Promise((resolve) => setTimeout(resolve, 200));
  return MOCK_DOWNLOAD_STATS;
}

/**
 * Lấy danh sách các tệp tải theo nền tảng (Windows & macOS)
 */
export async function getPlatformDownloads(): Promise<PlatformDownload[]> {
  await new Promise((resolve) => setTimeout(resolve, 200));
  return MOCK_PLATFORM_DOWNLOADS;
}

