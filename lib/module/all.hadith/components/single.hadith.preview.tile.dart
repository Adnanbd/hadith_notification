import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hadith_notification/models/single.hadith.details.dart';

class SingleHadithPreviewTile extends ConsumerWidget {
  const SingleHadithPreviewTile({super.key, required this.hadith});

  final SingleHadithDetailModel hadith;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' ${hadith.hadithId}'),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: const ListTile(
                              leading: Icon(Icons.copy),
                              title: Text('Copy'),
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: const ListTile(
                              leading: Icon(Icons.open_in_browser),
                              title: Text('Reference'),
                            ),
                            onTap: () {},
                          )
                        ];
                      },
                    )
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(hadith.bn!),
                  ],
                ),
              );
            });
      },
      child: Card(
        color: const Color.fromARGB(103, 255, 255, 255),
        child: ListTile(
          title: Text('${hadith.bn?.substring(0, 70)}...'),
        ),
      ),
    );
  }
}
