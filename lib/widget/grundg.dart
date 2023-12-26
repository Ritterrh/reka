import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:reka/constants/assets.dart';
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

  final _controller = SidebarXController(selectedIndex: 0, extended: true);

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

      drawer: SidebarX(
        controller: _controller,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 44, 163, 231),
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(color: Colors.white),
          selectedTextStyle: const TextStyle(color: Colors.white),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(0, 68, 137, 255)),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(0, 0, 0, 0),
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(253, 0, 12, 175),
                Color.fromARGB(255, 0, 125, 241)
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.0),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 13, 174, 238),
          ),
          margin: EdgeInsets.only(right: 10),
        ),
        headerBuilder: (context, extended) {
          return SafeArea(
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(Assets.resourceImageAppSplash),
              ),
            ),
          );
        },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              context.go("/");
              _controller.selectIndex(1);
            },
          ),
          SidebarXItem(
            icon: Icons.audiotrack,
            label: 'Audio Guid',
            onTap: () {
              context.go("/audioguid");
              _controller.selectIndex(2);
            },
          ),
        ],
        footerItems: [
          SidebarXItem(
            icon: Icons.settings,
            label: "Settings",
            onTap: () => context.go("/settings"),
          )
        ],
      ),
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
