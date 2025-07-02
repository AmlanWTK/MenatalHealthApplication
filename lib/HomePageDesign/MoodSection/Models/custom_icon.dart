class CustomIcon {
  final String name;
  final String path;
  final String category;
  final List<String> tags;

  CustomIcon({
    required this.name,
    required this.path,
    required this.category,
    required this.tags,
  });

  factory CustomIcon.fromJson(Map<String, dynamic> json) {
    return CustomIcon(
      name: json['name'],
      path: json['path'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
    );
  }
}
