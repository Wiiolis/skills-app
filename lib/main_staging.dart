import 'main.dart' as App;

void main() {
  runApp(IconsOverride(
    child: const MyApp(
      apiBaseUrl: String.fromEnvironment('API_BASE_URL',
          defaultValue: 'proxy.eu1-demo.weboscope.cloud'),
    ),
  ));
}

void main() {
  runApp(MyApp(apiBaseUrl: 'proxy.eu1-demo.weboscope.cloud'));
}
