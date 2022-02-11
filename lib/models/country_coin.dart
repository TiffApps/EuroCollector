class CountryCoin {
  final String name;
  final String flag;
  final String description;
  final List<Coin> coins;

  CountryCoin({
    required this.name,
    required this.flag,
    required this.description,
    required this.coins,
  });

  factory CountryCoin.fromJson(Map<String, dynamic> json) {
    return CountryCoin(
        name: json['country'],
        flag: json['flagPath'],
        description: json['description'],
        coins: [
          for (final coin in json['coins'])
            Coin.fromJson(coin as Map<String, dynamic>)
        ]);
  }

  bool checkIfAnyIsNull() {
    return [name, flag, description, coins].contains(null);
  }
}

class Coin {
  final String value;
  final String description;
  final String image;
  final String imageUrl;

  Coin({
    required this.value,
    required this.description,
    required this.image,
    required this.imageUrl,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      value: json['value'],
      description: json['description'],
      image: json['image'],
      imageUrl: json['imageUrl'],
    );
  }
}
