enum RouteName {
  home,
  character;

  String get path {
    switch (this) {
      case RouteName.home:
        return '/';
      case RouteName.character:
        return '/character/:id';
    }
  }

  String get name {
    switch (this) {
      case RouteName.home:
        return 'home';
      case RouteName.character:
        return 'character';
    }
  }
}