class Category {
  int id;
  String? name;
  String? image;
  bool isSelected;

  Category({
    required  this.id,
    this.name,
    this.image,
    this.isSelected = false
  });
}