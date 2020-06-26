part of 'spincircle_bottom_bar.dart';

class SCBottomBarDetails {
  final TabController tabController;
  Color backgroundColor;
  double elevation;
  List<Color> circleColors;
  IconThemeData activeIconTheme;
  IconThemeData iconTheme;
  TextStyle activeTitleStyle;
  TextStyle titleStyle;
  List<SCBottomBarItem> items;
  List<SCItem> circleItems;
  SCActionButtonDetails actionButtonDetails;
  double bnbHeight;

  SCBottomBarDetails(this.tabController, 
      {@required this.items,
      @required this.circleItems,
      this.bnbHeight,
      this.actionButtonDetails,
      this.activeIconTheme,
      this.iconTheme,
      this.activeTitleStyle,
      this.titleStyle,
      this.circleColors,
      this.backgroundColor,
      this.elevation});
}

class SCActionButtonDetails {
  Color color;
  Icon icon;
  double elevation;

  SCActionButtonDetails(
      {@required this.color, @required this.icon, @required this.elevation});
}

class SCItem {
  Icon icon;
  Function onPressed;
  SCItem({@required this.icon, @required this.onPressed});
}

class SCBottomBarItem {
  String svgActiveIcon;
  String svgIcon;
  String title;
  Function onPressed;

  SCBottomBarItem(
      {this.svgActiveIcon,
      @required this.svgIcon,
      this.title,
      @required this.onPressed});
}
