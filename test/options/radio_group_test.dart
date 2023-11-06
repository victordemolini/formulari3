import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('renders FastRadioGroup widget', (WidgetTester tester) async {
    const options = [
      FastRadioOption(title: Text('Option 1'), value: 'option-1'),
      FastRadioOption(title: Text('Option 2'), value: 'option-2'),
    ];

    await tester.pumpWidget(buildMaterialTestApp(
      FastRadioGroup<String>(name: 'radio_group', options: options),
    ));

    final fastRadioGroupFinder = find.byType(typeOf<FastRadioGroup<String>>());
    final widget =
        tester.widget(fastRadioGroupFinder) as FastRadioGroup<String>;

    expect(fastRadioGroupFinder, findsOneWidget);

    expect(options.length, widget.options.length);
    expect(find.byType(typeOf<RadioListTile<String>>()),
        findsNWidgets(options.length));
  });

  testWidgets('renders FastRadioGroup widget horizontally',
      (WidgetTester tester) async {
    const options = [
      FastRadioOption(title: Text('Option 1'), value: 'option-1'),
      FastRadioOption(title: Text('Option 2'), value: 'option-2'),
    ];

    await tester.pumpWidget(buildMaterialTestApp(
      FastRadioGroup<String>(
        name: 'radio_group',
        options: options,
        orientation: FastRadioGroupOrientation.horizontal,
      ),
    ));

    expect(find.byType(Expanded), findsNWidgets(options.length));
    expect(find.byType(typeOf<RadioListTile<String>>()),
        findsNWidgets(options.length));
  });

  testWidgets('updates FastRadioGroup value', (WidgetTester tester) async {
    const options = [
      FastRadioOption(title: Text('Option 1'), value: 'option-1'),
      FastRadioOption(title: Text('Option 2'), value: 'option-2'),
    ];
    final spy = OnChangedSpy<String>();

    await tester.pumpWidget(buildMaterialTestApp(
      FastRadioGroup<String>(
        name: 'radio_group',
        options: options,
        onChanged: spy.fn,
      ),
    ));

    final state = tester.state(find.byType(typeOf<FastRadioGroup<String>>()))
        as FastRadioGroupState<String>;
    expect(state.value, options.first.value);

    await tester.tap(find.byType(typeOf<RadioListTile<String>>()).last);
    await tester.pumpAndSettle();

    final testValue = options.last.value;

    expect(spy.calledWith, testValue);
    expect(state.value, testValue);
  });

  testWidgets('validates FastRadioGroup', (WidgetTester tester) async {
    const errorText = 'Do not touch this';
    const invalidOption =
        FastRadioOption(title: Text('Invalid Option'), value: 'invalid-option');
    final options = [
      const FastRadioOption(title: Text('Option 1'), value: 'option-1'),
      invalidOption,
    ];

    await tester.pumpWidget(buildMaterialTestApp(
      FastRadioGroup<String>(
        name: 'radio_group',
        options: options,
        validator: (value) => value == invalidOption.value ? errorText : null,
      ),
    ));

    final state = tester.state(find.byType(typeOf<FastRadioGroup<String>>()))
        as FastRadioGroupState<String>;

    final errorTextFinder = find.text(errorText);
    expect(errorTextFinder, findsNothing);

    state.didChange(invalidOption.value);
    await tester.pumpAndSettle();

    expect(errorTextFinder, findsOneWidget);
  });
}
