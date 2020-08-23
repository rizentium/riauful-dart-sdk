class RiauDestination {
  final String id;
  final String name;
  final String location;
  final String address;
  final String thumbnail;
  final String category;

  RiauDestination({
    this.id,
    this.name,
    this.location,
    this.address,
    this.thumbnail,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'address': address,
      'thumbnail': thumbnail,
      'category': category,
    };
  }

  RiauDestination.fromJSON(Map<String, dynamic> payload)
      : id = payload['id'],
        name = payload['name'],
        location = payload['location'],
        address = payload['address'],
        thumbnail = payload['thumbnail'],
        category = payload['category'];
}
