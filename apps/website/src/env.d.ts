/// <reference types="vite/client" />

import type { GithubRelease } from '@/services/downloadService';

declare global {
  /** Bản phát hành mới nhất lúc build, do vite.config.ts chèn vào. null nếu không gọi được GitHub. */
  const __LATEST_RELEASE__: GithubRelease | null;
}
