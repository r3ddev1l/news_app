import 'package:flutter/material.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''News
App''',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 64),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .8,
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) => Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "articleDetailPage");
                        },
                        leading: Hero(
                          tag: index,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 64,
                            width: 64,
                          ),
                        ),
                        title: Wrap(
                          children: [
                            Text(
                                "Loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong Title"),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Source"), Text("Date")],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
