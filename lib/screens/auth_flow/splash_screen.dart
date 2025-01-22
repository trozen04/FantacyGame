import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Utils/shared_preference.dart';
import '../Dashboard/common_tabbar.dart';
import 'Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animation
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward(); // Start the fade animation
    _delayedStart();  // Delay the splash screen actions
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _delayedStart() async {
    await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds

    // Request location permission after the delay
    await _requestLocationPermission();

    // Navigate based on the 'isdashboard' flag in SharedPreferences
    await Prefs.init();  // Ensure preferences are loaded
    bool isDashboardLoaded = Prefs.isDashboardLoaded();  // Check if dashboard is loaded

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isDashboardLoaded
              ? CommonTabbar(initialIndex: 0)  // Load the dashboard screen
              : LoginScreen(),  // Otherwise, load the login screen
        ),
      );
    }
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
