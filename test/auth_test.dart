import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basic_tempelate_ui_design/providers/auth_manager.dart';
import 'package:basic_tempelate_ui_design/pages/login_page.dart';
import 'package:basic_tempelate_ui_design/pages/register_page.dart';
import 'package:basic_tempelate_ui_design/pages/profile_page.dart';

void main() {
  setUp(() {
    AuthManager().logout();
  });

  test('AuthManager login, register, updateProfile and logout test', () async {
    final auth = AuthManager();
    expect(auth.isLoggedIn, isFalse);
    expect(auth.currentUser, isNull);

    // Test Login
    final loginSuccess = await auth.login(
      email: 'test@example.com',
      password: 'password123',
    );
    expect(loginSuccess, isTrue);
    expect(auth.isLoggedIn, isTrue);
    expect(auth.currentUser?.email, 'test@example.com');
    expect(auth.currentUser?.name, 'Test');

    // Test Update Profile
    auth.updateProfile(name: 'Updated Name', phone: '+1234567890');
    expect(auth.currentUser?.name, 'Updated Name');
    expect(auth.currentUser?.phone, '+1234567890');

    // Test Logout
    auth.logout();
    expect(auth.isLoggedIn, isFalse);
    expect(auth.currentUser, isNull);

    // Test Register
    final registerSuccess = await auth.register(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'secretpassword',
      phone: '+9876543210',
    );
    expect(registerSuccess, isTrue);
    expect(auth.isLoggedIn, isTrue);
    expect(auth.currentUser?.name, 'John Doe');
    expect(auth.currentUser?.email, 'john@example.com');
  });

  testWidgets('LoginPage renders and functions correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome to AppleMart'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Fill Demo Credentials'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);

    // Tap Sign In without filling form
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    // Tap Fill Demo Credentials
    await tester.tap(find.text('Fill Demo Credentials'));
    await tester.pumpAndSettle();

    // Tap Sign In with demo credentials
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(AuthManager().isLoggedIn, isTrue);
  });

  testWidgets('ProfilePage shows logged out state and then logged in state with working logout dialog',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    AuthManager().logout();

    await tester.pumpWidget(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );
    await tester.pumpAndSettle();

    // Guest state
    expect(find.text('Guest Account'), findsOneWidget);
    expect(find.text('Sign In or Create Account'), findsOneWidget);

    // Now log in
    final loginFuture = AuthManager().login(email: 'akash@example.com', password: 'password');
    await tester.pump(const Duration(milliseconds: 700));
    await loginFuture;
    await tester.pumpAndSettle();

    // Logged in state
    expect(find.text('Akash'), findsOneWidget);

    final logoutBtnFinder = find.byIcon(Icons.logout);
    await tester.ensureVisible(logoutBtnFinder);
    await tester.pump();

    await tester.tap(logoutBtnFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text('Are you sure you want to log out of AppleMart? You can always log back in anytime.'),
      findsOneWidget,
    );

    // Confirm logout in dialog
    final dialogLogoutBtn = find.widgetWithText(ElevatedButton, 'Log Out').last;
    await tester.tap(dialogLogoutBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify logged out and redirected to LoginPage
    expect(AuthManager().isLoggedIn, isFalse);
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('RegisterPage renders and functions correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: RegisterPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sign up to explore exclusive Apple deals'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Create Account'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
  });
}
