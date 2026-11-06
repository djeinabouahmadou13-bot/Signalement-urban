class Signalement {
  final int? id;
  final String type;
  final String titre;
  final String description;
  final String? photo;
  final double latitude;
  final double longitude;
  final String statut;
  final String date;

  Signalement({
    this.id,
    required this.type,
    required this.titre,
    required this.description,
    this.photo,
    required this.latitude,
    required this.longitude,
    this.statut = 'nouveau',
    required this.date,
  });

  // Objet Dart -> ligne de la base
  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'titre': titre,
        'description': description,
        'photo': photo,
        'latitude': latitude,
        'longitude': longitude,
        'statut': statut,
        'date': date,
      };

  // Ligne de la base -> objet Dart
  factory Signalement.fromMap(Map<String, dynamic> m) => Signalement(
        id: m['id'],
        type: m['type'],
        titre: m['titre'],
        description: m['description'],
        photo: m['photo'],
        latitude: m['latitude'],
        longitude: m['longitude'],
        statut: m['statut'],
        date: m['date'],
      );
}