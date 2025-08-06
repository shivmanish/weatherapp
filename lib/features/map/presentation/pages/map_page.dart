part of weather_forecasting;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng latLng;
  late CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _tappedLatLng;
  ValueNotifier<bool> isTempMap = ValueNotifier<bool>(false);
  late MapBloc bloc;

  @override
  void initState() {
    latLng = const LatLng(0.0, 0.0);
    initialCameraPosition = CameraPosition(target: latLng, zoom: 1);
    bloc = getIt<MapBloc>();
    super.initState();
  }

  void updateInitialPosition() async {
    initialCameraPosition = CameraPosition(target: latLng, zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 12)),
    );
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _tappedLatLng = position;
    });
    // bloc.add(
    //   GetMarkerInfoData(
    //     latLong: LatLong(lat: position.latitude, long: position.longitude),
    //   ),
    // );
    _showMarkerInfoSheet(position);
  }

  Marker getMarker(LatLng position, {bool isCurrentLocation = true}) {
    return Marker(
      markerId:
          isCurrentLocation
              ? const MarkerId('currentLocation')
              : const MarkerId('tappedLocation'),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        isCurrentLocation ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed,
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    if (latLng.latitude != 0.0 && latLng.longitude != 0.0) {
      markers.add(getMarker(latLng));
    }
    if (_tappedLatLng != null) {
      markers.add(getMarker(_tappedLatLng!, isCurrentLocation: false));
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) => bloc..add(GetCurrentLocation()),
      child: Scaffold(
        appBar: AppBar(title: Row(children: [Text('Map Page')])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isTempMap.value) {
              bloc.add(const GetTempAndPrepForMap("precipitation_new"));
            } else {
              bloc.add(const GetTempAndPrepForMap("temp_new"));
            }
            isTempMap.value = !isTempMap.value;
          },
          isExtended: true,
          child: ValueListenableBuilder<bool>(
            valueListenable: isTempMap,
            builder: (ctx, value, child) {
              return Icon(
                isTempMap.value ? Icons.local_fire_department : Icons.cloud,
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: BlocBuilder<MapBloc, MapState>(
          buildWhen: (previous, current) {
            return current.info == UpdateInfo.map;
          },
          builder: (context, state) {
            if (state is CurrentLocationLoaded) {
              latLng = LatLng(state.latLong.lat, state.latLong.long);
              updateInitialPosition();
            }
            return GoogleMap(
              tileOverlays: {
                isTempMap.value
                    ? TileOverlay(
                      tileOverlayId: const TileOverlayId(
                        'precipitation_new_id',
                      ),
                      tileProvider: tileProvider("precipitation_new"),
                    )
                    : TileOverlay(
                      tileOverlayId: const TileOverlayId('temp_new_id'),
                      tileProvider: tileProvider("temp_new"),
                    ),
              },
              onMapCreated: (controller) => _controller.complete(controller),
              initialCameraPosition: initialCameraPosition,
              onTap: _onMapTapped,
              markers: _buildMarkers(),
            );
          },
        ),
      ),
    );
  }

  TileProvider tileProvider(String mapType) {
    return GetMap(
      mapType: mapType,
      mapRemoteDataSource: getIt<MapRemoteDataSource>(),
    );
  }

  void _showMarkerInfoSheet(LatLng position) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (ctx) {
        return Builder(
          builder: (context) {
            return MarkerInfoSheet(position: position);
          },
        );
      },
    );
  }
}
