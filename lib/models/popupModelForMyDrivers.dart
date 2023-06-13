
class popupMenuforDrivers {
  final String itemText;
  final String iconImage;

  const popupMenuforDrivers({required this.iconImage, required this.itemText});
}

class menuItems {
  static const itemEdit =
      popupMenuforDrivers(itemText: "Edit", iconImage: "assets/icons/edit.png");
  static const itemDelete = popupMenuforDrivers(
      itemText: "Delete", iconImage: "assets/icons/disable.png");
  static List<popupMenuforDrivers> listItem = [itemEdit, itemDelete];
}
