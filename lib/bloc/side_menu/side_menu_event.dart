abstract class SideMenuEvent {}

class SelectMenuItem extends SideMenuEvent {
  final int index;

  SelectMenuItem(this.index);
}