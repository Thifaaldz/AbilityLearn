class QuizKenalSekitarku {
  final String id;
  final String instruction;
  final String room;
  final String correctItem;
  final List<String> options;
  final String? audioPath;

  const QuizKenalSekitarku({
    required this.id,
    required this.instruction,
    required this.room,
    required this.correctItem,
    required this.options,
    this.audioPath,
  });
}
