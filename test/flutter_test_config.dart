import 'dart:async';

import 'package:alchemist/alchemist.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(enabled: false),
      platformGoldensConfig: PlatformGoldensConfig(
        platforms: {HostPlatform.current()},
        filePathResolver: (name, plataform) => './golden_images/$name.png',
      ),
    ),
    run: testMain,
  );
}
