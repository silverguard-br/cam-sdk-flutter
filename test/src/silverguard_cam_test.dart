import 'package:flutter_test/flutter_test.dart';
import 'package:silverguard/src/silverguard_cam.dart';

import '../mocks/mocks.dart';

void main() {
  group('SilverguardCAM', () {
    test('throws if not initialized', () {
      expect(
        () => SilverguardCAM.getRequestUrlModel(
          MockBuildContext(),
          MockRequestUrlModel(),
        ),
        throwsException,
      );
      expect(
        () => SilverguardCAM.showList(
          MockBuildContext(),
          MockRequestListUrlModel(),
        ),
        throwsException,
      );
    });

    group('About initialized', () {
      setUpAll(() {
        SilverguardCAM.init(apiKey: 'key', baseUrl: 'https://example.com');
      });

      test('init sets apiKey and baseUrl', () {
        expect(() => SilverguardCAM.getRequestUrlModel, returnsNormally);
      });

      test('singleton instance', () {
        final cam1 = SilverguardCAM.instance;
        final cam2 = SilverguardCAM.instance;
        expect(identical(cam1, cam2), isTrue);
      });
    });
  });
}
