import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'connectivity_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ConnectivityStore>(create: (_) => ConnectivityStore())
      ],
      child: Consumer<ConnectivityStore>(
        builder: (context, value, _) => AppConnectivityExample(value),
      ),
    );
  }
}

class AppConnectivityExample extends StatelessWidget {
  const AppConnectivityExample(this.store, {Key? key}) : super(key: key);

  final ConnectivityStore store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaffoldMessenger(
          child: ReactionBuilder(
        builder: (BuildContext context) {
          return reaction((p0) => store.connectivityStream.value, (p0) {
            final message = ScaffoldMessenger.of(context);
            message.showSnackBar(SnackBar(
                content: Text(p0 == ConnectivityResult.none
                    ? "You are offline"
                    : "You are online")));
          }, delay: 4000);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          body: const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                'Turn your connection on/off for approximately 4 seconds to see the app respond to changes in your connection status.'),
          ),
        ),
      )),
    );
  }
}
