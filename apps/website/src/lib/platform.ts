import type { PlatformId } from '@/types/download';

/** Đoán nền tảng desktop của khách; trả null cho mobile/không xác định. */
export function detectPlatform(): PlatformId | null {
  if (typeof navigator === 'undefined') return null;
  const ua = navigator.userAgent.toLowerCase();
  if (/android|iphone|ipad|ipod/.test(ua)) return null;
  if (ua.includes('windows')) return 'windows';
  if (ua.includes('mac')) return 'macos';
  return null;
}
