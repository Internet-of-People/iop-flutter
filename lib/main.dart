import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/models/wallet.dart';
import 'package:iop_wallet/src/router.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletModel>(create: (context) => WalletModel()),
        ChangeNotifierProvider<SettingsModel>(
            create: (context) => SettingsModel())
      ],
      child: UserApp(),
    ),
  );
}

class UserApp extends StatefulWidget {
  @override
  State createState() => UserAppState();
}

class UserAppState extends State<UserApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: routeWelcome,
      theme: appTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
