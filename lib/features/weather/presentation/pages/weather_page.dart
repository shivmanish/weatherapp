part of weather_forecasting;

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 5),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getIt<AppRouter>().push(MapPage());
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
      create: (_) => getIt(),
      child: Column(
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
      ),
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
}
