import { useEffect, useState } from 'react';
import './App.css';
import { Navbar } from '@/components/layout/Navbar';
import { Footer } from '@/components/layout/Footer';
import { HeroSection } from '@/components/sections/HeroSection';
import { StorySection } from '@/components/sections/StorySection';
import { FeaturesSection } from '@/components/sections/FeaturesSection';
import { CommunitySection } from '@/components/sections/CommunitySection';
import { ExploreSection } from '@/components/sections/ExploreSection';
import { DownloadSection } from '@/components/sections/DownloadSection';
import { SupportSection } from '@/components/sections/SupportSection';
import { FALLBACK_DATA, getDownloadData } from '@/services/downloadService';
import { detectPlatform } from '@/lib/platform';
import { Intro } from '@/components/Intro';
import { shouldPlayIntro, useMotion } from '@/lib/motion';
import type { DownloadData, PlatformId } from '@/types/download';

const PLAY_INTRO = shouldPlayIntro();
if (PLAY_INTRO) document.documentElement.style.setProperty('--intro', '1s');

export default function App() {
  const [introDone, setIntroDone] = useState(!PLAY_INTRO);
  useMotion();
  const [data, setData] = useState<DownloadData>(FALLBACK_DATA);
  const [loading, setLoading] = useState(true);
  const [detected] = useState<PlatformId | null>(detectPlatform);
  const [selectedPlatform, setSelectedPlatform] = useState<PlatformId>(detected ?? 'windows');

  useEffect(() => {
    const controller = new AbortController();
    getDownloadData(controller.signal)
      .then(setData)
      .catch(() => {})
      .finally(() => {
        if (!controller.signal.aborted) setLoading(false);
      });
    return () => controller.abort();
  }, []);

  const handleSelectPlatform = (platform: PlatformId) => {
    setSelectedPlatform(platform);
  };

  return (
    <div className="relative min-h-screen bg-background text-foreground flex flex-col selection:bg-heart selection:text-ink overflow-x-hidden">
      <a
        href="#main"
        className="sr-only focus:not-sr-only focus:fixed focus:top-3 focus:left-3 focus:z-[100] focus:rounded-lg focus:bg-primary focus:px-4 focus:py-2 focus:text-primary-foreground"
      >
        Bỏ qua điều hướng
      </a>

      <div className="pointer-events-none fixed inset-0 z-0 overflow-hidden" aria-hidden="true">
        <div
          className="aurora -left-[25vmax] -top-[30vmax] opacity-45"
          style={{ background: 'radial-gradient(circle, var(--heart) 0%, transparent 62%)', translate: '0 calc(var(--sy) * -0.06px)' }}
        />
        <div
          className="aurora -bottom-[35vmax] -right-[25vmax] opacity-30"
          style={{ background: 'radial-gradient(circle, var(--sky) 0%, transparent 62%)', animationDirection: 'alternate-reverse', translate: '0 calc(var(--sy) * 0.05px)' }}
        />
      </div>

      <Navbar />

      <main id="main" className="relative z-10 flex-1">
        <HeroSection
          release={data.release}
          platforms={data.platforms}
          detected={detected}
          onSelectPlatform={handleSelectPlatform}
        />
        <StorySection />
        <DownloadSection
          data={data}
          loading={loading}
          platform={selectedPlatform}
          onPlatformChange={setSelectedPlatform}
          detected={detected}
        />
        <SupportSection />
        <FeaturesSection />
        <CommunitySection />
        <ExploreSection />
      </main>

      {!introDone && <Intro onDone={() => setIntroDone(true)} />}
      <Footer />
    </div>
  );
}
