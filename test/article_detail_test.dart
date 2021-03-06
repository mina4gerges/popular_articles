import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ny_times_articles/widgets/date.dart';
import 'package:ny_times_articles/global/messages.dart';
import 'package:ny_times_articles/models/article_model.dart';
import 'package:ny_times_articles/views/articles/article_detail.dart';

/// Widget test to test ArticleDetail view display
void main() {
  Article article1;
  Article article2;

  Widget createArticleDetailScreen1;
  Widget createArticleDetailScreen2;

  setUp(() {
    Map<String, Map<String, dynamic>> tempImagePaths =
        Map<String, Map<String, dynamic>>();
    Map<String, dynamic> imageDetails = Map<String, dynamic>();

    imageDetails['path'] = 'https://i.pinimg.com/564x/2a/d6/0a/2ad60a09e1a5bf1'
        '8fb2d939b7822cd99.jpg';
    imageDetails['width'] = 10.0;
    imageDetails['height'] = 10.0;

    tempImagePaths['highResolutionDetail'] = imageDetails;

    ImagePaths imagePaths = ImagePaths(imagePaths: tempImagePaths);

    article1 = Article(
      id: 1,
      title: 'title 1',
      author: 'author 1',
      section: 'section 1',
      imagePaths: imagePaths,
      creationDate: '2021-02-04',
      description: 'description 1',
    );

    article2 = Article(
      id: 2,
      title: 'title 2',
    );

    createArticleDetailScreen1 = MaterialApp(
      home: ArticleDetail(
        article: article1,
      ),
    );

    createArticleDetailScreen2 = MaterialApp(
      home: ArticleDetail(
        article: article2,
      ),
    );
  });

  group('Article details widget tests', () {
    testWidgets('Test article details shows up', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(createArticleDetailScreen1);

      expect(find.text(article1.title), findsOneWidget);

      expect(find.text(article1.description), findsOneWidget);

      expect(find.text(article1.author), findsOneWidget);

      expect(find.text(article1.creationDate), findsOneWidget);

      expect(find.text(GlobalMessages.errorMsg), findsNothing);

      expect(find.text(GlobalMessages.goBackMsg), findsNothing);

      expect(find.byType(Image), findsOneWidget);

      expect(find.byType(Text), findsNWidgets(5));

      expect(find.byType(Date), findsOneWidget);

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('Test article details shows up with an error',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(createArticleDetailScreen2);

      expect(find.text(article1.title), findsNothing);

      expect(find.text(article1.description), findsNothing);

      expect(find.text(article1.author), findsNothing);

      expect(find.text(article1.creationDate), findsNothing);

      expect(find.text(GlobalMessages.errorMsg), findsOneWidget);

      expect(find.text(GlobalMessages.goBackMsg), findsOneWidget);

      expect(find.byType(Image), findsNothing);

      expect(find.byType(Text), findsNWidgets(4));

      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
    });
  });
}
