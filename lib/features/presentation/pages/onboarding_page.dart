import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/common/gradient_background.dart';
import 'todo_list_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
        children: [
          // Background decorative blurred circles
          _buildBackgroundDecorations(),
          
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  
                  // Illustration area with decorative elements
                  SizedBox(
                    height: 280,
                    child: Stack(
                      children: [
                        // Stopwatch - Figma: left:104px, top:69px, 40x50, angle:0°
                        Positioned(
                          left: 82, // 104 - 22 (container padding)
                          top: 0, // 69 - 69 (starting offset)
                          child: Image.asset(
                            'lib/core/assets/stop_watch.png',
                            width: 40,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                        
                        // Calendar - Figma: left:276px, top:136px, 31.35x26.6, angle:-12.86°
                        Positioned(
                          left: 254, // 276 - 22
                          top: 67, // 136 - 69
                          child: Transform.rotate(
                            angle: -0.224, // -12.86 degrees in radians (negative for clockwise)
                            child: Image.asset(
                              'lib/core/assets/calender.png',
                              width: 31.348,
                              height: 26.599,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        
                        // Pie chart - Figma: left:84px, top:180px, 26x26, angle:0°
                        Positioned(
                          left: 62, // 84 - 22
                          top: 111, // 180 - 69
                          child: Image.asset(
                            'lib/core/assets/pie_chart.png',
                            width: 26,
                            height: 26,
                            fit: BoxFit.contain,
                          ),
                        ),
                        
                        // Person sitting - Figma: left:131px, top:147px, 159x184, angle:0°
                        Positioned(
                          left: 109, // 131 - 22
                          top: 78, // 147 - 69
                          child: Image.asset(
                            'lib/core/assets/person_sitting.png',
                            width: 159,
                            height: 184,
                            fit: BoxFit.contain,
                          ),
                        ),
                        
                        // Smartphone - Figma: left:245px, top:225px, 62x42, angle:-180°
                        Positioned(
                          left: 223, // 245 - 22
                          top: 156, // 225 - 69
                          child: Transform.rotate(
                            angle: -3.14159, // -180 degrees in radians
                            child: Image.asset(
                              'lib/core/assets/smartnotification.png',
                              width: 62,
                              height: 42,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        
                        // Flower vase - Figma: left:79px, top:279px, 36x52, angle:0°
                        Positioned(
                          left: 57, // 79 - 22
                          top: 210, // 279 - 69
                          child: Image.asset(
                            'lib/core/assets/flower.png',
                            width: 36,
                            height: 52,
                            fit: BoxFit.contain,
                          ),
                        ),
                        
                        // Coffee cup - Figma: left:67px, top:310px, 18x22, angle:-180°
                        Positioned(
                          left: 45, // 67 - 22
                          top: 241, // 310 - 69
                          child: Transform.rotate(
                            angle: -3.14159, // -180 degrees in radians
                            child: Image.asset(
                              'lib/core/assets/coffee.png',
                              width: 18,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        
                        // Decorative colored circles
                        _buildDecorativeElements(),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 80),
                  
                  // Title
                  Text(
                    AppStrings.taskManagement,
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 24,
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      AppStrings.productiveToolDescription,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const Spacer(flex: 1),
                  
                  // Let's Start Button with shadow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Shadow/blur effect
                      Container(
                        width: 310,
                        height: 7,
                        margin: const EdgeInsets.only(top: 47),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      
                      // Main button
                      SizedBox(
                        width: 331,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: context.read<TodoBloc>(),
                                  child: const TodoListPage(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.letsStart,
                                style: AppTextStyles.buttonLarge,
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                color: AppColors.background,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
  
  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Ellipse 1 - Blue gradient (top right)
        Positioned(
          left: 333,
          top: 232,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2555FF),
                  Color(0x402555FF),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
        
        // Ellipse 2 - Green gradient (left)
        Positioned(
          left: -15,
          top: 126,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF46F080),
                  Color(0x2646F08A),
                ],
              ),
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        ),
        
        // Ellipse 3 - Cyan gradient (left middle)
        Positioned(
          left: 76,
          top: 424,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF46BDF0),
                  Color(0x2646BDF0),
                ],
              ),
              borderRadius: BorderRadius.circular(29),
            ),
          ),
        ),
        
        // Ellipse 4 - Yellow gradient (top)
        Positioned(
          left: 263,
          top: 0,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFEDF046),
                  Color(0x26F0E946),
                ],
              ),
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        ),
        
        // Ellipse 11 - Orange gradient (bottom right)
        Positioned(
          left: 240,
          top: 767,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF0B646),
                  Color(0x26F0CB46),
                ],
              ),
              borderRadius: BorderRadius.circular(29),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDecorativeElements() {
    return Stack(
      children: [
        // Small decorative circles scattered around
        Positioned(
          left: 250,
          top: 100,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF92DEFF),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        Positioned(
          left: 202,
          top: 50,
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFFBE9FFF),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        Positioned(
          left: 138,
          top: 200,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD7E4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        Positioned(
          left: 50,
          top: 150,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFEAED2A),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        Positioned(
          left: 81,
          top: 180,
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFF7FFCAA),
              shape: BoxShape.circle,
            ),
          ),
        ),
        
        Positioned(
          left: 176,
          top: 230,
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFFA4E7F9),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

