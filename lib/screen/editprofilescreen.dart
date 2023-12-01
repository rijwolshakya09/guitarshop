import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_profile.dart';
import 'package:guitarshop/repository/profile_repository.dart';
import 'package:guitarshop/response/profile_response.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _contactnoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _genderController = TextEditingController();

  Future<void> requestCameraPermission() async {
    final cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> requestGalleryPermission() async {
    final galleryStatus = await Permission.photos.status;
    if (galleryStatus.isDenied) {
      await Permission.photos.request();
    }
  }

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  _updatePatientProfile(ShowProfile patientProfile, File? image) async {
    bool isBooked =
        await ProfileRepository().updatePatientProfile(patientProfile, image);
    Navigator.pushNamed(context, "/layout");
    _displayMessage(isBooked);
  }

  _displayMessage(bool isBooked) {
    if (isBooked) {
      MotionToast.success(
              description: const Text("Profile Updated Successfully"))
          .show(context);
    } else {
      MotionToast.error(
              description:
                  const Text("Something Went Wrong!!! Please Try Again!!!"))
          .show(context);
    }
  }

  ProfileResponse? profile;

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  void getUserDetails() async {
    ProfileResponse? profileDetails = await ProfileRepository().getProfile();

    setState(() {
      profile = profileDetails!;
      if (profile != null) {
        _fullnameController.text = profile!.data!.full_name!;
        _addressController.text = profile!.data!.address!;
        _contactnoController.text = profile!.data!.contact_no!;
        _genderController.text = profile!.data!.gender!;
        _usernameController.text = profile!.data!.username!;
        _emailController.text = profile!.data!.email!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Title(
                  color: const Color(0xFF535699),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Color(0xFF535699),
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          height: 100,
                          child: CircleAvatar(
                            radius: 60,
                            child: ClipOval(
                              child: Image.network(
                                'https://w7.pngwing.com/pngs/627/693/png-transparent-computer-icons-user-user-icon-thumbnail.png',
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return selectImage();
                                });
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      //=============================FulName Text Field==============================
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _fullnameController,
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Fluent.person_20_filled,
                              color: Color(0xFF535699),
                              size: 30,
                            ),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Full Name',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Full Name';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Address Text Field==============================
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          controller: _addressController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ph.address_book_fill,
                              color: Color(0xFF535699),
                              size: 30,
                            ),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Address',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Address';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Contact Text Field==============================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _contactnoController,
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ic.baseline_call,
                              color: Color(0xFF535699),
                              size: 30,
                            ),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Contact No.',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Contact No.';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Gender Field==============================
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          controller: _genderController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Mdi.gender_male_female,
                              color: Color(0xFF535699),
                              size: 30,
                            ),
                            // labelText: 'Username',
                            hintText: 'Gender',
                            // labelStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Gender';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Username Text Field==============================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _usernameController,
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Fluent.person_20_filled,
                              color: Color(0xFF535699),
                              size: 30,
                            ),
                            // labelText: 'Username',
                            hintText: 'Username',
                            // labelStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Username';
                            }
                            return null;
                          },
                        ),
                      ),

                      //=============================Email Text Field==============================
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF535699),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xFF535699),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: const Color(0xFF535699),
                          style: const TextStyle(
                            color: Color(0xFF535699),
                            fontFamily: 'Merienda',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Iconify(
                              Ic.baseline_email,
                              color: Color(0xFF535699),
                              size: 30,
                            ),
                            // labelText: 'Full Name',
                            // labelStyle: TextStyle(fontSize: 18),
                            hintText: 'Email',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                            return null;
                          },
                        ),
                      ),

                      //===========================Password Text Field================================
                      // const SizedBox(height: 12),
                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      //   width: double.infinity,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: const Color(0xFF535699),
                      //       width: 2,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10),
                      //     // color: const Color(0xFF535699),
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: TextFormField(
                      //     controller: _passwordController,
                      //     cursorColor: const Color(0xFF535699),
                      //     style: const TextStyle(
                      //       color: Color(0xFF535699),
                      //       fontFamily: 'Merienda',
                      //     ),
                      //     obscureText: true,
                      //     keyboardType: TextInputType.text,
                      //     decoration: const InputDecoration(
                      //       icon: Iconify(
                      //         Ph.lock_key_fill,
                      //         color: Color(0xFF535699),
                      //         size: 30,
                      //       ),
                      //       // labelText: 'Password',
                      //       hintText: 'Password',
                      //       // labelStyle: TextStyle(fontSize: 18),
                      //       enabledBorder: InputBorder.none,
                      //       focusedBorder: InputBorder.none,
                      //     ),
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please Enter Your Password';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      // //=================================Terms & Condition==============================
                      // Container(
                      //   margin: const EdgeInsets.only(top: 0),
                      //   // alignment: Alignment.centerRight,
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(10.0),
                      //           ),
                      //         ),
                      //         value: isChecked,
                      //         onChanged: (v) {
                      //           setState(() {
                      //             isChecked = v!;
                      //           });
                      //         },
                      //       ),
                      //       const Text(
                      //         "I Accept All The Terms & Conditions.",
                      //         style: TextStyle(
                      //           // color: Colors.grey,
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: 'Merienda',
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   // child: GestureDetector(
                      //   //   child: const Text(
                      //   //     "Forget Password?",
                      //   //     style: TextStyle(
                      //   //       color: Color(0xFF535699),
                      //   //       fontWeight: FontWeight.bold,
                      //   //       fontFamily: 'Merienda',
                      //   //     ),
                      //   //   ),
                      //   //   onTap: () {},
                      //   // ),
                      // ),

                      //=================================SignUp Button=================================
                      const SizedBox(
                        height: 8,
                      ),
                      // SizedBox(
                      //   height: 40,
                      //   width: 120,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: const Color(0xFF535699),
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.all(Radius.circular(12)),
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         // if (_formKey.currentState!.validate()) {
                      //         //   Customer customer = Customer(
                      //         //     full_name: _fullnameController.text,
                      //         //     contact_no: _contactnoController.text,
                      //         //     username: _usernameController.text,
                      //         //     email: _emailController.text,
                      //         //     password: _passwordController.text,
                      //         //   );
                      //         //   _registerUser(customer);
                      //         // }
                      //       });
                      //     },
                      //     child: const Text(
                      //       'Sign Up',
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 16,
                      //         fontFamily: 'Merienda',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          debugPrint(_fullnameController.text);
                          if (_formKey.currentState!.validate()) {
                            ShowProfile updateProfile = ShowProfile(
                              full_name: _fullnameController.text,
                              address: _addressController.text,
                              contact_no: _contactnoController.text,
                              gender: _genderController.text,
                              username: _usernameController.text,
                              email: _emailController.text,
                            );
                            _updatePatientProfile(
                              updateProfile,
                              img,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromRGBO(11, 86, 222, 5),
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                  fontFamily: "Merienda",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectImage() {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          const SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: ElevatedButton.icon(
              onPressed: () {
                requestCameraPermission();
                _loadImage(ImageSource.camera);
              },
              icon: const Icon(Icons.camera_enhance),
              label: const Text('Open Camera'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 350,
            child: ElevatedButton.icon(
              onPressed: () {
                requestGalleryPermission();
                _loadImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.browse_gallery_sharp),
              label: const Text('Open Gallery'),
            ),
          ),
        ],
      ),
    );
  }
}
