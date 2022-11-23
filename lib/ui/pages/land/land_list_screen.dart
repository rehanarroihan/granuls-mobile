import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/cubit/land/land_cubit.dart';
import 'package:granuls/ui/pages/land/create_land_screen.dart';
import 'package:granuls/ui/pages/land/land_testing_result_screen.dart';
import 'package:granuls/ui/widgets/base/reactive_refresh_indicator.dart';

class LandListScreen extends StatefulWidget {
  const LandListScreen({Key? key}) : super(key: key);

  @override
  _LandListScreenState createState() => _LandListScreenState();
}

class _LandListScreenState extends State<LandListScreen> {
  late LandCubit _landCubit;

  @override
  void initState() {
    super.initState();

    _landCubit = BlocProvider.of<LandCubit>(context);

    _landCubit.getLandList();
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
                'Pengelolaan Lahan',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  tooltip: 'Tambah Lahan Baru',
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CreateLandScreen()
                  )),
                )
              ],
            ),
            body: ReactiveRefreshIndicator(
              isRefreshing: _landCubit.isLandListLoading,
              onRefresh: () => _landCubit.getLandList(),
              child: _buildBody()
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_landCubit.isLandListLoading) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
      );
    } else {
      if (_landCubit.landList.isNotEmpty) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _landCubit.landList.length,
          itemBuilder: (context, index) => _landItem(context, index)
        );
      } else {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Belum ada lahan, silahkan buat baru')
            ],
          ),
        );
      }
    }
  }

  Widget _landItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => LandTestingResultScreen(
            args: LandTestingResultScreenArgs(
              idTipeTanah: _landCubit.landList[index].idTipeTanah ?? "",
              idTumbuhan: _landCubit.landList[index].idTumbuhan ?? "",
              n: _landCubit.landList[index].n!.floor(),
              p: _landCubit.landList[index].p!.floor(),
              k: _landCubit.landList[index].k!.floor(),
              kualitasTanah: _landCubit.landList[index].tipe!
            ),
          )
        ));
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
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                Expanded(
                  child: Text(
                    _landCubit.landList[index].title ?? "Lahan",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
