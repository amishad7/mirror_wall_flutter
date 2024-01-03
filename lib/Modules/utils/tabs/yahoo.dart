import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class yahoo_ extends StatefulWidget {
  const yahoo_({super.key});

  @override
  State<yahoo_> createState() => _yahoo_State();
}

class _yahoo_State extends State<yahoo_> {
  @override
  Widget build(BuildContext context) {
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

    Stream<ConnectivityResult> connectivity_stream =
        connectivity.onConnectivityChanged;

    return Scaffold(
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
                                  onPressed: () {},
                                  child: const Text('Google'),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Duck Duck Go'),
                                ),
                                TextButton(
                                  onPressed: () {},
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
                          "https://in.search.yahoo.com/?fr2=inr",
                          // Provider.of<WebProvider>(context, listen: true)
                          //     .webModel
                          //     .webLink,
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
    );
  }
}
