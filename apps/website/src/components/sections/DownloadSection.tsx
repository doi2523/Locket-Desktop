import * as React from 'react';
import {
  AlertCircle,
  Apple,
  Check,
  Copy,
  Download,
  FileArchive,
  HardDrive,
  Monitor,
  Shield,
  Sparkles,
} from 'lucide-react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import type { PlatformDownload } from '@/types/download';

interface DownloadSectionProps {
  platforms: PlatformDownload[];
  defaultPlatform?: 'windows' | 'macos';
}

export const DownloadSection: React.FC<DownloadSectionProps> = ({
  platforms,
  defaultPlatform = 'macos',
}) => {
  const [activeTab, setActiveTab] = React.useState<'windows' | 'macos'>(defaultPlatform);
  const [copiedId, setCopiedId] = React.useState<string | null>(null);

  React.useEffect(() => {
    if (defaultPlatform) {
      setActiveTab(defaultPlatform);
    }
  }, [defaultPlatform]);

  const copyChecksum = (id: string, text: string) => {
    navigator.clipboard.writeText(text);
    setCopiedId(id);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const currentPlatformData = platforms.find((p) => p.platform === activeTab) || platforms[0];

  return (
    <section id="download" className="py-24 relative z-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center max-w-3xl mx-auto mb-12 space-y-4">
          <Badge variant="amber" className="px-3.5 py-1 text-xs border-0 bg-amber-500/15">
            <Download className="w-3.5 h-3.5" /> Trung tâm tải về
          </Badge>
          <h2 className="text-3xl sm:text-5xl font-extrabold tracking-tight text-foreground">
            Tải Locket Dio Desktop Cho Thiết Bị Của Bạn
          </h2>
          <p className="text-base sm:text-lg text-muted-foreground leading-relaxed">
            Chọn hệ điều hành phù hợp để tải về tệp cài đặt chính thức. Hoàn toàn miễn phí, an toàn và hỗ trợ cập nhật tự động.
          </p>
        </div>

        {/* Platform Switcher Tabs */}
        <div className="max-w-4xl mx-auto">
          <Tabs
            value={activeTab}
            onValueChange={(val) => setActiveTab(val as 'windows' | 'macos')}
            className="w-full"
          >
            <div className="flex justify-center mb-10">
              <TabsList className="grid grid-cols-2 w-full max-w-md h-14 p-1.5 rounded-2xl bg-card/40 backdrop-blur-2xl border-0 shadow-none">
                <TabsTrigger
                  value="macos"
                  className="rounded-xl font-bold flex items-center justify-center gap-2 data-[state=active]:bg-primary data-[state=active]:text-primary-foreground transition-all cursor-pointer"
                >
                  <Apple className="w-4 h-4 fill-current" />
                  <span>macOS</span>
                  <Badge variant="secondary" className="text-[10px] hidden sm:inline py-0 border-0 bg-white/10">
                    .dmg
                  </Badge>
                </TabsTrigger>
                <TabsTrigger
                  value="windows"
                  className="rounded-xl font-bold flex items-center justify-center gap-2 data-[state=active]:bg-primary data-[state=active]:text-primary-foreground transition-all cursor-pointer"
                >
                  <Monitor className="w-4 h-4" />
                  <span>Windows</span>
                  <Badge variant="secondary" className="text-[10px] hidden sm:inline py-0 border-0 bg-white/10">
                    .exe / .zip
                  </Badge>
                </TabsTrigger>
              </TabsList>
            </div>

            {/* macOS Content */}
            <TabsContent value="macos" className="space-y-8 animate-in fade-in-50 duration-300">
              {currentPlatformData && (
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  {/* File Download Cards */}
                  <div className="md:col-span-2 space-y-4">
                    {currentPlatformData.files.map((file) => (
                      <Card
                        key={file.id}
                        className="border-0 bg-card/35 hover:bg-card/65 backdrop-blur-2xl rounded-3xl shadow-none relative overflow-hidden transition-all"
                      >
                        <div className="absolute top-0 right-0">
                          <span className="bg-gradient-to-l from-amber-500 to-orange-500 text-white text-[11px] font-bold px-4 py-1.5 rounded-bl-2xl shadow-sm">
                            Khuyên Dùng
                          </span>
                        </div>
                        <CardHeader className="pb-3">
                          <div className="flex items-center gap-3">
                            <div className="w-12 h-12 rounded-2xl bg-amber-500/10 text-amber-500 flex items-center justify-center">
                              <Apple className="w-7 h-7 fill-current" />
                            </div>
                            <div>
                              <CardTitle className="text-xl flex items-center gap-2">
                                <span>{file.name}</span>
                              </CardTitle>
                              <CardDescription className="text-xs font-mono mt-0.5">
                                {file.filename} • {file.size}
                              </CardDescription>
                            </div>
                          </div>
                        </CardHeader>

                        <CardContent className="space-y-4">
                          <p className="text-sm text-muted-foreground leading-relaxed">
                            {file.description}
                          </p>

                          <div className="flex flex-wrap items-center gap-4 text-xs text-muted-foreground pt-1">
                            <span className="flex items-center gap-1">
                              <HardDrive className="w-4 h-4 text-primary" />
                              <span>Dung lượng: <strong>{file.size}</strong></span>
                            </span>
                            <span className="flex items-center gap-1">
                              <Download className="w-4 h-4 text-amber-500" />
                              <span>Lượt tải: <strong>{file.downloadsCount.toLocaleString()}</strong></span>
                            </span>
                            <span className="flex items-center gap-1">
                              <Shield className="w-4 h-4 text-emerald-500" />
                              <span>Kiểm tra: <strong>An toàn</strong></span>
                            </span>
                          </div>

                          {/* Action Button */}
                          <div className="pt-2">
                            <a href={file.downloadUrl} className="block w-full">
                              <Button
                                variant="glow"
                                size="lg"
                                className="w-full gap-2 text-base shadow-xl cursor-pointer"
                              >
                                <Download className="w-5 h-5" />
                                <span>Tải ngay {file.filename}</span>
                              </Button>
                            </a>
                          </div>

                          {/* Checksum */}
                          <div className="flex items-center justify-between text-[11px] font-mono text-muted-foreground bg-white/[0.04] p-3 rounded-2xl">
                            <span className="truncate mr-2">{file.checksum}</span>
                            <button
                              onClick={() => copyChecksum(file.id, file.checksum)}
                              className="text-xs font-sans text-primary hover:underline flex items-center gap-1 shrink-0 cursor-pointer"
                            >
                              {copiedId === file.id ? (
                                <>
                                  <Check className="w-3.5 h-3.5 text-emerald-500" />
                                  <span className="text-emerald-500">Đã chép</span>
                                </>
                              ) : (
                                <>
                                  <Copy className="w-3.5 h-3.5" />
                                  <span>Sao chép</span>
                                </>
                              )}
                            </button>
                          </div>
                        </CardContent>
                      </Card>
                    ))}
                  </div>

                  {/* Instructions Sidebar */}
                  <div className="space-y-4">
                    <Card className="border-0 bg-card/35 backdrop-blur-2xl rounded-3xl shadow-none">
                      <CardHeader className="pb-3">
                        <CardTitle className="text-lg flex items-center gap-2">
                          <Sparkles className="w-4 h-4 text-amber-500" />
                          <span>Yêu Cầu Hệ Thống</span>
                        </CardTitle>
                      </CardHeader>
                      <CardContent className="space-y-3 text-xs text-muted-foreground">
                        <div>
                          <strong className="text-foreground block">Hệ điều hành:</strong>
                          <span>{currentPlatformData.osRequirement}</span>
                        </div>
                        <div>
                          <strong className="text-foreground block">Vi xử lý hỗ trợ:</strong>
                          <span>{currentPlatformData.architecture}</span>
                        </div>
                        <div>
                          <strong className="text-foreground block">Phiên bản phát hành:</strong>
                          <span>{currentPlatformData.latestVersion} ({currentPlatformData.releaseDate})</span>
                        </div>
                      </CardContent>
                    </Card>

                    <Card className="border-0 bg-card/35 backdrop-blur-2xl rounded-3xl shadow-none">
                      <CardHeader className="pb-3">
                        <CardTitle className="text-lg flex items-center gap-2">
                          <AlertCircle className="w-4 h-4 text-sky-500" />
                          <span>Hướng Dẫn Cài Đặt</span>
                        </CardTitle>
                      </CardHeader>
                      <CardContent>
                        <ol className="space-y-2.5 text-xs text-muted-foreground list-decimal pl-4">
                          {currentPlatformData.installSteps.map((step, idx) => (
                            <li key={idx} className="leading-relaxed">
                              {step}
                            </li>
                          ))}
                        </ol>
                      </CardContent>
                    </Card>
                  </div>
                </div>
              )}
            </TabsContent>

            {/* Windows Content */}
            <TabsContent value="windows" className="space-y-8 animate-in fade-in-50 duration-300">
              {currentPlatformData && (
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  {/* File Download Cards */}
                  <div className="md:col-span-2 space-y-4">
                    {currentPlatformData.files.map((file) => (
                      <Card
                        key={file.id}
                        className="border-0 bg-card/35 hover:bg-card/65 backdrop-blur-2xl rounded-3xl shadow-none relative overflow-hidden transition-all"
                      >
                        {file.recommended && (
                          <div className="absolute top-0 right-0">
                            <span className="bg-gradient-to-l from-sky-500 to-indigo-600 text-white text-[11px] font-bold px-4 py-1.5 rounded-bl-2xl shadow-sm">
                              Khuyên Dùng (Có Tự Cập Nhật)
                            </span>
                          </div>
                        )}
                        <CardHeader className="pb-3">
                          <div className="flex items-center gap-3">
                            <div className="w-12 h-12 rounded-2xl bg-sky-500/10 text-sky-500 flex items-center justify-center">
                              {file.format === 'zip' ? (
                                <FileArchive className="w-7 h-7" />
                              ) : (
                                <Monitor className="w-7 h-7" />
                              )}
                            </div>
                            <div>
                              <CardTitle className="text-xl flex items-center gap-2">
                                <span>{file.name}</span>
                              </CardTitle>
                              <CardDescription className="text-xs font-mono mt-0.5">
                                {file.filename} • {file.size}
                              </CardDescription>
                            </div>
                          </div>
                        </CardHeader>

                        <CardContent className="space-y-4">
                          <p className="text-sm text-muted-foreground leading-relaxed">
                            {file.description}
                          </p>

                          <div className="flex flex-wrap items-center gap-4 text-xs text-muted-foreground pt-1">
                            <span className="flex items-center gap-1">
                              <HardDrive className="w-4 h-4 text-primary" />
                              <span>Dung lượng: <strong>{file.size}</strong></span>
                            </span>
                            <span className="flex items-center gap-1">
                              <Download className="w-4 h-4 text-sky-500" />
                              <span>Lượt tải: <strong>{file.downloadsCount.toLocaleString()}</strong></span>
                            </span>
                            <span className="flex items-center gap-1">
                              <Shield className="w-4 h-4 text-emerald-500" />
                              <span>Chữ ký: <strong>Hợp lệ</strong></span>
                            </span>
                          </div>

                          {/* Action Button */}
                          <div className="pt-2">
                            <a href={file.downloadUrl} className="block w-full">
                              <Button
                                variant={file.recommended ? 'default' : 'secondary'}
                                size="lg"
                                className="w-full gap-2 text-base shadow-lg cursor-pointer"
                              >
                                <Download className="w-5 h-5" />
                                <span>Tải ngay {file.filename}</span>
                              </Button>
                            </a>
                          </div>

                          {/* Checksum */}
                          <div className="flex items-center justify-between text-[11px] font-mono text-muted-foreground bg-white/[0.04] p-3 rounded-2xl">
                            <span className="truncate mr-2">{file.checksum}</span>
                            <button
                              onClick={() => copyChecksum(file.id, file.checksum)}
                              className="text-xs font-sans text-primary hover:underline flex items-center gap-1 shrink-0 cursor-pointer"
                            >
                              {copiedId === file.id ? (
                                <>
                                  <Check className="w-3.5 h-3.5 text-emerald-500" />
                                  <span className="text-emerald-500">Đã chép</span>
                                </>
                              ) : (
                                <>
                                  <Copy className="w-3.5 h-3.5" />
                                  <span>Sao chép</span>
                                </>
                              )}
                            </button>
                          </div>
                        </CardContent>
                      </Card>
                    ))}
                  </div>

                  {/* Instructions Sidebar */}
                  <div className="space-y-4">
                    <Card className="border-0 bg-card/35 backdrop-blur-2xl rounded-3xl shadow-none">
                      <CardHeader className="pb-3">
                        <CardTitle className="text-lg flex items-center gap-2">
                          <Sparkles className="w-4 h-4 text-sky-500" />
                          <span>Yêu Cầu Hệ Thống</span>
                        </CardTitle>
                      </CardHeader>
                      <CardContent className="space-y-3 text-xs text-muted-foreground">
                        <div>
                          <strong className="text-foreground block">Hệ điều hành:</strong>
                          <span>{currentPlatformData.osRequirement}</span>
                        </div>
                        <div>
                          <strong className="text-foreground block">Kiến trúc chip:</strong>
                          <span>{currentPlatformData.architecture}</span>
                        </div>
                        <div>
                          <strong className="text-foreground block">Bản cập nhật mới nhất:</strong>
                          <span>{currentPlatformData.latestVersion} ({currentPlatformData.releaseDate})</span>
                        </div>
                      </CardContent>
                    </Card>

                    <Card className="border-0 bg-card/35 backdrop-blur-2xl rounded-3xl shadow-none">
                      <CardHeader className="pb-3">
                        <CardTitle className="text-lg flex items-center gap-2">
                          <AlertCircle className="w-4 h-4 text-sky-500" />
                          <span>Hướng Dẫn Cài Đặt</span>
                        </CardTitle>
                      </CardHeader>
                      <CardContent>
                        <ol className="space-y-2.5 text-xs text-muted-foreground list-decimal pl-4">
                          {currentPlatformData.installSteps.map((step, idx) => (
                            <li key={idx} className="leading-relaxed">
                              {step}
                            </li>
                          ))}
                        </ol>
                      </CardContent>
                    </Card>
                  </div>
                </div>
              )}
            </TabsContent>
          </Tabs>
        </div>
      </div>
    </section>
  );
};
