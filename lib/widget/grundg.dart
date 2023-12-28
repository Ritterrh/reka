import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reka/widget/sidebar/sidebar.dart';
import 'package:updater/updater.dart';

class grundg extends StatefulWidget {
  grundg({super.key, required this.body});

  late Widget body;
  @override
  State<grundg> createState() => _grundgState();
}

class _grundgState extends State<grundg> {
  dynamic version;

  late UpdaterController controller;
  late Updater updater;

  @override
  void initState() {
    super.initState();
    initializeUpdater();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar //
      appBar: GFAppBar(
        leading: Builder(
          builder: (context) => GFIconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        searchBar: true,
        title: Text("RuhrKultur Erlebnis App"),
      ),
      body: widget.body,

      drawer: const Sidebar(),
    );
  }

  void initializeUpdater() {
    controller = UpdaterController(
      listener: (UpdateStatus status) {
        debugPrint('Listener: $status');
      },
      onChecked: (bool isAvailable) {
        debugPrint('$isAvailable');
      },
      progress: (current, total) {
        debugPrint('Progress: $current -- $total');
      },
      onError: (status) {
        debugPrint('Error: $status');
      },
    );

    updater = Updater(
      context: context,
      delay: const Duration(milliseconds: 300),
      url: 'http://filmprojekt1.de/RKEA/update/version.json',
      titleText: 'Stay with time',
      backgroundDownload: true,
      allowSkip: true,
      callBack: (UpdateModel model) {
        debugPrint(model.versionName);
        debugPrint(model.versionCode.toString());
        debugPrint(model.contentText);
      },
      enableResume: true,
      controller: controller,
    );
    updater.check();
  }

  checkUpdate() async {
    bool isAvailable = await updater.check();

    debugPrint('$isAvailable');

    // controller.pause();
    // controller.resume();
  }
}
