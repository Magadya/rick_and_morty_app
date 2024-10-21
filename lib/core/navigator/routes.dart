enum RouteName {
  home,
  character,
  languageSettings;

  String get path {
    switch (this) {
      case RouteName.home:
        return '/';
      case RouteName.character:
        return '/character/:id';
      case RouteName.languageSettings:
        return '/settings/language';
    }
  }

  String get name {
    switch (this) {
      case RouteName.home:
        return 'home';
      case RouteName.character:
        return 'character';
      case RouteName.languageSettings:
        return 'languageSettings';
    }
  }
}
