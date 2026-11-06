import * as React from 'react';

/**
 * Câu chuyện ra đời của ứng dụng, kể theo ngôi thứ nhất của tác giả.
 * Phần mở đầu là lời của tác giả; các đoạn sau được viết nối tiếp, cần tác giả đọc lại và chỉnh cho đúng thực tế.
 */
const STORY: string[] = [
  'Ứng dụng ra đời ngay giữa lúc tôi đang làm việc. Mắt dán vào màn hình, việc còn dở, mà điện thoại cứ rung lên vì một moment mới của bạn bè.',
  'Lần nào cũng vậy: cầm điện thoại lên, xem xong, trả lời xong rồi mới quay lại việc đang làm. Đến một lúc tôi nghĩ, tại sao không có Locket ngay trên máy tính?',
  'Thế là tôi tự làm. Từng chút một: xem feed, nhắn tin, đăng moment, lịch streak, cho đến khi những thứ tôi cần đều nằm gọn trong một cửa sổ.',
  'Locket Dio Desktop vẫn là dự án của một người, làm ra vì nhu cầu của chính mình. Nếu bạn cũng hay lỡ moment vì đang ngồi trước máy tính, có thể nó cũng dành cho bạn.',
];

export const StorySection: React.FC = () => (
  <section id="story" aria-labelledby="story-title" className="relative z-10 pb-14 pt-6 sm:pb-20 sm:pt-10">
    <div className="mx-auto grid max-w-7xl gap-10 px-5 sm:px-8 lg:grid-cols-[1fr_1.1fr] lg:gap-16">
      <div className="reveal">
        <h2 id="story-title" className="t-h2 text-heart">
          Câu chuyện
        </h2>
        <p className="t-sub mt-3 text-paper">
          Một lần rút điện thoại <span className="text-butter">giữa giờ làm.</span>
        </p>

        <figure className="mt-8 lg:mt-10">
          <span aria-hidden="true" className="block select-none font-display text-7xl font-extrabold leading-[0.6] text-heart">
            “
          </span>
          <blockquote className="font-display text-[clamp(1.6rem,1.1rem+2.4vw,2.9rem)] font-extrabold leading-[1.15] tracking-tight text-paper">
            Tại sao không có Locket ngay trên <span className="text-butter">máy tính?</span>
          </blockquote>
        </figure>
      </div>

      <div className="reveal space-y-5 lg:pt-3" style={{ '--d': '0.1s' } as React.CSSProperties}>
        {STORY.map((p, i) => (
          <p key={i} className={i === 0 ? 't-lead text-paper' : 't-lead text-paper/75'}>
            {p}
          </p>
        ))}
        <p className="flex items-center gap-3 pt-2 font-medium text-paper">
          <span aria-hidden="true" className="h-0.5 w-8 rounded-full bg-heart" />
          Dio, tác giả Locket Dio Desktop
        </p>
      </div>
    </div>
  </section>
);
