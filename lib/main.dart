import 'dart:ui';




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo ',
      home:Post(),
    );
  }
}

class Post extends StatefulWidget {
  Post({super.key});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with TickerProviderStateMixin {

  bool _iscontainerExpanded = false;
  bool _showHeart = false;
  bool _istextExpanded = false;


//CONTROLLERS
  late AnimationController _likeiconcontroller;
  late Animation<double> _likeiconanimationcontroller;
  late AnimationController _commentcontroller;
  late AnimationController _commenttypecontroller;
  late Animation<double> _commentboxcontroller;
  late Animation<double> _commenttypetextxontroller;
  late ScrollController scrollController;
  PageController controller = PageController();

//PAGE INDEX
  int _currentIndex = 0;

//TEMPARARY DATA   
  String text =
      "the words that are written above or below a picture, photograph, etc. to exphe words that are written above or below a picture\n\n\n#new #image #photo";
  List commments = [
    "wow",
    "great work",
    "cake looks yum,where to order and what's the price?",
    "great work man keep it up"
  ];

  List images = [
    "https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSGMq0vbc3ok0KzFZUfEiGQR1eW9Qexd67LA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-U5rN2Wvs3PetgvECwnvmmkrNgQpFNYsOUg&usqp=CAU"
  ];

//ICON BUTTON DECORATION
  Color likebuttoncolor = Colors.white;
  IconData likeicondata = CupertinoIcons.heart;
  IconData saveiconData = Icons.bookmark_border_outlined;

//HEIGHT OF ANIMATED CONTAINER
  double _closedHeight = 0;
  double _expandedHeight = 470;

  @override
  void initState() {
    super.initState();

scrollController = ScrollController();

//LIKE ICON ANIMATION CONTROLLER
    _likeiconcontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _likeiconanimationcontroller = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 0.2),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 0.2),
    ]).animate(_likeiconcontroller);

//FOR COMMENT BOX ANIMATION CONTROLLER
    _commentcontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _commentboxcontroller = Tween<double>(
      begin: _closedHeight,
      end: _expandedHeight,
    ).animate(CurvedAnimation(
      parent: _commentcontroller,
      curve: Curves.easeInOut,
    ));

//FOR ICON BOX ABOVE CAPTION BOX
    _commenttypecontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _commenttypetextxontroller = Tween<double>(
      begin: _closedHeight,
      end: _expandedHeight + 100,
    ).animate(CurvedAnimation(
      parent: _commenttypecontroller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleContainer() {
    setState(() {
      _iscontainerExpanded = !_iscontainerExpanded;
      if (_iscontainerExpanded) {
        _commentcontroller.forward();
        _commenttypecontroller.forward();
      } else {
        _commentcontroller.reverse();
        _commenttypecontroller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView.builder(
          scrollDirection:Axis.vertical,
            controller: controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                //CLOSING ANIMATED CONTAINERS ON PAGE CHANGE
                 _commentcontroller.reverse();
                 _commenttypecontroller.reverse();
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
//PROFILE NAME AND ICON TRAY
                  InkWell(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    onDoubleTap: () {
                      setState(() {
                        likeicondata = CupertinoIcons.heart_fill;
                        likebuttoncolor = Colors.red;
                      });
                    },
                    onTap: () {
                      setState(() {
                        _commentcontroller.reverse();
                        _commenttypecontroller.reverse();
                      });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                       
                                    },
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                            "https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60",
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text("Username@123",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      maxLines: _istextExpanded ? 50 : 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      text,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                  text.length > 60
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _istextExpanded =
                                                  !_istextExpanded;
                                            });
                                          },
                                          child: Text(
                                              _istextExpanded
                                                  ? "See less"
                                                  : "See more",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                                      .withOpacity(0.9))),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                            _icontray(),
                          ],
                        ),
                      ),
                    ),
                  ),
//ADD COMMENT FIELD                  
                  AnimatedBuilder(
                    animation: _commenttypetextxontroller,
                    builder: (context, child) {
                      return Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: _commenttypetextxontroller.value,
                          child: GestureDetector(
                            onTap: () {
                              _toggleContainer();
                            },
                            child: Container(
                                color: Colors.black, child: _commentfield()),
                          ));
                    },
                  ),
//COMMENT SECTION                  
                  AnimatedBuilder(
                    animation: _commentboxcontroller,
                    builder: (context, child) {
                      return Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          height: _commentboxcontroller.value,
                          child: Container(
                              color: Colors.black,
                              child: _commentsection(scrollController)));
                    },
                  ),
                ],
              );
            }));
  }

//WIDGET FOR ICONS TRAY
  Widget _icontray() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            child: _showHeart
                ? AnimatedBuilder(
                    animation: _likeiconanimationcontroller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _likeiconanimationcontroller.value,
                        child: Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                          size: 35,
                        ),
                      );
                    },
                  )
                : Icon(
                    likeicondata,
                    color: likebuttoncolor,
                    size: 35,
                  ),
            onTap: () {
              setState(() {
                likeicondata = CupertinoIcons.heart;
                likebuttoncolor = Colors.white;
              });
            },
            onDoubleTap: () {
              setState(() {
                _showHeart = true;
                likeicondata = CupertinoIcons.heart_fill;
                likebuttoncolor = Colors.red;
              });
              _likeiconcontroller.forward();

              // Hide the heart after 4 seconds
              Future.delayed(Duration(seconds: 4)).then((value) {
                setState(() {
                  _showHeart = false;
                });
                _likeiconcontroller.reset();
              });
            },
          ),
          const SizedBox(height: 10),
          InkWell(
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: Colors.white,
              size: 35,
            ),
            onTap: () {
              setState(() {
                _commentcontroller.forward();
                _commenttypecontroller.forward();
              });
            },
          ),
          const SizedBox(height: 10),
          InkWell(
            child: const Icon(
              CupertinoIcons.arrow_turn_down_right,
              color: Colors.white,
              size: 35,
            ),
            onTap: () {
              //SHARE POST
            },
          ),
          const SizedBox(height: 10),
          InkWell(
            child: Icon(
              saveiconData,
              color: Colors.white,
              size: 35,
            ),
            onTap: () {
              //SAVE POST
            },
          ),
        ],
      ),
    );
  }

//WIDGET FOR ADD COMMENT

  Widget _commentfield() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Comments",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _commentcontroller.reverse();
                          _commenttypecontroller.reverse();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
            TextField(
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white54),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Add Comment",
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

//WIDGET FOR CAPTION  CONTENT
  Widget _commentsection(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
              itemCount: commments.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60",
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username@12",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                          Text("12 June",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.5),
                              )),
                        ],
                      ),
                      Text(
                          maxLines: _istextExpanded ? 50 : 2,
                          overflow: TextOverflow.ellipsis,
                          commments[index].toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.5))),
                      commments[index].toString().length > 100
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _istextExpanded = !_istextExpanded;
                                });
                              },
                              child: Text(_istextExpanded ? "less" : "more",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.8))),
                            )
                          : SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  //LIKE THE COMMENT
                                },
                                child: Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("23",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.5),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ));
  }

  @override
  void dispose() {
    _commentcontroller.dispose();
    _commenttypecontroller.dispose();
    _likeiconcontroller.dispose();
    super.dispose();
  }
}
