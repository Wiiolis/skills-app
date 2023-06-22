import 'main.dart' as App;

void main() {
  runApp(IconsOverride(
    child: const MyApp(
      apiBaseUrl: String.fromEnvironment('API_BASE_URL',
          defaultValue: 'https://gamma.staging.candena.de'),
    ),
  ));
}

void main() {
  runApp(MyApp(apiBaseUrl: 'https://gamma.staging.candena.de'));
}
