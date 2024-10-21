# Rick and Morty Character Explorer

A Flutter app for exploring Rick and Morty characters.

## Setup

1. Ensure Flutter 3.16.8+ is installed
2. Clone repo: `git clone https://github.com/your-username/rick_and_morty_app.git`
3. Install dependencies: `flutter pub get`
4. Run: `flutter run`

## Features

- Character list and details
- Favorite characters
- Localization support

## Project Structure

- `core/`: Base components (API, error handling, storage, DI)
- `features/`: Functional modules (characters)
- `config/`: App configuration (routing, theme)

## Localization

Use these scripts for localization:

```
dart scripts/i18n/localization_translate.dart -s assets/translations/source.csv
dart scripts/i18n/localization_csv_format.dart -s assets/translations/source.csv
dart scripts/i18n/localization_keys.dart -s assets/translations/en-US.json -o lib/services/i18n/locale_key.g.dart
dart scripts/i18n/localization_jsons.dart -s assets/translations/source.csv -o assets/translations
```

### Google Cloud Translation

For automated translation using Google Cloud:

1. Set up a Google Cloud project and enable the Translation API.
2. Create a service account and download the JSON key file.
3. Rename the key file to `google_api_key.json` and place it in the project root.
4. Use this template for the key file:

```json
{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": "",
  "universe_domain": ""
}
```

Note: Keep `google_api_key.json` in `.gitignore` to protect your credentials.

## Main Dependencies

- State Management: MobX
- DI: get_it
- Networking: dio
- Routing: go_router
- Localization: easy_localization

## Development

Generate code: `flutter pub run build_runner build --delete-conflicting-outputs`

## License

MIT License