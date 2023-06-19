import 'package:flutter_contact/main.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('Test My App', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());
    expect(find.byType(ListKontakPage), findsOneWidget);
  });
}