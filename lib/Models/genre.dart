// ignore_for_file: public_member_api_docs, sort_constructors_first
class Genre {
  int id;
  String name;
  Genre({
    required this.id,
    required this.name,
  });
  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );
}
