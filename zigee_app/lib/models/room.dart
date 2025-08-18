class Room {
  final String id;
  final String name;
  final int capacity;
  final String location;
  final String? description;
  final bool isAvailable;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Room({
    required this.id,
    required this.name,
    required this.capacity,
    required this.location,
    this.description,
    this.isAvailable = true,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // TODO: - imageUrl 유효성 검사하는 비즈니스 로직 추가

  bool get hasDescription => description != null && description!.isNotEmpty;

  String get capacityText => '${capacity}명';

  bool canAccommodate(int requiredCapacity) {
    return isAvailable && capacity >= requiredCapacity;
  }

  Room copyWith({
    String? name,
    int? capacity,
    String? location,
    String? description,
    bool? isAvailable,
    String? imageUrl,
  }) {
    return Room(
      id: id,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      location: location ?? this.location,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Room && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
