import 'package:flutter/material.dart';

import '../../core/config/app_colors.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/page_title.dart';
import '../../core/widgets/svg_widget.dart';
import 'notifications_page.dart';
import 'privacy_page.dart';
import 'terms_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageTitle(
          title: 'Settings',
          back: false,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 83,
            ),
            children: [
              _SettingsTile(
                id: 1,
                title: 'Notifications',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const NotificationsPage();
                      },
                    ),
                  );
                },
              ),
              const _Divider(),
              _SettingsTile(
                id: 2,
                title: 'Privacy Policy',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const PrivacyPage();
                      },
                    ),
                  );
                },
              ),
              const _Divider(),
              _SettingsTile(
                id: 3,
                title: 'Terms of Use',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const TermsPage();
                      },
                    ),
                  );
                },
              ),
              const _Divider(),
              _SettingsTile(
                id: 4,
                title: 'Rate Us',
                onPressed: () {},
              ),
              const _Divider(),
              _SettingsTile(
                id: 5,
                title: 'Clear Data',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.id,
    required this.title,
    required this.onPressed,
  });

  final int id;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            const SizedBox(width: 16),
            SvgWidget('assets/set/set$id.svg'),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      color: AppColors.tertiary1,
    );
  }
}
