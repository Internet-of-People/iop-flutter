import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:iop_wallet/src/router.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<WalletModel>(
            create: (BuildContext context) => WalletModel()),
      ],
      child: UserApp(),
    ),
  );
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: routeWelcome,
      theme: appTheme,
      onGenerateRoute: (RouteSettings settings) => generateRoute(settings),
    );
  }
}
