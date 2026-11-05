import * as React from 'react';
import { Download, Heart, Menu, Sparkles, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { GithubIcon } from '@/components/icons/GithubIcon';

interface NavbarProps {
  onOpenDonate?: () => void;
}

export const Navbar: React.FC<NavbarProps> = ({ onOpenDonate }) => {
  const [mobileMenuOpen, setMobileMenuOpen] = React.useState(false);
  const [isScrolled, setIsScrolled] = React.useState(false);

  React.useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const scrollToSection = (id: string) => {
    setMobileMenuOpen(false);
    const element = document.getElementById(id);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        isScrolled
          ? 'bg-background/60 backdrop-blur-2xl shadow-sm py-3'
          : 'bg-transparent py-5'
      }`}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between">
          {/* Logo & Brand */}
          <div
            onClick={() => scrollToSection('hero')}
            className="flex items-center gap-3 cursor-pointer group select-none"
          >
            <div className="relative">
              <img
                src="/app-icon.png"
                alt="Locket Dio Icon"
                className="w-10 h-10 rounded-2xl shadow-md transition-transform duration-300 group-hover:scale-105"
              />
              <span className="absolute -bottom-1 -right-1 flex h-3 w-3">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-amber-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-3 w-3 bg-amber-500"></span>
              </span>
            </div>
            <div className="flex flex-col">
              <div className="flex items-center gap-2">
                <span className="font-extrabold text-lg tracking-tight text-foreground group-hover:text-amber-500 transition-colors">
                  Locket Dio
                </span>
                <Badge variant="amber" className="text-[10px] px-1.5 py-0 border-0 bg-amber-500/15">
                  Desktop
                </Badge>
              </div>
              <span className="text-xs text-muted-foreground font-medium hidden sm:inline">
                Windows & macOS
              </span>
            </div>
          </div>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-1 bg-white/[0.04] backdrop-blur-2xl px-3 py-1.5 rounded-full border-0">
            <button
              onClick={() => scrollToSection('hero')}
              className="px-4 py-1.5 text-sm font-medium text-foreground/80 hover:text-foreground hover:bg-white/[0.08] rounded-full transition-all cursor-pointer"
            >
              Trang chủ
            </button>
            <button
              onClick={() => scrollToSection('features')}
              className="px-4 py-1.5 text-sm font-medium text-foreground/80 hover:text-foreground hover:bg-white/[0.08] rounded-full transition-all cursor-pointer"
            >
              Giới thiệu
            </button>
            <button
              onClick={() => {
                if (onOpenDonate) onOpenDonate();
                else scrollToSection('support');
              }}
              className="px-4 py-1.5 text-sm font-medium text-rose-400 hover:text-rose-300 hover:bg-white/[0.08] rounded-full transition-all flex items-center gap-1.5 cursor-pointer"
            >
              <Heart className="w-3.5 h-3.5 fill-rose-500/20 text-rose-500" />
              Ủng hộ
            </button>
            <button
              onClick={() => scrollToSection('download')}
              className="px-4 py-1.5 text-sm font-medium text-foreground/80 hover:text-foreground hover:bg-white/[0.08] rounded-full transition-all cursor-pointer"
            >
              Tải ứng dụng
            </button>
          </nav>

          {/* Action CTAs */}
          <div className="hidden sm:flex items-center gap-3">
            <a
              href="https://github.com/doi2523/Locket-Desktop"
              target="_blank"
              rel="noreferrer"
              className="text-muted-foreground hover:text-foreground transition-colors p-2 rounded-xl hover:bg-white/[0.06]"
              title="GitHub Repository"
            >
              <GithubIcon className="w-5 h-5" />
            </a>

            <Button
              variant="glow"
              size="sm"
              onClick={() => scrollToSection('download')}
              className="cursor-pointer"
            >
              <Download className="w-4 h-4 mr-1.5" />
              Tải ngay
            </Button>
          </div>

          {/* Mobile menu button */}
          <div className="flex md:hidden items-center gap-2">
            <Button
              variant="glow"
              size="sm"
              onClick={() => scrollToSection('download')}
              className="text-xs px-3 cursor-pointer"
            >
              <Download className="w-3.5 h-3.5" />
              Tải
            </Button>
            <button
              onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
              className="p-2 rounded-xl text-foreground hover:bg-white/[0.06] transition-colors cursor-pointer"
              aria-label="Toggle menu"
            >
              {mobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Drawer */}
      {mobileMenuOpen && (
        <div className="md:hidden border-0 bg-background/95 backdrop-blur-2xl px-6 py-5 shadow-2xl animate-in slide-in-from-top duration-200">
          <div className="flex flex-col space-y-3">
            <button
              onClick={() => scrollToSection('hero')}
              className="text-left px-4 py-2.5 rounded-xl text-base font-semibold hover:bg-white/[0.06] text-foreground transition-all cursor-pointer"
            >
              🏠 Trang chủ
            </button>
            <button
              onClick={() => scrollToSection('features')}
              className="text-left px-4 py-2.5 rounded-xl text-base font-semibold hover:bg-white/[0.06] text-foreground transition-all cursor-pointer"
            >
              ✨ Giới thiệu tính năng
            </button>
            <button
              onClick={() => {
                setMobileMenuOpen(false);
                if (onOpenDonate) onOpenDonate();
                else scrollToSection('support');
              }}
              className="text-left px-4 py-2.5 rounded-xl text-base font-semibold hover:bg-white/[0.06] text-rose-400 flex items-center gap-2 transition-all cursor-pointer"
            >
              <Heart className="w-4 h-4 fill-rose-500" /> Ủng hộ nhà phát triển
            </button>
            <button
              onClick={() => scrollToSection('download')}
              className="text-left px-4 py-2.5 rounded-xl text-base font-semibold bg-white/[0.06] text-primary flex items-center justify-between cursor-pointer"
            >
              <span>⬇️ Tải ứng dụng (macOS & Windows)</span>
              <Sparkles className="w-4 h-4 text-amber-500" />
            </button>
            <div className="pt-2 flex items-center justify-between px-2">
              <span className="text-xs text-muted-foreground">Mã nguồn mở trên GitHub</span>
              <a
                href="https://github.com/doi2523/Locket-Desktop"
                target="_blank"
                rel="noreferrer"
                className="flex items-center gap-1.5 text-xs font-semibold text-foreground hover:underline"
              >
                <GithubIcon className="w-4 h-4" /> doi2523/Locket-Desktop
              </a>
            </div>
          </div>
        </div>
      )}
    </header>
  );
};
