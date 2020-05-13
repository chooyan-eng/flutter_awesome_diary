import 'package:awesome_diary/diary_provider.dart';
import 'package:flutter/material.dart';

class DiaryListItem extends StatelessWidget {
  final Diary diary;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const DiaryListItem({
    Key key,
    this.diary,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          onLongPress: onLongPress,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              diary.imageFile != null ? 
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    child: Hero(
                      tag: 'helo_${diary.id}',
                      child: Image.file(
                        diary.imageFile,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16),
                    Text(
                      diary.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      diary.body,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8),
                    Align(
                      child: Text(
                        '${diary.createdAt.year}/${diary.createdAt.month}/${diary.createdAt.day}',
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
