import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/services/i18n/locale_key.g.dart';
import '../../domain/entities/language_entity.dart';
import '../stores/language_store.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  late final LanguageStore _store;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _store = getIt.get<LanguageStore>(param1: context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _store.init();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go('/'),
        ),
        centerTitle: true,
        title: Text(
          LocaleKey.settingsPagePageTitle.tr(),
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // English Option
                Card(
                  child: ListTile(
                    title: const Text('English'),
                    trailing: _store.isEnglish ? const Icon(Icons.check, color: Colors.green) : null,
                    onTap: () => _store.setLanguage(
                      const LanguageEntity(
                        code: 'en',
                        name: 'English',
                        countryCode: 'US',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Russian Option
                Card(
                  child: ListTile(
                    title: const Text('Русский'),
                    trailing: _store.isRussian ? const Icon(Icons.check, color: Colors.green) : null,
                    onTap: () => _store.setLanguage(
                      const LanguageEntity(
                        code: 'ru',
                        name: 'Русский',
                        countryCode: 'RU',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
