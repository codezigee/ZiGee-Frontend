import 'package:zigee_app/models/room.dart';

class DummyRooms {
  static final List<Room> rooms = [
    Room(
      id: 'room_001',
      name: '1 회의실',
      capacity: 6,
      location: '2층 서쪽',
      description: '프로젝터, 화이트보드, 영상 회의 시설 완비',
      isAvailable: true,
      imageUrl:
          'https://images.unsplash.com/photo-1707386321206-b4ddaf645bbc?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Room(
      id: 'room_002',
      name: '2 회의실',
      capacity: 13,
      location: '2층 동쪽',
      description: '대형 회의테이블, 55인치 모니터, 영상회의 시설',
      isAvailable: true,
      imageUrl:
          'https://images.unsplash.com/photo-1631246957572-0c49e4ee6ff4?q=80&w=1724&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',

      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    Room(
      id: 'room_003',
      name: '3 회의실',
      capacity: 8,
      location: '3층 남쪽',
      description: '소규모 미팅룸, 화이트보드, 무선 프레젠테이션',
      isAvailable: false,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1681487144031-d502ea9abefc?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',

      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Room(
      id: 'room_004',
      name: '창의룸',
      capacity: 10,
      location: '1층 중앙',
      description: '브레인스토밍 전용 공간, 포스트잇 벽, 자유로운 좌석 배치',
      isAvailable: true,
      imageUrl: 'assets/images/trial_image_4.jpeg',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Room(
      id: 'room_007',
      name: '스터디룸 B',
      capacity: 4,
      location: '3층 구석',
      description: '조용한 개인/소규모 스터디 전용',
      isAvailable: false,
      imageUrl:
          'https://images.unsplash.com/photo-1631248366921-2c0f3583f6b8?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Room(
      id: 'room_008',
      name: '카페테리아',
      capacity: 16,
      location: '1층 카페테리아',
      description: '커피와 함께하는 오픈형 회의공간',
      isAvailable: true,
      imageUrl:
          'https://images.unsplash.com/photo-1552058461-dc1828d58bf6?q=80&w=1734&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 18)),
    ),
  ];

  static Room getRoomById(String id) {
    return rooms.firstWhere((room) => room.id == id, orElse: () => rooms.first);
  }
}
