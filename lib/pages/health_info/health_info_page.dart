import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testprojectforhealth/core/models/health_data.dart';
import 'package:testprojectforhealth/pages/health_info/cubit/get_health_data_cubit.dart';
import 'package:testprojectforhealth/pages/health_info/widgets/line_chart_info_widget.dart';

class HealthInfoPage extends StatefulWidget {
  const HealthInfoPage({super.key});

  @override
  State<HealthInfoPage> createState() => _HealthInfoPageState();
}

class _HealthInfoPageState extends State<HealthInfoPage> {
  @override
  void initState() {
    BlocProvider.of<GetHealthDataCubit>(context).getHealthData();
    super.initState();
  }

  Future<void> _onRefresh() async {
    await BlocProvider.of<GetHealthDataCubit>(context).getHealthData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            debugPrint("pressed back button");
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: BlocConsumer<GetHealthDataCubit, GetHealthDataState>(
            bloc: BlocProvider.of<GetHealthDataCubit>(context),
            listener: (context, state) {
              if (state is GetHealthDataError) {
                debugPrint("error: ${state.message}");
              }
            },
            builder: (context, state) {
              if (state is GetHealthDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetHealthDataSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    title("Dynamics"),
                    subTitle("All Period"),
                    const SizedBox(
                      height: 20,
                    ),
                    LineChartSample2(
                      data: state.data.dynamics,
                    ),
                    alertsMessages(
                      state.data.alerts,
                    ),
                    dataInfo(
                      state.data.dynamics,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xff1A1A1A),
      ),
    );
  }

  Widget subTitle(String subTitle) {
    return Text(
      subTitle,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xff828282),
      ),
    );
  }

  Widget alertsMessages(List<Alert> data) {
    return Column(
      children: data
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xffF9FAFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.message ?? "Undefined error",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xff828282),
                    ),
                  ),
                  e.resubmitLink != null
                      ? e.resubmitLink!
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    debugPrint("Resubmit requested");
                                  },
                                  child: const Text(
                                    "Resubmit the markers",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff005EFF),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container()
                      : Container(),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget dataInfo(List<Dynamic> data) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                "Дата",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xffB0B0B0),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                "ME/мл",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xffB0B0B0),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        Column(
          children: data
              .map(
                (e) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("dd MMM").format(e.date!),
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(
                                    0xff1A1A1A,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Text(
                                "${e.lab}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Color(
                                    0xff828282,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${e.value}",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              color: e.value! >= 2.8
                                  ? const Color(0xff27A474)
                                  : const Color(0xffFFA100),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
