import 'package:flutter/material.dart';

import '../../core/app_routes/app_route_name.dart';
import '../../core/app_theme_manager/app_colors.dart';
import '../../widgets/avatar_bottom_sheet.dart';
import '../../widgets/button_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

   int _selectedAvatar = -1;
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.yellow, size: 24),
        ),
        title: Text(
          "Pick Avatar",
          style: theme.titleSmall?.copyWith(color: AppColors.yellow),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 37),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    isDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(16),

                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 1;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1).png"),
                                        index: 1,
                                        isSelected: _selectedAvatar == 1,),
                                    )),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedAvatar = 2;
                                          });
                                        },

                                        child: AvatarBottomSheet(
                                          image: Image.asset(
                                              "assets/images/gamer (1) (1).png"),
                                          index: 2,
                                          isSelected: _selectedAvatar == 2,),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedAvatar = 3;
                                          });
                                        },

                                        child: AvatarBottomSheet(
                                          image: Image.asset(
                                              "assets/images/gamer (1) (2).png"),
                                          index: 3,
                                          isSelected: _selectedAvatar == 3,),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,

                                  children: [
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 4;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1) (3).png"),
                                        index: 4,
                                        isSelected: _selectedAvatar == 4,),
                                    )),
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 5;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1) (4).png"),
                                        index: 5,
                                        isSelected: _selectedAvatar == 5,),
                                    )),
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 6;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1) (5).png"),
                                        index: 6,
                                        isSelected: _selectedAvatar == 6,),
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,

                                  children: [
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 7;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1) (6).png"),
                                        index: 7,
                                        isSelected: _selectedAvatar == 7,),
                                    )),
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 8;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1) (7).png"),
                                        index: 8,
                                        isSelected: _selectedAvatar == 8,),
                                    )),
                                    Expanded(child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = 9;
                                        });
                                      },
                                      child: AvatarBottomSheet(
                                        image: Image.asset(
                                            "assets/images/gamer (1) (8).png"),
                                        index: 9,
                                        isSelected: _selectedAvatar == 9,),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      );

                    }

                );
              },

              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/gamer (1) (7).png"),
              ),
            ),

            SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                style: theme.titleSmall?.copyWith(color: AppColors.white),

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                  hintText: "Youssef Mohamed",
                  hintStyle: theme.titleSmall?.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 31,
                  ),
                  filled: true,
                  fillColor: AppColors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.white),
                  ),
                ),
              ),
            ),

            SizedBox(height: 19),

            SizedBox(
              width: double.infinity,
              child: TextFormField(
                style: theme.titleSmall?.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                  hintText: "01000000000",
                  hintStyle: theme.titleSmall?.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: AppColors.white,
                    size: 31,
                  ),
                  filled: true,
                  fillColor: AppColors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.white),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRouteName.forgetPassword);
                },
                child: Text(
                  "Reset Password",
                  style: theme.titleSmall?.copyWith(
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Spacer(),

            ButtonWidget(
              title: "Delete Account",
              buttoncolor: AppColors.red,
              titlecolor: AppColors.white,
            ),
            SizedBox(height: 19),
            ButtonWidget(
              title: "Update Data",
              buttoncolor: AppColors.yellow,
              titlecolor: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }


}