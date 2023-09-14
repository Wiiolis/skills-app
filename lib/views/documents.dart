import 'package:demo_app/components/document_box.dart';
import 'package:flutter/material.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Documents',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(children: [
          DocumentBox(
              title: 'Absence Form',
              link:
                  'https://forms.office.com/Pages/ResponsePage.aspx?id=4tBQCHG-HUOV508p2RZigi4QA0HASP1Nu9bnlnDMM0NUMUhOTkdHSjlINEVWMEk4TFQ1STREWjc1QyQlQCN0PWcu&wdLOR=c787A2C49-FEF5-4FDC-B3E5-FD35588DCCFE'),
          DocumentBox(
              title: 'External CR Request Form',
              link:
                  'https://forms.office.com/Pages/ResponsePage.aspx?id=4tBQCHG-HUOV508p2RZiggwXvnK8OZ5IsnAYlg1uCBxURFREMk01RU1EOUpRQktMSEtUVjk2Q1NFUCQlQCN0PWcu')
        ])
      ],
    );
  }
}
