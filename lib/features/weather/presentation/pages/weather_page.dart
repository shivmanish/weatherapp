part of weather_forecasting;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  ValueNotifier<bool> hasPermission = ValueNotifier<bool>(false);
  late final WeatherBloc weatherBloc;
  @override
  void initState() {
    weatherBloc = getIt<WeatherBloc>();
    super.initState();
  }

  void showToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location permission is required to proceed.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _retryLoactionPermission() {
    weatherBloc.add(GetLoactionPermission());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 5),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (hasPermission.value) {
            getIt<AppRouter>().push(MapPage());
          } else {
            showToast();
          }
        },
        child: Icon(
          Icons.map,
          size: getProportionateScreenHeight(30),
          color: Colors.white,
        ),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<WeatherBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => weatherBloc..add(GetLoactionPermission()),
      child: ValueListenableBuilder(
        valueListenable: hasPermission,
        builder: (context, value, child) {
          return value
              ? screenWidget()
              : Column(children: [_permissionCheck(context)]);
        },
      ),
    );
  }

  Widget screenWidget() {
    return Column(
      children: [
        _appBar(context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CurrentWeatherView(),
                TodaysWeatherView(),
                SevenDaysView(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(15)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  getIt<AppRouter>().push(SearchPage());
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(
                        "Search weather by city name",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, size: 27),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _permissionCheck(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) {
        return current.type == WeatherType.locationPermission ||
            current.type == WeatherType.initial;
      },
      builder: (context, state) {
        if (state is Error && state.type == WeatherType.locationPermission) {
          return _loading(
            context,
            child: ErrorOrEmptyContainer(message: state.message),
          );
        }
        if (state is LocationPerissionLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            hasPermission.value = true;
          });
        }

        return _loading(context);
      },
    );
  }

  Widget _loading(BuildContext context, {Widget? child}) {
    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(getProportionateScreenWidth(50)),
            bottomRight: Radius.circular(getProportionateScreenWidth(50)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child ??
                Text(
                  "Checking location permission ...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            if (child == null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            if (child != null)
              IconButton(
                onPressed: () {
                  _retryLoactionPermission();
                },
                icon: const Icon(Icons.refresh, size: 50),
              ),
          ],
        ),
      ),
    );
  }
}
