import 'package:detest/configure/configure_camra.dart';
import 'package:detest/configure/configure_image.dart';
import 'package:detest/configure/configure_job.dart';
import 'package:detest/configure/configure_rana.dart';
import 'package:detest/constant.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  final String deviceId;
  final String userName;
  const ConfigScreen(
      {super.key, required this.deviceId, required this.userName});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  int _selectedIndex = 0;

  bool isExpanded = false;

  Widget screens(BuildContext context, int index) {
    switch (index) {
      case 0:
        {
          return ConfigureJob(deviceId: widget.deviceId);
        }
      // case 1:
      //   {
      //     return ConfigureCamera(deviceId: widget.deviceId);
      //   }
      // case 2:
      //   {
      //     return ConfigureRana(deviceId: widget.deviceId);
      //   }
      default:
        return ConfigureImage(
          deviceId: widget.deviceId,
          userName: widget.userName,
        );
    }
  }

  Widget _nav(BuildContext context, int current, String name, IconData icon) {
    return Container(
      height: 50,
      width: 300,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _selectedIndex == current ? Colors.green[400] : Colors.grey,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Icon(
            icon,
            color: _selectedIndex == current ? Colors.green : Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(name),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            !isExpanded
                ? NavigationRail(
                    // groupAlignment: -0.75,
                    useIndicator: true,
                    indicatorColor: Colors.green[300],
                    backgroundColor: Colors.green[100],
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black, opacity: 0.5),
                    selectedIconTheme:
                        const IconThemeData(color: Colors.green, opacity: 1),
                    unselectedLabelTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    selectedLabelTextStyle: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: FloatingActionButton.small(
                        heroTag: 'btn1',
                        backgroundColor: buttonColor,
                        onPressed: () {
                          setState(() {
                            isExpanded = true;
                          });
                        },
                        child: const Icon(Icons.menu),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: FloatingActionButton.small(
                        heroTag: 'btn2',
                        backgroundColor: buttonColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    destinations: const <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Icon(Icons.work),
                        label: Text('J O B'),
                      ),
                      // NavigationRailDestination(
                      //   icon: Icon(Icons.camera),
                      //   label: Text('C A M E R A'),
                      // ),
                      // NavigationRailDestination(
                      //   icon: Icon(Icons.computer),
                      //   label: Text('R A N A'),
                      // ),
                      NavigationRailDestination(
                        icon: Icon(Icons.image),
                        label: Text('I M A G E'),
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                  )
                : Container(
                    width: 300,
                    color: Colors.green[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton.small(
                                backgroundColor: buttonColor,
                                onPressed: () {
                                  setState(() {
                                    isExpanded = false;
                                  });
                                },
                                // child: const Icon(Icons.clear_all_outlined),
                                child: const Icon(
                                  Icons.wrap_text_outlined,
                                  size: 35,
                                ),
                                // child: const Icon(Icons.close),
                                // child: const Icon(Icons.arrow_back),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                          child: _nav(context, 0, 'J O B', Icons.work),
                        ),
                        // InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         _selectedIndex = 1;
                        //       });
                        //     },
                        //     child:
                        //         _nav(context, 1, 'C A M E R A', Icons.camera)),
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       _selectedIndex = 2;
                        //     });
                        //   },
                        //   child: _nav(context, 2, 'R A N A', Icons.computer),
                        // ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 3;
                            });
                          },
                          child: _nav(context, 3, 'I M A G E', Icons.image),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            buttonColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.home),
                                  label: const Text('Home'))
                            ],
                          ),
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('C O N F I G U R E',
                            style: TextStyle(
                              fontSize: 25,
                              color: buttonColor,
                              fontWeight: FontWeight.w900,
                            ))
                      ],
                    ),
                  ),
                  screens(context, _selectedIndex)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
