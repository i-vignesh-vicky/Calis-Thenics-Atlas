import 'package:atlas/core/widgets/atlas_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(home: child);

void main() {
  group('AtlasPageLayout', () {
    testWidgets('renders body content', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasPageLayout(body: Text('Content'))),
      );
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders AppBar when title is provided', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasPageLayout(title: 'Workouts', body: SizedBox())),
      );
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Workouts'), findsOneWidget);
    });

    testWidgets('no AppBar when title is null', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasPageLayout(body: SizedBox())),
      );
      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('renders actions in AppBar', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasPageLayout(
          title: 'Profile',
          actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
          body: const SizedBox(),
        )),
      );
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('renders FAB when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasPageLayout(
          body: const SizedBox(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        )),
      );
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('mounts at 375px width without overflow', (tester) async {
      tester.view.physicalSize = const Size(375 * 3, 812 * 3);
      tester.view.devicePixelRatio = 3.0;
      await tester.pumpWidget(
        _wrap(const AtlasPageLayout(
          title: 'Test',
          body: Text('Atlas'),
        )),
      );
      expect(tester.takeException(), isNull);
      addTearDown(tester.view.reset);
    });
  });
}
