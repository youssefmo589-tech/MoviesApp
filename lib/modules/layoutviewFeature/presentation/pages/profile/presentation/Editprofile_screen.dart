import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movieapp/core/FirebaseCloudService/FirestoreCloudService.dart';
import 'package:movieapp/core/Services/BotToastservice.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/Models/UserModel.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileBloc.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileEvent.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileState.dart';
import '../../../../../../core/app_routes/app_route_name.dart';
import '../../../../../../core/app_theme_manager/app_colors.dart';
import '../../../../../../widgets/avatar_bottom_sheet.dart';
import '../../../../../../widgets/button_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedimage;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserModel? currentuser;
  int _selectedAvatar = -1;

  @override
  void initState() {
    super.initState();
    loadcurrentuser();
  }

  Future<void> loadcurrentuser() async {
    final String userid = FirebaseAuth.instance.currentUser!.uid;
    final user = await FirestoreCloudService.getuser(userid);
    if (user != null) {
      setState(() {
        currentuser = user;
        nameController.text = currentuser?.name ?? "";
        phoneController.text = currentuser?.phone ?? "";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LoadingState) {
          EasyLoading.show();
        }
        if (state is SuccessState) {
          EasyLoading.dismiss();
          AppSnackBar.success("Updated Successfully");
        }
        if (state is ErrorState) {
          EasyLoading.dismiss();
          AppSnackBar.error(state.message ?? "Error occurred");
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.yellow,
                size: 24,
              ),
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
                const SizedBox(height: 37),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
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
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 1;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1).png"),
                                              index: 1,
                                              isSelected: _selectedAvatar == 1,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 2;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (1).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (1).png"),
                                              index: 2,
                                              isSelected: _selectedAvatar == 2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 3;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (2).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (2).png"),
                                              index: 3,
                                              isSelected: _selectedAvatar == 3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 4;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (3).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (3).png"),
                                              index: 4,
                                              isSelected: _selectedAvatar == 4,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 5;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (4).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (4).png"),
                                              index: 5,
                                              isSelected: _selectedAvatar == 5,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 6;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (5).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (5).png"),
                                              index: 6,
                                              isSelected: _selectedAvatar == 6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 7;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (6).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (6).png"),
                                              index: 7,
                                              isSelected: _selectedAvatar == 7,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 8;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (7).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (7).png"),
                                              index: 8,
                                              isSelected: _selectedAvatar == 8,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _selectedAvatar = 9;
                                              });
                                              setState(() {
                                                _selectedimage = "assets/images/gamer (1) (8).png";
                                              });
                                            },
                                            child: AvatarBottomSheet(
                                              image: Image.asset("assets/images/gamer (1) (8).png"),
                                              index: 9,
                                              isSelected: _selectedAvatar == 9,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: _selectedimage != null
                      ? CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(_selectedimage!),
                  )
                      : currentuser?.image != null
                      ? CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(currentuser!.image),
                  )
                      : CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: AppColors.offWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your name";
                            }
                            return null;
                          },
                          controller: nameController,
                          style: theme.titleSmall?.copyWith(color: AppColors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 16,
                            ),
                            hintText: "enter your name",
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
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your phone number";
                            }
                            if (value.length != 11) {
                              return "please enter a valid phone number";
                            }
                            return null;
                          },
                          controller: phoneController,
                          style: theme.titleSmall?.copyWith(color: AppColors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 16,
                            ),
                            hintText: "enter your phoneNumber",
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                const Spacer(),
                ButtonWidget(
                  title: "Delete Account",
                  buttoncolor: AppColors.red,
                  titlecolor: AppColors.white,
                ),
                const SizedBox(height: 19),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (currentuser?.name != nameController.text) {
                        context.read<ProfileBloc>().add(
                          EditnameEvent(name: nameController.text),
                        );
                      }
                      if (currentuser?.phone != phoneController.text) {
                        context.read<ProfileBloc>().add(
                          EditphoneEvent(phone: phoneController.text),
                        );
                      }
                      if (_selectedimage != null) {
                        context.read<ProfileBloc>().add(
                          EditimageEvent(image: _selectedimage!),
                        );
                      }
                    }
                  },
                  child: ButtonWidget(
                    title: "Update Data",
                    buttoncolor: AppColors.yellow,
                    titlecolor: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}