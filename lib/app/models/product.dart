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
    id = json['id'].toString();
    name = json['name'].toString();
    slug = json['slug'].toString();
    description = json['description'].toString();
    type = json['type'].toString();
    model = json['model'].toString();
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
    while (description != null && description!.contains("  ")) {
      description!.trim().replaceAll("  ", ' ');
    }
    return description;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, slug: $slug, description: $description, type: $type, model: $model}';
  }

  static List<Product> listFromJson(List<dynamic> data) {
    return data.map<Product>((e) => Product.fromJson(e)).toList();
  }
}
