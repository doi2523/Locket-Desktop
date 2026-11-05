import { useEffect, useState } from 'react';
import './App.css';
import SideRays from '@/components/SideRays';
import { Navbar } from '@/components/layout/Navbar';
import { Footer } from '@/components/layout/Footer';
import { HeroSection } from '@/components/sections/HeroSection';
import { StatsSection } from '@/components/sections/StatsSection';
import { FeaturesSection } from '@/components/sections/FeaturesSection';
import { DownloadSection } from '@/components/sections/DownloadSection';
import { SupportSection } from '@/components/sections/SupportSection';
import { DonateModal } from '@/components/modals/DonateModal';
import {
  MOCK_DOWNLOAD_STATS,
  MOCK_PLATFORM_DOWNLOADS,
  getDownloadStats,
  getPlatformDownloads,
} from '@/services/downloadService';
import type { DownloadStats, PlatformDownload } from '@/types/download';

export default function App() {
  const [stats, setStats] = useState<DownloadStats>(MOCK_DOWNLOAD_STATS);
  const [platforms, setPlatforms] = useState<PlatformDownload[]>(MOCK_PLATFORM_DOWNLOADS);
  const [loading, setLoading] = useState(false);
  const [donateModalOpen, setDonateModalOpen] = useState(false);
  const [selectedPlatform, setSelectedPlatform] = useState<'windows' | 'macos'>('macos');

  useEffect(() => {
    // Detect OS of current visitor to highlight the relevant download card
    if (typeof window !== 'undefined' && navigator.userAgent) {
      const isWindows = navigator.userAgent.toLowerCase().includes('windows');
      if (isWindows) {
        setSelectedPlatform('windows');
      } else {
        setSelectedPlatform('macos');
      }
    }

    // Load data from download service (mockdata currently, easily switched to API)
    setLoading(true);
    Promise.all([getDownloadStats(), getPlatformDownloads()])
      .then(([statsData, platformsData]) => {
        setStats(statsData);
        setPlatforms(platformsData);
      })
      .catch((err) => {
        console.error('Failed to load download stats:', err);
      })
      .finally(() => {
        setLoading(false);
      });
  }, []);

  const handleSelectPlatform = (platform: 'windows' | 'macos') => {
    setSelectedPlatform(platform);
    const element = document.getElementById('download');
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <div className="relative min-h-screen bg-background text-foreground flex flex-col selection:bg-amber-500/20 selection:text-amber-600 overflow-x-hidden">
      {/* Nền SideRays fill toàn bộ màn hình (Fixed Fullscreen Background) */}
      <div
        className="fixed inset-0 w-screen h-screen pointer-events-none z-0 overflow-hidden"
        style={{ width: '100vw', height: '100vh', position: 'fixed', inset: 0 }}
      >
        <SideRays
          rayColor1="#FFC46B"
          rayColor2="#96c8ff"
          origin="top-right"
          speed={2.5}
          intensity={2}
          spread={2}
          density={5}
          followMouse={true}
        />
        {/* Soft overlay gradient so text & cards remain perfectly crisp and legible */}
        <div className="absolute inset-0 bg-background/55 backdrop-blur-[0.5px] pointer-events-none" />
      </div>

      {/* Navigation Header */}
      <Navbar onOpenDonate={() => setDonateModalOpen(true)} />

      {/* Main Content Sections */}
      <main className="relative z-10 flex-1">
        {/* 1. Hero with 2 main download buttons */}
        <HeroSection stats={stats} onSelectPlatform={handleSelectPlatform} />

        {/* 2. Download Counters & Rating Stats from API / Mockdata */}
        <StatsSection stats={stats} loading={loading} />

        {/* 3. Features Introduction ("Giới thiệu") */}
        <FeaturesSection />

        {/* 4. Download Center ("Tải ứng dụng" - macOS & Windows) */}
        <DownloadSection platforms={platforms} defaultPlatform={selectedPlatform} />

        {/* 5. Support / Donation Section ("Ủng hộ") */}
        <SupportSection onOpenDonateModal={() => setDonateModalOpen(true)} />
      </main>

      {/* Footer */}
      <Footer onOpenDonate={() => setDonateModalOpen(true)} />

      {/* Interactive Modal for Donate / QR Scan */}
      <DonateModal open={donateModalOpen} onOpenChange={setDonateModalOpen} />
    </div>
  );
}
