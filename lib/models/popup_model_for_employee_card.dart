class PopUpMenuForEmployee{
  final String itemText;
  final String iconImage;

  const PopUpMenuForEmployee({required this.iconImage, required this.itemText});
}


class MenuItemsForEmployee {
  static const itemEdit = PopUpMenuForEmployee(
      itemText: "Edit",
      iconImage: "assets/icons/edit.png"
  );
  static const itemRemove = PopUpMenuForEmployee(
      itemText: "Remove",
      iconImage: "assets/icons/disable.png"
  );
  static List<PopUpMenuForEmployee> listItem = [
    itemEdit,
    itemRemove
  ];
}