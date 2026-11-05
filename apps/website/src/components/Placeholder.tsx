import * as React from 'react';

interface PlaceholderProps {
  title: string;
  hint: string;
  className?: string;
  children?: React.ReactNode;
}

/** Khung giữ chỗ cho nội dung chưa có dữ liệu thật. Dễ tìm lại bằng thuộc tính data-placeholder. */
export const Placeholder: React.FC<PlaceholderProps> = ({ title, hint, className = '', children }) => (
  <div
    data-placeholder
    className={`flex flex-col items-center justify-center gap-2 rounded-3xl border-2 border-dashed border-paper/25 p-6 text-center ${className}`}
  >
    <span className="eyebrow rounded-full bg-paper/10 px-2.5 py-1 text-paper/70">Sắp có</span>
    <p className="font-display text-lg font-bold text-paper">{title}</p>
    <p className="max-w-xs text-sm text-paper/60">{hint}</p>
    {children}
  </div>
);
