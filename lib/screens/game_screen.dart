import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/quiz_item.dart';
import '../theme/app_theme.dart';
import '../widgets/item_card.dart';
import '../widgets/feedback_modal.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  final String category;

  const GameScreen({super.key, this.category = 'Kemandirian Diri'});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<QuizItem> _questions;
  late PageController _pageController;
  int _currentQuestionIndex = 0;

  // Track state per question
  late List<Set<String>> _selectedItemsPerQuestion;
  late List<bool> _answeredPerQuestion;
  late List<bool> _correctPerQuestion;
  int _stars = 0;

  bool _showFeedback = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _questions = List.from(quizData); // Use all questions in order
    _pageController = PageController();

    // Initialize per-question state
    _selectedItemsPerQuestion = List.generate(_questions.length, (_) => {});
    _answeredPerQuestion = List.generate(_questions.length, (_) => false);
    _correctPerQuestion = List.generate(_questions.length, (_) => false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  QuizItem get _currentQuestion => _questions[_currentQuestionIndex];
  Set<String> get _selectedItems =>
      _selectedItemsPerQuestion[_currentQuestionIndex];

  void _onItemTap(String itemId) {
    if (_answeredPerQuestion[_currentQuestionIndex]) return;

    setState(() {
      if (_selectedItems.contains(itemId)) {
        _selectedItems.remove(itemId);
      } else {
        // For single selection, clear previous selection
        if (_currentQuestion.correctItems.length == 1) {
          _selectedItems.clear();
        }
        _selectedItems.add(itemId);
      }
    });
  }

  void _checkAnswer() {
    final correctSet = Set<String>.from(_currentQuestion.correctItems);
    final isCorrect =
        _selectedItems.length == correctSet.length &&
        _selectedItems.every((item) => correctSet.contains(item));

    setState(() {
      _showFeedback = true;
      _isCorrect = isCorrect;
      _answeredPerQuestion[_currentQuestionIndex] = true;
      _correctPerQuestion[_currentQuestionIndex] = isCorrect;
      if (isCorrect) {
        _stars++;
      }
    });
  }

  void _onFeedbackContinue() {
    setState(() {
      _showFeedback = false;
    });

    // Check if all questions answered
    if (_answeredPerQuestion.every((answered) => answered)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(stars: _stars, totalQuestions: _questions.length),
        ),
      );
    } else if (_currentQuestionIndex < _questions.length - 1) {
      // Auto-advance to next unanswered question
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentQuestionIndex = index;
      _showFeedback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Aku Bisa Merawat Diriku',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          // Home button
          GestureDetector(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/icons/HomeButton.png',
                width: 24,
                height: 24,
                color: Colors.white,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.home, color: Colors.white, size: 24);
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Swipeable PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              return _buildQuestionPage(index);
            },
          ),

          // Feedback modal overlay
          if (_showFeedback)
            FeedbackModal(
              isCorrect: _isCorrect,
              instruction: _currentQuestion.instruction,
              category: _currentQuestion.category,
              onContinue: _onFeedbackContinue,
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    final question = _questions[index];
    final selectedItems = _selectedItemsPerQuestion[index];
    final isAnswered = _answeredPerQuestion[index];
    final isCorrect = _correctPerQuestion[index];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Category label and question number
            Row(
              children: [
                Text(
                  widget.category,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const Spacer(),
                Text(
                  'SOAL ${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Blue instruction card with yellow circle
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7DD3FC), Color(0xFF38BDF8)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightBlue.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Yellow circle with image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.yellowCircle,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.yellowCircle.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          question.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: Colors.white70,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Instruction text
                  Text(
                    question.instruction,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Item selection grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: question.allItems.map((itemId) {
                  final item = GameItems.getById(itemId);
                  final itemIsCorrect = question.correctItems.contains(itemId);
                  return ItemCard(
                    item: item,
                    isSelected: selectedItems.contains(itemId),
                    isCorrect: itemIsCorrect,
                    showResult: isAnswered,
                    onTap: () => _onItemTap(itemId),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // Question helper text and progress (matching Figma)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4FC), // Light blue background
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Helper text
                  Text(
                    'Alat apa yang digunakan untuk ${question.category}?',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Progress counter
                  Text(
                    '${index + 1}/${_questions.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Orange progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (index + 1) / _questions.length,
                      backgroundColor: Colors.grey[300],
                      color: AppTheme.primaryOrange,
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Check button (only if not answered)
            if (!isAnswered)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedItems.isEmpty ? null : _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Periksa',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

            // Show completion status if answered
            if (isAnswered)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect
                          ? AppTheme.correctGreen
                          : AppTheme.wrongRed,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCorrect ? 'Benar!' : 'Salah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isCorrect
                            ? AppTheme.correctGreen
                            : AppTheme.wrongRed,
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
