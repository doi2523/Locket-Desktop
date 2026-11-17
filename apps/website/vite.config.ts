import { fileURLToPath, URL } from 'node:url'
import react from '@vitejs/plugin-react'
import { defineConfig, type UserConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
/**
 * Lấy bản phát hành mới nhất của repo lúc build để làm dữ liệu dự phòng (khi API GitHub lỗi hoặc hết giới hạn).
 * Chỉ giữ trường cần dùng. Thất bại thì trả null, trang vẫn build bình thường.
 */
async function fetchLatestRelease() {
  try {
    const res = await fetch('https://api.github.com/repos/doi2523/Locket-Desktop/releases', {
      headers: { Accept: 'application/vnd.github+json' },
      signal: AbortSignal.timeout(8000),
    })
    if (!res.ok) return null
    const list = (await res.json()) as Array<{
      tag_name: string
      published_at: string | null
      body: string | null
      html_url: string
      prerelease?: boolean
      draft?: boolean
      assets: Array<{ name: string; size: number; download_count: number; browser_download_url: string; digest?: string | null }>
    }>
    if (!Array.isArray(list) || list.length === 0) return null
    const r = list.find((item) => !item.prerelease && !item.draft) ?? list[0]
    const allDownloads = list.reduce(
      (sum, rel) => sum + (rel.assets ? rel.assets.reduce((s, a) => s + (a.download_count || 0), 0) : 0),
      0
    )
    return {
      tag_name: r.tag_name,
      published_at: r.published_at,
      body: r.body,
      html_url: r.html_url,
      all_releases_total_downloads: allDownloads,
      assets: r.assets.map((a) => ({
        name: a.name,
        size: a.size,
        download_count: a.download_count,
        browser_download_url: a.browser_download_url,
        digest: a.digest,
      })),
    }
  } catch {
    return null
  }
}

export default defineConfig(async (): Promise<UserConfig> => ({
  plugins: [react(), tailwindcss()],
  define: {
    __LATEST_RELEASE__: JSON.stringify(await fetchLatestRelease()),
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    host: true,
  },
  build: {
    target: 'es2022',
    cssCodeSplit: true,
    chunkSizeWarningLimit: 300,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes('node_modules/react/') || id.includes('node_modules/react-dom/') || id.includes('node_modules/scheduler/')) {
            return 'vendor-react'
          }
          if (id.includes('node_modules/@radix-ui/')) {
            return 'vendor-radix'
          }
          if (id.includes('node_modules/lucide-react/')) {
            return 'vendor-icons'
          }
          if (id.includes('node_modules/tailwind-merge/') || id.includes('node_modules/clsx/') || id.includes('node_modules/class-variance-authority/')) {
            return 'vendor-utils'
          }
        },
      },
    },
  },
}))
