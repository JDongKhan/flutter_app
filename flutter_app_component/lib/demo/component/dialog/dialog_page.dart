import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @author jd

class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog Demo'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('提示'),
                        content: Text('确认删除吗？'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('删除'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('确认'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('showDialog(AlertDialog)'),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text('提示'),
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text('确认删除吗？')),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('删除'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('确认'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('showDialog(SimpleDialog)'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('提示'),
                          content: Text('确认删除吗？'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('删除'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('确认'),
                            ),
                          ],
                        );
                      });
                },
                child: Text('showCupertinoDialog'),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            title: const Text('提示'),
                            message: const Text('是否继续分享？'),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: const Text('确定'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                isDefaultAction: true,
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                isDestructiveAction: true,
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('showCupertinoModalPopup'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: '',
                    transitionDuration: Duration(milliseconds: 200),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 250,
                            height: 300,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('showGeneralDialog'),
              ),
              TextButton(
                onPressed: () {
                  showLicensePage(context: context);
                },
                child: Text('showLicensePage'),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      builder: (context) {
                        return BottomSheet(
                            onClosing: () {},
                            builder: (context) {
                              return Container(
                                height: 200,
                                color: Colors.blue,
                              );
                            });
                      });
                },
                child: Text('showModalBottomSheet'),
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          // backgroundColor: Colors.grey[100].withAlpha(100),
                          builder: (context) {
                            return Material(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 300,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            );
                          });
                    },
                    child: Text('showBottomSheet'),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showAboutDialog(context: context);
                },
                child: Text('showAboutDialog'),
              ),
              TextButton(
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fill,
                    items: <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text('语文'),
                      ),
                      PopupMenuDivider(),
                      CheckedPopupMenuItem(
                        child: Text('数学'),
                        checked: true,
                      ),
                      PopupMenuItem(
                        child: Text('数学'),
                      ),
                    ],
                  );
                },
                child: Text('showMenu'),
              ),
              TextButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                child: Text('showSearch'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            '我搜到了 $index',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: 20,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('搜索 $index'),
          onTap: () {
            query = '搜索 $index';
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: Random().nextInt(10),
    );
  }
}
