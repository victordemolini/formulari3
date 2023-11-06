import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('renders Material FastSlider', (WidgetTester tester) async {
    await tester.pumpWidget(buildMaterialTestApp(
      FastSlider(
        name: 'slider',
        labelBuilder: sliderLabelBuilder,
        prefixBuilder: (state) => const Icon(Icons.volume_up),
        suffixBuilder: sliderSuffixBuilder,
      ),
    ));

    final fastSliderFinder = find.byType(FastSlider);
    final sliderFinder = find.byType(Slider);

    expect(fastSliderFinder, findsOneWidget);
    expect(sliderFinder, findsOneWidget);

    final widget = tester.widget(fastSliderFinder) as FastSlider;

    final prefixFinder = find.byIcon(Icons.volume_up);
    final suffixFinder = find.text(widget.initialValue!.toStringAsFixed(0));

    expect(prefixFinder, findsOneWidget);
    expect(suffixFinder, findsOneWidget);
  });

  testWidgets('renders Cupertino FastSlider', (WidgetTester tester) async {
    await tester.pumpWidget(buildMaterialTestApp(
      FastSlider(
        name: 'slider',
        builder: cupertinoSliderBuilder,
        labelBuilder: sliderLabelBuilder,
        prefixBuilder: (state) => const Icon(Icons.volume_up),
        suffixBuilder: sliderSuffixBuilder,
      ),
    ));

    final fastSliderFinder = find.byType(FastSlider);
    final sliderFinder = find.byType(CupertinoSlider);

    expect(fastSliderFinder, findsOneWidget);
    expect(sliderFinder, findsOneWidget);

    final widget = tester.widget(fastSliderFinder) as FastSlider;

    final prefixFinder = find.byIcon(Icons.volume_up);
    final suffixFinder = find.text(widget.initialValue!.toStringAsFixed(0));

    expect(prefixFinder, findsOneWidget);
    expect(suffixFinder, findsOneWidget);
  });

  testWidgets('updates FastSlider', (WidgetTester tester) async {
    final spy = OnChangedSpy<double>();

    await tester.pumpWidget(buildMaterialTestApp(
      FastSlider(
        name: 'slider',
        suffixBuilder: sliderSuffixBuilder,
        onChanged: spy.fn,
      ),
    ));

    final state = tester.state(find.byType(FastSlider)) as FastSliderState;
    final testValue = state.widget.max;

    state.didChange(testValue);
    await tester.pumpAndSettle();

    expect(spy.calledWith, testValue);
    expect(find.text(testValue.toStringAsFixed(0)), findsOneWidget);
  });

  testWidgets('validates FastSlider', (WidgetTester tester) async {
    const errorText = 'Value is too high';

    await tester.pumpWidget(buildMaterialTestApp(
      FastSlider(
        name: 'slider',
        validator: (value) => value! > 0 ? errorText : null,
      ),
    ));

    final state = tester.state(find.byType(FastSlider)) as FastSliderState;

    final errorTextFinder = find.text(errorText);
    expect(errorTextFinder, findsNothing);

    state.didChange(state.widget.max);
    await tester.pumpAndSettle();

    expect(errorTextFinder, findsOneWidget);
  });

  testWidgets('adapts FastSlider to Android', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    await tester.pumpWidget(buildMaterialTestApp(
      const FastSlider(name: 'slider', adaptive: true),
    ));

    expect(find.byType(Slider), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('adapts FastSlider to iOS', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await tester.pumpWidget(buildMaterialTestApp(
      const FastSlider(name: 'slider', adaptive: true),
    ));

    expect(find.byType(CupertinoFormRow), findsOneWidget);
    expect(find.byType(CupertinoSlider), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });
}
