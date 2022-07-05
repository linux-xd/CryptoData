class PostModel {
  PostModel({
    num? price_usd,
    int? type_is_crypto,
    String? asset_id,
    String? name,
  }) {
    _price_usd = price_usd;
    _type_is_crypto = type_is_crypto;
    _asset_id = asset_id;
    _name = name;
  }

  PostModel.fromJson(dynamic json) {
    _price_usd = json['price_usd'];
    _type_is_crypto = json['type_is_crypto'];
    _asset_id = json['asset_id'];
    _name = json['name'];
  }
  num? _price_usd;
  int? _type_is_crypto;
  String? _asset_id;
  String? _name;

  PostModel copyWith({
    num? price_usd,
    int? type_is_crypto,
    String? asset_id,
    String? name,
  }) =>
      PostModel(
        price_usd: price_usd ?? _price_usd,
        type_is_crypto: type_is_crypto ?? _type_is_crypto,
        asset_id: asset_id ?? _asset_id,
        name: name ?? _name,
      );
  num? get price_usd => _price_usd;
  int? get type_is_crypto => _type_is_crypto;
  String? get asset_id => _asset_id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price_usd'] = _price_usd;
    map['type_is_crypto'] = _type_is_crypto;
    map['asset_id'] = _asset_id;
    map['name'] = _name;
    return map;
  }
}
