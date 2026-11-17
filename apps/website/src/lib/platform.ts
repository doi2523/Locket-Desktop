import type { MacArchitecture, PlatformId } from '@/types/download';

/** Đoán nền tảng desktop của khách; trả null cho mobile/không xác định. */
export function detectPlatform(): PlatformId | null {
  if (typeof navigator === 'undefined') return null;
  const ua = navigator.userAgent.toLowerCase();
  if (/android|iphone|ipad|ipod/.test(ua)) return null;
  if (ua.includes('windows')) return 'windows';
  if (ua.includes('mac')) return 'macos';
  return null;
}

/**
 * Nhận diện kiến trúc chip máy Mac:
 * - 'arm64': Apple Silicon (M1, M2, M3, M4...)
 * - 'x64': Intel Core
 * Trả về null nếu không xác định được.
 */
export function detectMacArchitecture(): MacArchitecture | null {
  if (typeof window === 'undefined' || typeof navigator === 'undefined') return null;
  const ua = navigator.userAgent.toLowerCase();
  if (!ua.includes('mac') || /iphone|ipad|ipod/.test(ua)) return null;

  // 1. Thử nhận diện qua WebGL Unmasked Renderer (hỗ trợ hầu hết trình duyệt Safari, Chrome, Firefox trên macOS)
  try {
    const canvas = document.createElement('canvas');
    const gl = (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')) as WebGLRenderingContext | null;
    if (gl) {
      const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
      if (debugInfo) {
        const renderer = gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL);
        if (typeof renderer === 'string') {
          if (/Apple\s+(M\d|GPU)/i.test(renderer) || renderer.includes('Apple')) {
            return 'arm64';
          }
          if (/Intel/i.test(renderer)) {
            return 'x64';
          }
        }
      }
    }
  } catch {
    // WebGL bị vô hiệu hóa hoặc sandbox bảo mật
  }

  // 2. Thử qua User-Agent Client Hints (Chromium: Chrome, Edge, Arc, Brave trên Mac)
  const navAny = navigator as unknown as { userAgentData?: { architecture?: string } };
  if (navAny.userAgentData?.architecture) {
    const arch = navAny.userAgentData.architecture.toLowerCase();
    if (arch.includes('arm')) return 'arm64';
    if (arch.includes('x86')) return 'x64';
  }

  return null;
}
