import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guitarshop/components/layout.dart';
import 'package:guitarshop/screen/aboutsection.dart';
import 'package:guitarshop/screen/blogscreen.dart';
import 'package:guitarshop/screen/categoryguitarscreen.dart';
import 'package:guitarshop/screen/loginscreen.dart';
import 'package:guitarshop/screen/profilescreen.dart';
import 'package:guitarshop/screen/registerscreen.dart';
import 'package:guitarshop/screen/singleguitar.dart';
import 'package:guitarshop/screen/wear_os_screen/showcart.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Register User", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      // theme: ThemeData(
      //   primaryColor: const Color.fromARGB(255, 234, 98, 7),
      //   primarySwatch: Colors.red,
      //   fontFamily: 'Poppins',
      // ),
      routes: {
        '/loginScreen': (context) => const LoginScreen(),
      },
      home: const RegisterScreen(),
    ));
    Finder fullName = find.byKey(const ValueKey('full_name'));
    await tester.enterText(fullName, 'Rijwol Shakya');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder contactNo = find.byKey(const ValueKey('contact_no'));
    await tester.enterText(contactNo, '9861291534');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder username = find.byKey(const ValueKey('username'));
    await tester.enterText(username, 'rijwolshakya999');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder email = find.byKey(const ValueKey('email'));
    await tester.enterText(email, 'shakyarijwol@gmail.com');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder password = find.byKey(const ValueKey('password'));
    await tester.enterText(password, 'shakyarijwol09');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // FocusManager.instance.primaryFocus?.unfocus();
    // await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder signUpBtn = find.byKey(const ValueKey('signUpBtn'));
    await tester.tap(signUpBtn);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('signUpBtn')), findsOneWidget);
  });

  testWidgets('Login Integration test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/layout': (context) => const LayoutScreen(),
        },
        home: const LoginScreen(),
      ),
    );
    Finder textUsername = find.byKey(const ValueKey('username'));
    await tester.enterText(textUsername, 'naruto09');
    Finder textPassword = find.byKey(const ValueKey('password'));
    await tester.enterText(textPassword, 'uzumaki09');
    Finder btnLogin = find.byKey(const ValueKey('loginBtn'));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byKey(const ValueKey("navbar")), findsOneWidget);
  });

  testWidgets("Check Blogs", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BlogScreenState(),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text("Blogs"), findsOneWidget);
  });

  testWidgets("Check Guitars", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CategoryGuitarScreenState(),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text("Guitars"), findsOneWidget);
  });

  testWidgets("Check Profile", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text("Profile Details"), findsOneWidget);
  });

  testWidgets("Add To Cart", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          "/singleguitar": (context) => const SingleGuitarScreen(),
          "/addtocart": (context) => const ShowCart(),
        },
        home: const CategoryGuitarScreenState(),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder btnSingle = find.byKey(const ValueKey("singleguitar1"));
    await tester.tap(btnSingle);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder btnCart = find.byKey(const ValueKey("addtocart"));
    await tester.tap(btnCart);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(const ValueKey("addtocarttitle")), findsOneWidget);
  });

  testWidgets("About Us Page", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          "/aboutus": (context) => const AboutSection(),
          // "/showblogs": (context) => const AboutSection(),
        },
        home: const LayoutScreen(),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder btnDrawer = find.byKey(const ValueKey("opendrawer"));
    await tester.tap(btnDrawer);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder btnAbout = find.byKey(const ValueKey("aboutusbtn"));
    await tester.tap(btnAbout);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(const ValueKey("aboutuspage")), findsOneWidget);
  });

  // testWidgets("Order Cancel", (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     const MaterialApp(
  //       // routes: {
  //       //   "/showblog": (context) => const BlogScreenState(),
  //       //   // "/showblogs": (context) => const AboutSection(),
  //       // },
  //       home: BlogScreenState(),
  //     ),
  //   );
  //   await tester.pumpAndSettle(const Duration(seconds: 2));
  //   expect(find.text("Blogs"), findsOneWidget);
  // });
}
