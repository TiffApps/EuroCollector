class CommCoin {
  final String year;
  final List<SpecialCoin> coins;

  CommCoin({
    required this.year,
    required this.coins,
  });

  factory CommCoin.fromJson(Map<String, dynamic> json) {
    return CommCoin(year: json['country'], coins: [
      for (final coin in json['coins'])
        SpecialCoin.fromJson(coin as Map<String, dynamic>)
    ]);
  }
}

class SpecialCoin {
  final String country;
  final String name;
  final String image;
  final String imageUrl;
  final String description;
  final String releaseDate;
  final String mintage;

  SpecialCoin({
    required this.country,
    required this.name,
    required this.image,
    required this.imageUrl,
    required this.description,
    required this.releaseDate,
    required this.mintage,
  });

  factory SpecialCoin.fromJson(Map<String, dynamic> json) {
    return SpecialCoin(
      country: json['country'],
      name: json['name'],
      image: json['image'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      releaseDate: json['release_date'],
      mintage: json['mintage'],
    );
  }
}
