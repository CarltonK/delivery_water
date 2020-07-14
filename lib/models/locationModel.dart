class LocationModel {
  double latitude;
  double longitude;

  LocationModel({this.latitude, this.longitude});

  factory LocationModel.fromFirestore(Map<String, dynamic> data) =>
      LocationModel(
          latitude: data['latitude'] ?? null,
          longitude: data['longitude'] ?? null);

  Map<String, dynamic> toFirestore() =>
      {'latitude': latitude, 'longitude': longitude};
}
