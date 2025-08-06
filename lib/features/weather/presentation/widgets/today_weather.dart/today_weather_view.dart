part of weather_forecasting;

class TodaysWeatherView extends StatefulWidget {
  const TodaysWeatherView({super.key});

  @override
  State<TodaysWeatherView> createState() => _TodaysWeatherViewState();
}

class _TodaysWeatherViewState extends State<TodaysWeatherView> {
  HourlyWeatherForecast? hourlyWeatherForecast;
  late final GetHourlyWeather getHourlyWeatherUseCase;

  @override
  void initState() {
    super.initState();
    getHourlyWeatherUseCase = getIt<GetHourlyWeather>();
    context.read<WeatherBloc>().add(GetHourlyWeatherForLatLong());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Todays Weather",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: getProportionateScreenWidth(25),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        BlocBuilder<WeatherBloc, WeatherState>(
          buildWhen: (previous, current) {
            return (current.type == WeatherType.forecast ||
                current.type == WeatherType.initial);
          },
          builder: (context, state) {
            if (state is Error && state.type == WeatherType.forecast) {
              return ErrorOrEmptyContainer(
                message: 'Somthing went wromg while getting hpurly data',
              );
            }
            if ((state is Loading || state is Empty) &&
                (state.type == WeatherType.forecast ||
                    state.type == WeatherType.initial)) {
              return loadingWidget();
            }
            if (state is HourlyWeatherLoaded) {
              hourlyWeatherForecast = state.hourlyWeatherData;
              final todayData = getHourlyWeatherUseCase.getWeatherByDate(
                hourlyWeatherList: hourlyWeatherForecast!.hourlyWeatherList,
              );
              return _todayData(todayData);
            }
            return loadingWidget();
          },
        ),
      ],
    );
  }

  Widget _todayData(List<HourlyWeatherData> todayData) {
    if (todayData.isEmpty) {
      return ErrorOrEmptyContainer(
        message: 'No today forcasting weather info available for this location',
        forError: false,
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              todayData.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8),
                ),
                child: TodayExtraData(todayData[index]),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget loadingWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5),
                ),
                child: const TodayExtraDataShimmer(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
