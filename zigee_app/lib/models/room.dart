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

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as String,
      name: json['name'] as String,
      capacity: json['capacity'] as int,
      location: json['location'] as String,
      description: json['description'] as String?,
      isAvailable: json['is_available'] ?? true,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
      'location': location,
      'description': description,
      'is_available': isAvailable,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Room && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
