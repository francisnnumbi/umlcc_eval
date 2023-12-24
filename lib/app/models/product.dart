class Product {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? type;
  String? model;

  Product({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.type,
    this.model,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'].toString() : "";
    name = json['name'] != null ? json['name'].toString() : "";
    slug = json['slug'] != null ? json['slug'].toString() : "";
    description =
        json['description'] != null ? json['description'].toString() : "";
    type = json['type'] != null ? json['type'].toString() : "";
    model = json['model'] != null ? json['model'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['type'] = type;
    data['model'] = model;
    return data;
  }

  formatDescription() {
    return description!.replaceAll(RegExp(r"\s+"), ' ');
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, slug: $slug, description: $description, type: $type, model: $model}';
  }

  static List<Product> listFromJson(List<dynamic> data) {
    return data.map<Product>((e) => Product.fromJson(e)).toList();
  }
}
