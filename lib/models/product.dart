class Product {
  final String id, title, description, imageUrl;
  final double price;
  final bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.isFavorite = false});
}
