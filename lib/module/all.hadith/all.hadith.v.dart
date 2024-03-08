import 'package:flutter/material.dart';
import 'package:hadith_notification/models/single.hadith.details.dart';
import 'package:hadith_notification/module/all.hadith/components/single.hadith.preview.tile.dart';
import 'package:hadith_notification/services/notification.dart';
import 'package:hadith_notification/services/shared.pref.service.dart';

class AllHadithView extends StatefulWidget {
  const AllHadithView({super.key});

  @override
  State<AllHadithView> createState() => _AllHadithViewState();
}

class _AllHadithViewState extends State<AllHadithView> {
  @override
  void initState() {
    super.initState();
    SharedPreferencesService().loadHadithList().then((value) async {
      if (value.length < 6) {
        //value.isEmpty)
        // await fetchHadith();
        // setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeM = MediaQuery.of(context).size;
    final height = sizeM.height;
    final width = sizeM.width;
    final appBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/pxfuel.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(216, 255, 255, 255),
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: appBarHeight,
                    ),
                    Image.asset(
                      'assets/top-logo.png',
                      height: height * 0.1,
                      width: width * 0.3,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      child: FutureBuilder<List<SingleHadithDetailModel>>(
                        future: SharedPreferencesService().loadHadithList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final hList = snapshot.data!;
                            hList.sort(
                              (a, b) => b.timeStamp!.compareTo(a.timeStamp!),
                            );

                            return ListView.builder(
                              itemCount: hList.length,
                              itemBuilder: (context, index) {
                                final hadith = hList[index];
                                if (index == 0) {
                                  return Card(
                                    color: const Color.fromARGB(79, 77, 255, 121),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ListTile(
                                        title: Text(
                                          hadith.bn ?? 'No Data',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(255, 0, 0, 0)),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (index == 1) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('পূর্বের হাদিস সমূহ'),
                                      ),
                                      SingleHadithPreviewTile(hadith: hadith),
                                    ],
                                  );
                                }
                                return SingleHadithPreviewTile(hadith: hadith);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await showNotification(null);
      }),
    );
  }
}
