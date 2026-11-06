import * as React from 'react';

/**
 * Hiển thị ghi chú release (markdown của GitHub) mà không cần thư viện ngoài.
 * Hỗ trợ: tiêu đề, đoạn, danh sách, trích dẫn, đường kẻ, **đậm**, *nghiêng*, `mã`, liên kết.
 * Chỉ tạo phần tử React (không dùng dangerouslySetInnerHTML) và chỉ cho phép liên kết http(s).
 */

const INLINE = /(`[^`]+`)|(\*\*[^*]+\*\*)|(\[[^\]]+\]\([^)\s]+\))|(\*[^*\s][^*]*\*)|(https?:\/\/[^\s)]+)/g;

function safeUrl(url: string): string | null {
  return /^https?:\/\//i.test(url) ? url : null;
}

function renderInline(text: string): React.ReactNode[] {
  const out: React.ReactNode[] = [];
  let last = 0;
  let key = 0;
  for (const m of text.matchAll(INLINE)) {
    const i = m.index ?? 0;
    if (i > last) out.push(text.slice(last, i));
    const tok = m[0];
    if (m[1]) {
      out.push(
        <code key={key++} className="rounded bg-paper/10 px-1.5 py-0.5 font-mono text-[0.85em] text-paper">
          {tok.slice(1, -1)}
        </code>,
      );
    } else if (m[2]) {
      out.push(
        <strong key={key++} className="font-semibold text-paper">
          {renderInline(tok.slice(2, -2))}
        </strong>,
      );
    } else if (m[3]) {
      const [, label, url] = /^\[([^\]]+)\]\(([^)\s]+)\)$/.exec(tok) ?? [];
      const href = url ? safeUrl(url) : null;
      out.push(
        href ? (
          <a key={key++} href={href} target="_blank" rel="noreferrer" className="font-medium text-butter underline underline-offset-4 decoration-heart">
            {renderInline(label)}
          </a>
        ) : (
          tok
        ),
      );
    } else if (m[4]) {
      out.push(<em key={key++}>{renderInline(tok.slice(1, -1))}</em>);
    } else {
      out.push(
        <a key={key++} href={tok} target="_blank" rel="noreferrer" className="break-all font-medium text-butter underline underline-offset-4 decoration-heart">
          {tok}
        </a>,
      );
    }
    last = i + tok.length;
  }
  if (last < text.length) out.push(text.slice(last));
  return out;
}

export const ReleaseNotes: React.FC<{ markdown: string }> = ({ markdown }) => {
  const lines = markdown.replace(/\r\n?/g, '\n').split('\n');
  const blocks: React.ReactNode[] = [];
  let list: string[] = [];
  let para: string[] = [];
  let key = 0;

  const flushList = () => {
    if (!list.length) return;
    blocks.push(
      <ul key={key++} className="space-y-1.5 pl-1">
        {list.map((item, i) => (
          <li key={i} className="leading-relaxed">
            {renderInline(item)}
          </li>
        ))}
      </ul>,
    );
    list = [];
  };
  const flushPara = () => {
    if (!para.length) return;
    blocks.push(
      <p key={key++} className="leading-relaxed">
        {renderInline(para.join(' '))}
      </p>,
    );
    para = [];
  };

  for (const raw of lines) {
    const line = raw.trim();
    const heading = /^(#{1,6})\s+(.*)$/.exec(line);
    const bullet = /^[-*+]\s+(.*)$/.exec(line);
    const quote = /^>\s?(.*)$/.exec(line);

    if (!line) {
      flushList();
      flushPara();
    } else if (/^(-{3,}|\*{3,})$/.test(line)) {
      flushList();
      flushPara();
      blocks.push(<hr key={key++} className="border-paper/15" />);
    } else if (heading) {
      flushList();
      flushPara();
      const level = heading[1].length;
      blocks.push(
        <p key={key++} className={`font-display font-bold text-paper ${level <= 1 ? 'text-lg' : 'text-base'}`}>
          {renderInline(heading[2])}
        </p>,
      );
    } else if (bullet) {
      flushPara();
      list.push(bullet[1]);
    } else if (quote) {
      flushList();
      flushPara();
      blocks.push(
        <blockquote key={key++} className="border-l-2 border-heart pl-3 text-paper/70">
          {renderInline(quote[1])}
        </blockquote>,
      );
    } else {
      flushList();
      para.push(line);
    }
  }
  flushList();
  flushPara();

  return <div className="space-y-3 text-sm text-paper/75">{blocks}</div>;
};
