import '../models/chat_models.dart';
import 'mock_conversations.dart';
import 'mock_friend_requests.dart';
import 'mock_messages.dart';
import 'mock_moments.dart';
import 'mock_users.dart';

export 'mock_conversations.dart';
export 'mock_friend_requests.dart';
export 'mock_messages.dart';
export 'mock_moments.dart';
export 'mock_users.dart';

class MockData {
  static const currentUser = MockUsers.currentUser;

  static List<Conversation> get conversations => MockConversations.conversations;

  static Map<String, List<ChatMessage>> get messages => MockMessages.messages;

  static List<LocketMoment> get locketMoments => MockMoments.feedMoments;

  static List<Map<String, String>> get sampleFriendMoments => MockMoments.sampleFriendMoments;

  static List<FriendRequest> get receivedFriendRequests => MockFriendRequests.receivedRequests;

  static List<FriendRequest> get sentFriendRequests => MockFriendRequests.sentRequests;
  static List<Map<String, String>> getMomentsForUser(String userId) => MockMoments.getMomentsForUser(userId);
  static List<Map<String, String>> get allMomentsWithAuthors => MockMoments.getAllMomentsWithAuthors();
}
