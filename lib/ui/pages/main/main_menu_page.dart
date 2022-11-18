import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/main_menu_model.dart';
import 'package:granuls/ui/pages/device/device_manager_screen.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final _mainMenuList = [
    MainMenuModel(
        id: 1,
        name: 'Kelola Alat Granuls',
        assetPath: 'assets/images/ic_device_manager.png'),
    MainMenuModel(
        id: 2,
        name: 'Kelola Lahan',
        assetPath: 'assets/images/ic_manage_lahan.png'),
    MainMenuModel(
        id: 3,
        name: 'Tips Pertanian',
        assetPath: 'assets/images/ic_farm_tips.png'),
    MainMenuModel(
        id: 4, name: 'Pengaturan', assetPath: 'assets/images/ic_setting.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 48.h, horizontal: 16.w),
                    decoration: const BoxDecoration(
                        color: Color(0xFF44BB77),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo, Rahardian Agung",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24.sp),
                          ),
                          Text(
                            "1 Lahan Sudah di Kelola",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fitur',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _mainMenuList.length,
                            itemBuilder: (context, index) =>
                                _menuItem(context, index))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        switch (_mainMenuList[index].id) {
          case 1:
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeviceManagerScreen()));
            }
            break;

          case 2:
            {}
            break;

          case 3:
            {
              //statements;
            }
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 1),
                  blurRadius: 4,
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 16.w),
                child: Image(
                  image: AssetImage(
                    _mainMenuList[index].assetPath,
                  ),
                ),
              ),
              Text(
                _mainMenuList[index].name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
