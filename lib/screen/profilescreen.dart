import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/model/show_profile.dart';
import 'package:guitarshop/repository/profile_repository.dart';
import 'package:guitarshop/response/profile_response.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../utils/url.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Profile Details",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Merienda',
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FutureBuilder<ProfileResponse?>(
                    future: ProfileRepository().getProfile(),
                    builder: (context, snapshot) {
                      // debugPrint(snapshot.data!.data!.address.toString());
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          // ProductResponse productResponse = snapshot.data!;
                          ShowProfile lstProfile = snapshot.data!.data!;
                          return profilemain(lstProfile);
                        } else {
                          return const Center(
                            child: Text("No data"),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget profile(ShowProfile profile) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // height: double.infinity,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF535699),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            children: [
              if (profile.profile_pic != null)
                CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFFbdbfe9),
                  // backgroundImage:
                  //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
                  child: ClipRect(
                    child: Image.network("$baseUrl${profile.profile_pic!}",
                        height: 120, width: 120),
                  ),
                ),
              const SizedBox(
                height: 12,
              ),
              if (profile.full_name != null)
                Text(
                  profile.full_name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
              const SizedBox(
                height: 6,
              ),
              if (profile.contact_no != null)
                Text(
                  profile.contact_no!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
            ],
          ),
        ),
        // const Positioned(
        //   child: Iconify(
        //     Ph.heart_fill,
        //     color: Colors.white,
        //     size: 24,
        //   ),
        //   top: 8,
        //   right: 8,
        // ),
      ],
    );
  }

  Widget profilemain(ShowProfile profile) {
    return Column(
      children: [
        CircleAvatar(
          radius: 140,
          backgroundColor: const Color(0xFFbdbfe9),
          backgroundImage: NetworkImage("$baseUrl${profile.profile_pic!}"),
        ),
        // Text(
        //   profile.full_name!,
        //   style: const TextStyle(
        //     color: Color(0xFF535699),
        //     fontWeight: FontWeight.bold,
        //     fontSize: 22,
        //     fontFamily: 'Merienda',
        //   ),
        // ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF535699),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Divider(
                color: Colors.white,
                indent: 5,
                endIndent: 5,
                thickness: 2,
              ),
              ListTile(
                leading: const Iconify(
                  Fluent.person_20_filled,
                  color: Colors.white,
                  size: 34,
                ),
                title: Text(
                  profile.full_name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                color: Colors.white,
                indent: 5,
                endIndent: 5,
                thickness: 2,
              ),
              ListTile(
                leading: const Iconify(
                  Majesticons.home,
                  color: Colors.white,
                  size: 34,
                ),
                title: Text(
                  profile.address!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                color: Colors.white,
                indent: 5,
                endIndent: 5,
                thickness: 2,
              ),
              ListTile(
                leading: const Iconify(
                  Ph.phone_fill,
                  color: Colors.white,
                  size: 34,
                ),
                title: Text(
                  profile.contact_no!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                color: Colors.white,
                indent: 5,
                endIndent: 5,
                thickness: 2,
              ),
              ListTile(
                leading: const Iconify(
                  Ph.user_circle_fill,
                  color: Colors.white,
                  size: 34,
                ),
                title: Text(
                  profile.username!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                color: Colors.white,
                indent: 5,
                endIndent: 5,
                thickness: 2,
              ),
              ListTile(
                leading: const Iconify(
                  Ic.round_email,
                  color: Colors.white,
                  size: 34,
                ),
                title: Text(
                  profile.email!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Merienda',
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                color: Colors.white,
                indent: 5,
                endIndent: 5,
                thickness: 2,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/editprofile');
                },
                icon: const Iconify(
                  Mdi.account_details,
                  color: Color(0xFFFFFFFF),
                  size: 40,
                ),
                label: const Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontFamily: "Merienda",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF535699)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 54,
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       // Navigator.pushNamed(context, '/order');
            //       AwesomeNotifications().createNotification(
            //         content: NotificationContent(
            //           id: counter,
            //           channelKey: 'basic_channel',
            //           title: 'Login Success',
            //           body: 'Welcome To Guitar Shop',
            //         ),
            //       );
            //       setState(() {
            //         counter++;
            //       });
            //     },
            //     icon: const Iconify(
            //       Ic.baseline_add_photo_alternate,
            //       color: Color(0xFFFFFFFF),
            //       size: 40,
            //     ),
            //     label: const Text(
            //       "Edit Picture",
            //       style: TextStyle(
            //           color: Color(0xFFFFFFFF),
            //           fontFamily: "Merienda",
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     style: ButtonStyle(
            //       backgroundColor:
            //           MaterialStateProperty.all<Color>(const Color(0xFF535699)),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12.0),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
