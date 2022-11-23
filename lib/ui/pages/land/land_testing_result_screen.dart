import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/cubit/land/land_cubit.dart';
import 'package:lottie/lottie.dart';

class LandTestingResultScreenArgs {
  String idTipeTanah;
  String idTumbuhan;
  int luas;
  int n, p, k;
  String kualitasTanah;

  LandTestingResultScreenArgs({
    required this.idTipeTanah,
    required this.idTumbuhan,
    this.luas = 1,
    required this.n,
    required this.p,
    required this.k,
    required this.kualitasTanah
  });
}

class LandTestingResultScreen extends StatefulWidget {
  LandTestingResultScreenArgs args;

  LandTestingResultScreen({
    Key? key,
    required this.args
  }) : super(key: key);

  @override
  _LandTestingResultScreenState createState() => _LandTestingResultScreenState();
}

class _LandTestingResultScreenState extends State<LandTestingResultScreen> {
  late LandCubit _landCubit;

  @override
  void initState() {
    super.initState();

    _landCubit = BlocProvider.of<LandCubit>(context);

    _landCubit.getVertilizerRecommendation(
      widget.args.idTipeTanah,
      widget.args.idTumbuhan,
      widget.args.luas.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _landCubit,
      listener: (context, state) {

      },
      child: BlocBuilder(
        bloc: _landCubit,
        builder: (context, state) {
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
                'Hasil Pengujian',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
            body: _landCubit.isGetFertilizerRecommendation ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 60.h,
                    child: Lottie.asset('assets/lottie/loading_animation.json')
                  ),
                )
              ],
            ) :
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 200.h,
                        child: Lottie.asset('assets/lottie/checklist.json')
                      ),
                    ),
                    Center(
                      child: Text(
                        'Kualitas Tanah',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.6)
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Center(
                      child: Text(
                        widget.args.kualitasTanah,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Hasil',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'N : ${widget.args.n} ppm',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'P : ${widget.args.p} ppm',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'K : ${widget.args.k} ppm',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),

                        Column(
                          children: [
                            Text(
                              'Rekomendasi',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'N : 2000-5000 ppm',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'P : 218-235 ppm',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'K : 201 - 400 ppm',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 24.h),

                    Text(
                      'Rekomendasi Pupuk Dasar',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _landCubit.fertilizerList.length,
                      itemBuilder: (context, index) => _fertilizerItem(context, index)
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fertilizerItem(BuildContext context, int index) {
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
          child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 16.w),
                  child: CachedNetworkImage(
                    imageUrl: _landCubit.fertilizerList[index].foto ?? "",
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _landCubit.fertilizerList[index].nama! + " (${_landCubit.fertilizerList[index].takaran} Kg)",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      _landCubit.fertilizerList[index].komposisi ?? "16-16-16",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
