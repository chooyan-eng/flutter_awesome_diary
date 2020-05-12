class Diary {
  final int id;
  final String title;
  final String body;

  Diary({
    this.id,
    this.title,
    this.body,
  });

  factory Diary.sample() {
    return Diary(
      id: -1,
      title: 'Flutterはじめました',
      body: 'TechPitでFlutterの勉強をスタートしました。まずは宣言的UIから勉強中。',
    );
  }
}
