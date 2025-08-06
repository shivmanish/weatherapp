part of weather_forecasting;

class MarkerInfoSheet extends StatelessWidget {
  final LatLng position;
  const MarkerInfoSheet({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: getValue('Position Info'),
          ),
          BlocProvider<MapBloc>(
            create:
                (context) =>
                    getIt<MapBloc>()..add(
                      GetMarkerInfoData(
                        latLong: LatLong(
                          lat: position.latitude,
                          long: position.longitude,
                        ),
                      ),
                    ),
            child: BlocBuilder<MapBloc, MapState>(
              buildWhen: (previous, current) {
                return current.info == UpdateInfo.marker;
              },
              builder: (context, state) {
                if (state is MarkerInfoLoaded) {
                  final info = state.markerInfo;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          getValue('${info.temp} °C'),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          getTitle('Temp'),
                        ],
                      ),
                      Column(
                        children: [
                          getValue('${info.humidity} %'),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          getTitle('Humidity'),
                        ],
                      ),
                    ],
                  );
                }
                return _loading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getValue(String value) {
    return Text(
      value,
      style: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w700,
        fontSize: getProportionateScreenHeight(16),
      ),
    );
  }

  Widget getTitle(String value) {
    return Text(
      value,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.black54,
        fontSize: getProportionateScreenHeight(16),
      ),
    );
  }

  Widget _loading() {
    return Shimmer.fromColors(
      baseColor: Colors.blue[300]!,
      highlightColor: Colors.blue[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(2, (_) => _buildShimmerColumn()),
      ),
    );
  }

  Widget _buildShimmerColumn() {
    return Column(
      children: [
        Container(
          width: getProportionateScreenWidth(60),
          height: getProportionateScreenHeight(16),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),

        Container(
          width: getProportionateScreenWidth(50),
          height: getProportionateScreenHeight(14),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
