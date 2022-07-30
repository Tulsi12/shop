// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/Bloc/Auth/auth_bloc.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Screen/Login/LoginPage.dart';


Widget createWidgetForTesting({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),

      BlocProvider(create: (context) => UserBloc()),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop - Sell',
      home: LoginPage(),
    ),
  );

}

void main() {
  testWidgets('Test Login screen design', (WidgetTester tester) async {
    // Build login screen
    await tester.pumpWidget(createWidgetForTesting(child: new LoginPage()));
    await tester.pumpAndSettle();

    // Then i should see login text
    expect(find.text('Welcome back!'), findsOneWidget);

    //Then i should see email text field
    Finder emailField = find.widgetWithText(TextField, "email@aweclick.com");
    await tester.ensureVisible(emailField);
    await tester.pumpAndSettle();
    expect(emailField, findsOneWidget);

    //Then i should see passwordText
    Finder passwordField = find.widgetWithText(TextField, "********");
    expect(passwordField, findsOneWidget);

    // And a signin button
    Finder signInButton = find.widgetWithText(TextButton, "Login");
    await tester.ensureVisible(signInButton);
    await tester.pumpAndSettle();
    expect(signInButton, findsOneWidget);
  });

  testWidgets('Check for login screen validation', (WidgetTester tester) async {
    // Build login screen
    await tester.pumpWidget(createWidgetForTesting(child: new LoginPage()));
    await tester.pumpAndSettle();

    // Then i should see login text
    expect(find.text('Welcome back!'), findsOneWidget);

    //Then i should see email text field
    Finder emailField = find.widgetWithText(TextField, "email@aweclick.com");
    await tester.ensureVisible(emailField);
    await tester.pumpAndSettle();
    expect(emailField, findsOneWidget);

    //Then i should see passwordText
    Finder passwordField = find.widgetWithText(TextField, "********");
    expect(passwordField, findsOneWidget);

    // And a signin button
    Finder signInButton = find.widgetWithText(TextButton, "Login");
    await tester.ensureVisible(signInButton);
    await tester.pumpAndSettle();
    expect(signInButton, findsOneWidget);

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.text("Email ID is required"), findsOneWidget);
    expect(find.text("Password is required"), findsOneWidget);
  });

  testWidgets('Check for login when user inputs email',
          (WidgetTester tester) async {
            // Build login screen
            await tester.pumpWidget(createWidgetForTesting(child: new LoginPage()));
            await tester.pumpAndSettle();

            // Then i should see login text
            expect(find.text('Welcome back!'), findsOneWidget);

            //Then i should see email text field
            Finder emailField = find.widgetWithText(TextField, "email@aweclick.com");
            await tester.ensureVisible(emailField);
            await tester.pumpAndSettle();
            expect(emailField, findsOneWidget);

            //Then i should see passwordText
            Finder passwordField = find.widgetWithText(TextField, "********");
            expect(passwordField, findsOneWidget);

            // And a signin button
            Finder signInButton = find.widgetWithText(TextButton, "Login");
            await tester.ensureVisible(signInButton);
            await tester.pumpAndSettle();
            expect(signInButton, findsOneWidget);

            await tester.tap(signInButton);
            await tester.pumpAndSettle();

            expect(find.text("Email ID is required"), findsOneWidget);
            expect(find.text("Password is required"), findsOneWidget);

        //when i type email
        await tester.enterText(emailField, 'asmi@gmail.com');
        //And enter submit button

            await tester.ensureVisible(signInButton);
            await tester.pumpAndSettle();

            await tester.tap(signInButton);

        await tester.pumpAndSettle();

        //Then email address field validation should be gone
        expect(find.text("Email ID is required"), findsNothing);
      });

  testWidgets('Check for login when user inputs password',
          (WidgetTester tester) async {
            // Build login screen
            await tester.pumpWidget(createWidgetForTesting(child: new LoginPage()));
            await tester.pumpAndSettle();

            // Then i should see login text
            expect(find.text('Welcome back!'), findsOneWidget);

            //Then i should see email text field
            Finder emailField = find.widgetWithText(TextField, "email@aweclick.com");
            await tester.ensureVisible(emailField);
            await tester.pumpAndSettle();
            expect(emailField, findsOneWidget);

            //Then i should see passwordText
            Finder passwordField = find.widgetWithText(TextField, "********");
            expect(passwordField, findsOneWidget);

            // And a signin button
            Finder signInButton = find.widgetWithText(TextButton, "Login");
            await tester.ensureVisible(signInButton);
            await tester.pumpAndSettle();
            expect(signInButton, findsOneWidget);

            await tester.tap(signInButton);
            await tester.pumpAndSettle();

            expect(find.text("Email ID is required"), findsOneWidget);
            expect(find.text("Password is required"), findsOneWidget);

        //when i type password
        await tester.enterText(passwordField, 'password');
        //And enter submit button
            await tester.ensureVisible(signInButton);
            await tester.pumpAndSettle();
        await tester.tap(signInButton);

        await tester.pumpAndSettle();

        //Then password field validation should be gone
        expect(find.text("Password is required"), findsNothing);
      });



  testWidgets('Test Register screen design', (WidgetTester tester) async {
    // Build login screen
    await tester.pumpWidget(createWidgetForTesting(child: new LoginPage()));
    await tester.pumpAndSettle();
    Finder forgotPassword = find.text('Forgot Password?');
       expect(forgotPassword,findsOneWidget);

    });

}
