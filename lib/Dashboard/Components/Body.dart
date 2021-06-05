import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blueGrey, Colors.grey.shade300],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EmperorAkashi20',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Rishabh Sethia',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.25,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SideBarOptions(
                          icon: Icons.password,
                          text: 'Passwords',
                          press: () {},
                        ),
                        SideBarOptions(
                          icon: Icons.credit_card_rounded,
                          text: 'Banks And Cards',
                          press: () {},
                        ),
                        SideBarOptions(
                          icon: Icons.info_rounded,
                          text: 'Personal Info',
                          press: () {},
                        ),
                        SideBarOptions(
                          icon: Icons.text_snippet_rounded,
                          text: 'Documents',
                          press: () {},
                        ),
                        SideBarOptions(
                          icon: Icons.note_add_rounded,
                          text: 'Safe Notes',
                          press: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          color: Colors.blueGrey.shade900,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    'E',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.grey.shade300],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            height: 40,
                            color: Colors.blueGrey.shade800,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '+ Add New',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarOptions extends StatelessWidget {
  const SideBarOptions({
    required this.text,
    required this.press,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String text;
  final Function press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press(),
      leading: Icon(icon),
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.blueGrey.shade800,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
