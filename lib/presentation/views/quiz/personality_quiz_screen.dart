import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/route_names.dart';
import '../../../data/models/user_model.dart';

class PersonalityQuizScreen extends ConsumerStatefulWidget {
  const PersonalityQuizScreen({super.key});

  @override
  ConsumerState<PersonalityQuizScreen> createState() =>
      _PersonalityQuizScreenState();
}

class _PersonalityQuizScreenState extends ConsumerState<PersonalityQuizScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  int _currentQuestionIndex = 0;
  Map<int, String> _answers = {};
  bool _isSubmitting = false;

  final List<QuizQuestion> _questions = [
    QuizQuestion(
      id: 0,
      question: "What's your ideal weekend outfit?",
      options: [
        QuizOption('A', 'Comfortable jeans and a simple t-shirt'),
        QuizOption('B', 'A flowy maxi dress with accessories'),
        QuizOption('C', 'Tailored pants with a crisp button-down'),
        QuizOption('D', 'Leather jacket with distressed jeans'),
      ],
    ),
    QuizQuestion(
      id: 1,
      question: "Which color palette appeals to you most?",
      options: [
        QuizOption('A', 'Neutral tones (beige, white, gray)'),
        QuizOption('B', 'Earthy colors (terracotta, sage, cream)'),
        QuizOption('C', 'Classic colors (navy, black, white)'),
        QuizOption('D', 'Bold colors (red, purple, emerald)'),
      ],
    ),
    QuizQuestion(
      id: 2,
      question: "How do you prefer to shop for clothes?",
      options: [
        QuizOption('A', 'Quick and efficient - I know what I need'),
        QuizOption('B', 'Browse vintage and thrift stores'),
        QuizOption('C', 'Research brands and invest in quality pieces'),
        QuizOption('D', 'Follow the latest trends and try new things'),
      ],
    ),
    QuizQuestion(
      id: 3,
      question: "What's your approach to accessorizing?",
      options: [
        QuizOption('A', 'Less is more - minimal accessories'),
        QuizOption('B', 'Love layering jewelry and scarves'),
        QuizOption('C', 'Classic pieces like pearls or leather watch'),
        QuizOption('D', 'Statement pieces that make an impact'),
      ],
    ),
    QuizQuestion(
      id: 4,
      question: "Which fashion icon inspires you?",
      options: [
        QuizOption('A', 'Scandinavian influencers (clean, minimal style)'),
        QuizOption('B', 'Bohemian artists and free spirits'),
        QuizOption('C', 'Classic Hollywood stars (Audrey Hepburn)'),
        QuizOption('D', 'Modern trendsetters and street style stars'),
      ],
    ),
    QuizQuestion(
      id: 5,
      question: "How important is sustainability in fashion to you?",
      options: [
        QuizOption('A', 'Very important - I buy less but better quality'),
        QuizOption('B', 'I love vintage and second-hand finds'),
        QuizOption('C', 'I invest in timeless pieces that last'),
        QuizOption('D', 'I try to balance trends with conscious choices'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
    _updateProgress();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    final progress = (_currentQuestionIndex + 1) / _questions.length;
    _progressController.animateTo(progress);
  }

  void _selectAnswer(String optionId) {
    setState(() {
      _answers[_currentQuestionIndex] = optionId;
    });
  }

  Future<void> _nextQuestion() async {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _animationController.reset();
      _animationController.forward();
      _updateProgress();
    } else {
      await _submitQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _animationController.reset();
      _animationController.forward();
      _updateProgress();
    }
  }

  Future<void> _submitQuiz() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      // Calculate fashion archetype based on answers
      final archetype = _calculateArchetype();

      // Update user profile with archetype
      await ref.read(authProvider.notifier).updateUserProfile(
            fashionArchetype: FashionArchetype(
              type: archetype,
              confidence: 0.85, // Mock confidence score
              description: _getArchetypeDescription(archetype),
              characteristics: _getArchetypeCharacteristics(archetype),
            ),
            isOnboardingComplete: true,
          );

      // Navigate to dashboard
      if (mounted) {
        context.go(RouteNames.dashboard);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting quiz: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  ArchetypeType _calculateArchetype() {
    // Simple logic to determine archetype based on most common answers
    final answerCounts = <String, int>{};

    for (final answer in _answers.values) {
      answerCounts[answer] = (answerCounts[answer] ?? 0) + 1;
    }

    final mostCommonAnswer =
        answerCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    switch (mostCommonAnswer) {
      case 'A':
        return ArchetypeType.minimalist;
      case 'B':
        return ArchetypeType.bohemian;
      case 'C':
        return ArchetypeType.classic;
      case 'D':
        return ArchetypeType.streetwear;
      default:
        return ArchetypeType.casual;
    }
  }

  String _getArchetypeDescription(ArchetypeType type) {
    return type.description;
  }

  List<String> _getArchetypeCharacteristics(ArchetypeType type) {
    switch (type) {
      case ArchetypeType.minimalist:
        return [
          'Clean lines',
          'Neutral colors',
          'Quality over quantity',
          'Timeless pieces'
        ];
      case ArchetypeType.bohemian:
        return [
          'Flowy fabrics',
          'Layered accessories',
          'Earthy tones',
          'Vintage finds'
        ];
      case ArchetypeType.classic:
        return [
          'Tailored fits',
          'Investment pieces',
          'Sophisticated style',
          'Traditional colors'
        ];
      case ArchetypeType.streetwear:
        return [
          'Trend-focused',
          'Bold statements',
          'Urban influence',
          'Contemporary style'
        ];
      default:
        return ['Comfortable', 'Versatile', 'Practical', 'Relaxed'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final selectedAnswer = _answers[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Progress bar
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: AppColors.overlay20,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.accentCoral,
                        ),
                        minHeight: 6,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Skip quiz and go to dashboard
                          context.go(RouteNames.dashboard);
                        },
                        child: Text(
                          'Skip',
                          style: GoogleFonts.dmSans(
                            color: AppColors.accentCoral,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Question content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: AppColors.cardGradient,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.overlay10,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: AppColors.accentCoral,
                                size: 32,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentQuestion.question,
                                style: GoogleFonts.dmSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Options
                        Expanded(
                          child: ListView.builder(
                            itemCount: currentQuestion.options.length,
                            itemBuilder: (context, index) {
                              final option = currentQuestion.options[index];
                              final isSelected = selectedAnswer == option.id;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => _selectAnswer(option.id),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.accentCoral
                                              .withOpacity(0.1)
                                          : AppColors.cardBackground,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.accentCoral
                                            : AppColors.overlay10,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.accentCoral
                                                : AppColors.surfaceColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              option.id,
                                              style: GoogleFonts.dmSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: isSelected
                                                    ? AppColors.white
                                                    : AppColors.primaryText,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            option.text,
                                            style: GoogleFonts.dmSans(
                                              fontSize: 16,
                                              color: AppColors.primaryText,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          Icon(
                                            Icons.check_circle,
                                            color: AppColors.accentCoral,
                                            size: 24,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentQuestionIndex > 0)
                    Expanded(
                      child: CustomButton(
                        label: 'Previous',
                        onPressed: _previousQuestion,
                        variant: ButtonVariant.outline,
                      ),
                    ),
                  if (_currentQuestionIndex > 0) const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      label: _currentQuestionIndex == _questions.length - 1
                          ? 'Complete Quiz'
                          : 'Next',
                      onPressed: selectedAnswer != null ? _nextQuestion : null,
                      isLoading: _isSubmitting,
                      icon: _currentQuestionIndex == _questions.length - 1
                          ? const Icon(Icons.check, size: 20)
                          : const Icon(Icons.arrow_forward, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizQuestion {
  final int id;
  final String question;
  final List<QuizOption> options;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
  });
}

class QuizOption {
  final String id;
  final String text;

  QuizOption(this.id, this.text);
}
