import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoonDialog {

  void show(BuildContext context) {
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
                bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 24.h,
                  top: 40.h,
                  right: 18.w,
                  left: 18.w
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 64.w),
                      child: const Image(
                        image: AssetImage('assets/images/image_coming_soon.png'),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Segera Hadir',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Mohon maaf fitur masih dalam tahap\npengembangan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Siap!',
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