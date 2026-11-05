import 'package:flutter/material.dart';
import '../../core/theme/zalo_theme.dart';
import '../../shared/mock/mock_data.dart';
import '../../shared/models/chat_models.dart';
import '../../shared/responsive/responsive_layout.dart';
import '../navigation/desktop_nav_rail.dart';
import '../navigation/mobile_bottom_bar.dart';
import '../chat/presentation/chat_list_panel.dart';
import '../chat/presentation/chat_detail_panel.dart';
import '../locket_feed/presentation/locket_feed_panel.dart';
import '../custom_studio/presentation/custom_studio_panel.dart';
import '../friends/presentation/friends_panel.dart';
import '../settings/presentation/settings_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  Conversation? _selectedConversation = MockData.conversations.first;
  bool _mobileShowChatDetail = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktop: _buildDesktopLayout(),
      mobile: _buildMobileLayout(),
    );
  }

  // --- WINDOWS / DESKTOP LAYOUT (Zalo PC 3-Pane Structure) ---
  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          // 1. Left Nav Rail (68px)
          DesktopNavRail(
            selectedIndex: _currentTabIndex,
            onDestinationSelected: (index) {
              setState(() => _currentTabIndex = index);
            },
          ),
          // 2. Main Content Panels
          Expanded(
            child: _buildDesktopTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTabContent() {
    switch (_currentTabIndex) {
      case 0:
        // Chat Tab: Sub-sidebar (330px) + Chat Detail (Expanded)
        return Row(
          children: [
            ChatListPanel(
              selectedConversation: _selectedConversation,
              onSelectConversation: (conv) {
                setState(() => _selectedConversation = conv);
              },
            ),
            Expanded(
              child: _selectedConversation != null
                  ? ChatDetailPanel(conversation: _selectedConversation!)
                  : const Center(
                      child: Text(
                        'Chọn một cuộc trò chuyện để bắt đầu nhắn tin',
                        style: TextStyle(color: ZaloColors.textSecondary),
                      ),
                    ),
            ),
          ],
        );
      case 1:
        return FriendsPanel(
          onStartChat: (conv) {
            setState(() {
              _selectedConversation = conv;
              _currentTabIndex = 0;
            });
          },
        );
      case 2:
        return const LocketFeedPanel();
      case 3:
        return const CustomStudioPanel();
      case 4:
        return const SettingsPanel();
      default:
        return const SizedBox.shrink();
    }
  }

  // --- iOS / MOBILE LAYOUT (Zalo Mobile Bottom Navigation Structure) ---
  Widget _buildMobileLayout() {
    if (_currentTabIndex == 0 && _mobileShowChatDetail && _selectedConversation != null) {
      return Scaffold(
        body: SafeArea(
          child: ChatDetailPanel(
            conversation: _selectedConversation!,
            onBackMobile: () {
              setState(() => _mobileShowChatDetail = false);
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: _buildMobileTabContent(),
      ),
      bottomNavigationBar: MobileBottomBar(
        selectedIndex: _currentTabIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentTabIndex = index;
            _mobileShowChatDetail = false;
          });
        },
      ),
    );
  }

  Widget _buildMobileTabContent() {
    switch (_currentTabIndex) {
      case 0:
        return SizedBox.expand(
          child: ChatListPanel(
            selectedConversation: _selectedConversation,
            onSelectConversation: (conv) {
              setState(() {
                _selectedConversation = conv;
                _mobileShowChatDetail = true;
              });
            },
          ),
        );
      case 1:
        return FriendsPanel(
          onStartChat: (conv) {
            setState(() {
              _selectedConversation = conv;
              _currentTabIndex = 0;
              _mobileShowChatDetail = true;
            });
          },
        );
      case 2:
        return const LocketFeedPanel();
      case 3:
        return const CustomStudioPanel();
      case 4:
        return const SettingsPanel();
      default:
        return const SizedBox.shrink();
    }
  }
}
