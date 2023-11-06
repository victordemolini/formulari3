import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('renders FastFormSection', (WidgetTester tester) async {
    const header = Text('Test Form Section');

    await tester.pumpWidget(buildMaterialTestApp(
      const FastFormSection(
        header: header,
        children: [
          FastTextField(name: 'text_field'),
        ],
      ),
    ));

    expect(find.byType(FastFormSection), findsOneWidget);
    expect(find.byWidget(header), findsOneWidget);
    expect(find.byType(FastTextField), findsOneWidget);
  });

  testWidgets('renders FastFormSection horizontally',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMaterialTestApp(
      const FastFormSection(
        orientation: FastFormSectionOrientation.horizontal,
        children: [
          FastTextField(name: 'text_field'),
        ],
      ),
    ));

    expect(find.byType(FastFormSection), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(FastTextField), findsOneWidget);
  });

  testWidgets('renders CupertinoFormSection', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    const header = Text('Test Form Section');

    await tester.pumpWidget(buildMaterialTestApp(
      const FastFormSection(
        adaptive: true,
        header: header,
        children: [
          FastTextField(name: 'text_field'),
        ],
      ),
    ));

    expect(find.byType(CupertinoFormSection), findsOneWidget);
    expect(find.byWidget(header), findsOneWidget);
    expect(find.byType(FastTextField), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('renders CupertinoFormSection.insetGrouped',
      (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await tester.pumpWidget(buildMaterialTestApp(
      const FastFormSection(
        adaptive: true,
        insetGrouped: true,
        children: [
          FastTextField(name: 'text_field'),
        ],
      ),
    ));

    expect(find.byType(CupertinoFormSection), findsOneWidget);
    expect(find.byType(FastTextField), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
