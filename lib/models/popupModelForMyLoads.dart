class popupMenuforloads{
  final String itemText;
  final String iconImage;

  const popupMenuforloads({required this.iconImage, required this.itemText});
}


class MenuItems {
  static const itemEdit = popupMenuforloads(
      itemText: "Edit",
      iconImage: "assets/icons/edit.png"
  );
  static const itemDisable = popupMenuforloads(
      itemText: "Disable",
      iconImage: "assets/icons/disable.png"
  );
  static List<popupMenuforloads> listItem = [
    itemEdit,
    itemDisable
  ];
}