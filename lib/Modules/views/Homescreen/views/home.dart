import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall_flutter_project/Modules/views/Homescreen/Proivder/home.dart';
import 'package:provider/provider.dart';

class Mybrowser extends StatefulWidget {
  Mybrowser({super.key});

  @override
  State<Mybrowser> createState() => _MybrowserState();
}

class _MybrowserState extends State<Mybrowser> {
  InAppWebViewController? inAppWebViewController;
  Connectivity connectivity = Connectivity();
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.black,
        ),
        onRefresh: () {
          inAppWebViewController?.reload();
        });
  }

  @override
  Widget build(BuildContext context) {
    Stream<ConnectivityResult> connectivity_stream =
        connectivity.onConnectivityChanged;

    String? value;
    TextEditingController searchtextEditingController =
        TextEditingController(text: value);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("MY browser"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: SizedBox(
                              height: 180,
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'bing');
                                    },
                                    child: const Text('Bing'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'ddGo');
                                    },
                                    child: const Text('Duck Duck Go'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'yahoo');
                                    },
                                    child: const Text('Yahoo'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text("Search Engine")),
                ),
                // PopupMenuItem(
                //   child: const Text("Bing"),
                //   onTap: () {
                //     Provider.of<WebProvider>(context, listen: true).Bing();
                //   },
                // ),
                // PopupMenuItem(
                //   child: GestureDetector(
                //       onTap: () {
                //         Provider.of<WebProvider>(context, listen: false)
                //             .DuckDuckGo();
                //       },
                //       child: const Text("Duck Duck Go")),
                //   onTap: () {},
                // ),
                // PopupMenuItem(
                //   child: const Text("Yahoo"),
                //   onTap: () {
                //     Provider.of<WebProvider>(context, listen: true).Yahoo();
                //   },
                // ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 120,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      inAppWebViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri.uri(
                            Uri.parse('https://www.google.com/'),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.home),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_add_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await inAppWebViewController!.canGoForward()) {
                        inAppWebViewController!.goForward();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      inAppWebViewController?.reload();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.refresh),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await inAppWebViewController!.canGoBack()) {
                        inAppWebViewController!.goBack();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: connectivity_stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return (snapshot.data == ConnectivityResult.wifi ||
                      snapshot.data == ConnectivityResult.mobile)
                  ? InAppWebView(
                      pullToRefreshController: pullToRefreshController,
                      initialUrlRequest: URLRequest(
                        url: WebUri.uri(
                          Uri.parse(
                            Provider.of<WebProvider>(context, listen: true)
                                .webModel
                                .webLink,
                          ),
                        ),
                      ),
                      onLoadStart: (controller, uri) {
                        inAppWebViewController = controller;
                      },
                      onLoadStop: (controller, uri) {
                        pullToRefreshController.endRefreshing();
                      },
                    )
                  : Center(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.red,

                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     "lib/App/Utils/Assets/not_connected.jpeg",
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
