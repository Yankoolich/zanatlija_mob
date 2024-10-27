enum CraftCategory {
  vodoinstalater,
  elektricar,
  bravar,
  varioc,
  mehanicar,
}

class Craft {
  final String craftsmanName;
  final String craftName;
  final String location;
  final int price;
  final String description;
  String? imageUrl;
  final double? rate;

  Craft({
    required this.craftsmanName,
    required this.craftName,
    required this.description,
    this.imageUrl,
    this.rate,
    required this.location,
    required this.price,
  });

  factory Craft.fromJson(Map<String, dynamic> json) => Craft(
        craftsmanName: json['craftsmanName'],
        craftName: json['craftName'],
        location: json['location'],
        price: json['price'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        rate: json['rate'],
      );

  Map<String, dynamic> toJson() => {
        'craftsmanName': craftsmanName,
        'craftName': craftName,
        'location': location,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
        'rate': rate,
      };
}
