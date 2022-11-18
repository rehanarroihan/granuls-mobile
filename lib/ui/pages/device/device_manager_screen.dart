import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceManagerScreen extends StatefulWidget {
  const DeviceManagerScreen({Key? key}) : super(key: key);

  @override
  _DeviceManagerScreenState createState() => _DeviceManagerScreenState();
}

class _DeviceManagerScreenState extends State<DeviceManagerScreen> {
  final _devices = [
    "XIID78KK",
    "KDZ88IUYL",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
    "OOKD98PPZ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Pengelolaan Alat',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            tooltip: 'Tambah Device Baru',
            onPressed: () => _showAddDeviceDialog(),
          )
        ],
      ),
      body: true != true ? Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Belum ada alat, silahkan buat baru')
          ],
        ),
      ) :
      SingleChildScrollView(
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _devices.length,
            itemBuilder: (context, index) => _deviceItem(context, index)
        ),
      ),
    );
  }

  Widget _deviceItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 1),
                  blurRadius: 4,
                ),
              ]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 16.w),
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Text(
                _devices[index],
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDeviceDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, StateSetter stateSetter) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        'Tambah Alat Baru',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ID Alat',
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Daftarkan',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
