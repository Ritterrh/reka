import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reka/constants/assets.dart';
import 'package:reka/widget/grundg.dart';
import 'package:about/about.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;
  @override
  void initState() {
    super.initState();
    appinfo();
  }

  Future appinfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return grundgerst(context);
  }

  grundg grundgerst(BuildContext context) {
    return grundg(
      body: Container(
        child: ListView(
          children: [
            _SingleSection(
              title: "General",
              children: [
                _CustomListTile(
                    title: "App info",
                    icon: CupertinoIcons.device_phone_portrait,
                    onTap: () {
                      showAboutPage(
                        context: context,
                        values: {
                          'version': version,
                          'year': DateTime.now().year.toString(),
                        },
                        applicationName: appName,
                        applicationVersion: version,
                        applicationLegalese:
                            'Copyright © David PHAM-VAN, {{ year }}',
                        applicationDescription: const Text(
                            'Displays an About dialog, which describes the application.'),
                        children: const <Widget>[
                          MarkdownPageListTile(
                            icon: Icon(Icons.list),
                            title: Text('Changelog'),
                            filename: Assets.resourceCHANGELOG,
                          ),
                          LicensesPageListTile(
                            icon: Icon(Icons.favorite),
                          ),
                        ],
                        applicationIcon: const SizedBox(
                          width: 100,
                          height: 100,
                          child: Image(
                            image: AssetImage(Assets.resourceImageSplash),
                          ),
                        ),
                      );
                    }),
                _CustomListTile(
                    title: "App Pacht Notes",
                    icon: CupertinoIcons.news,
                    onTap: () {
                      context.go("/pachtnotes");
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? onTap;

  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
