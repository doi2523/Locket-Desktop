# 🚀 Hướng Dẫn Deploy Locket Dio Website Lên Firebase Hosting

Website landing page của **Locket Dio Desktop** được cấu hình để triển khai lên **Firebase Hosting** (Site: `app-locketdio` thuộc Project: `locket-dio-4ca9c`).

---

## 📋 1. Chuẩn Bị

Đảm bảo bạn đã cài đặt **Firebase CLI** và đăng nhập:

```bash
# Kiểm tra phiên bản Firebase CLI
firebase --version

# Đăng nhập tài khoản Firebase (nếu chưa đăng nhập)
firebase login
```

---

## 🛠️ 2. Build Dự Án

Trước khi deploy, hãy chắc chắn source code đã được build ra thư mục `dist`:

```bash
# Di chuyển vào thư mục website
cd apps/website

# Cài đặt dependencies (nếu chưa)
npm install

# Build mã nguồn
npm run build
```

---

## 🚀 3. Triển Khai (Deploy)

Chạy lệnh deploy chỉ định site `app-locketdio`:

```bash
# Cách 1: Sử dụng lệnh npm script tiện lợi
npm run deploy

# Cách 2: Chạy trực tiếp qua Firebase CLI
# 🚀 Hướng Dẫn Deploy Locket Dio Website Lên Firebase Hosting

Website landing page của **Locket Dio Desktop** được cấu hình để triển khai lên **Firebase Hosting** (Site: `app-locketdio` thuộc Project: `locket-dio-4ca9c`).

---

## 📋 1. Chuẩn Bị

Đảm bảo bạn đã cài đặt **Firebase CLI** và đăng nhập:

```bash
# Kiểm tra phiên bản Firebase CLI
firebase --version

# Đăng nhập tài khoản Firebase (nếu chưa đăng nhập)
firebase login
```

---

## 🛠️ 2. Build Dự Án

Trước khi deploy, hãy chắc chắn source code đã được build ra thư mục `dist`:

```bash
# Di chuyển vào thư mục website
cd apps/website

# Cài đặt dependencies (nếu chưa)
npm install

# Build mã nguồn
npm run build
```

---

## 🚀 3. Triển Khai (Deploy)

Chạy lệnh deploy chỉ định site `app-locketdio`:

```bash
# Cách 1: Sử dụng lệnh npm script tiện lợi
npm run deploy

# Cách 2: Chạy trực tiếp qua Firebase CLI
firebase deploy --only hosting:app-locketdio
```

---

## 🌐 4. Kiểm Tra Sau Khi Deploy

Sau khi hoàn tất, website sẽ có thể truy cập tại:
- 🔗 **Tên miền chính**: [https://app.locket-dio.com](https://app.locket-dio.com)
- 🔗 **Firebase Default Domain**: [https://app-locketdio.web.app](https://app-locketdio.web.app)
- 🔗 **Tên miền thay thế**: [https://app-locketdio.firebaseapp.com](https://app-locketdio.firebaseapp.com)

> 💡 **Cách trỏ tên miền `app.locket-dio.com` trên Firebase Console:**
> 1. Truy cập [Firebase Console](https://console.firebase.google.com/) → Chọn dự án `locket-dio-4ca9c`.
> 2. Vào mục **Hosting** → Chọn site `app-locketdio`.
> 3. Bấm **Add custom domain** (Thêm miền tùy chỉnh) → Nhập `app.locket-dio.com`.
> 4. Thêm bản ghi DNS (A hoặc CNAME) vào nhà cung cấp tên miền của bạn theo hướng dẫn trên màn hình Firebase.

---

## ⚙️ 5. Cấu Hình Firebase Hosting (`firebase.json`)

- **SPA Routing**: Tự động chuyển hướng mọi đường dẫn `**` về `/index.html` để phục vụ client-side routing.
- **Cache-Control tối ưu**:
  - `/index.html`: `no-cache` (đảm bảo người dùng luôn nhận phiên bản mới nhất ngay khi bạn deploy).
  - Tệp tĩnh (`assets/*.js`, `assets/*.css`, ảnh): `public, max-age=31536000, immutable` (tận dụng tối đa CDN cache với hash filename của Vite).
- **Security Headers**: Chống clickjacking với `X-Frame-Options: DENY` và `Content-Security-Policy: frame-ancestors 'none'`.
