class RiauDestination {
  final String id;
  final String name;
  final String location;
  final String address;
  final String thumbnail;
  final String category;
  final List<Object> description;
  final List<Object> detail;

  RiauDestination({
    this.id,
    this.name,
    this.location,
    this.address,
    this.thumbnail,
    this.category,
    this.description,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'address': address,
      'thumbnail': thumbnail,
      'category': category,
      'description': description,
      'detail': detail,
    };
  }

  RiauDestination.fromJSON(Map<String, dynamic> payload)
      : id = payload['id'],
        name = payload['name'],
        location = payload['location'],
        address = payload['address'],
        thumbnail = payload['thumbnail'],
        category = payload['category'],
        description = payload['description'],
        detail = payload['detail'];
}
