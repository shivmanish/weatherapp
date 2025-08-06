part of weather_forecasting;

class SevenDaysView extends StatefulWidget {
  const SevenDaysView({super.key});

  @override
  State<SevenDaysView> createState() => _SevenDaysViewState();
}

class _SevenDaysViewState extends State<SevenDaysView> {
  WeeklyWeather? weeklyWeather;

  @override
  void initState() {
    context.read<WeatherBloc>().add(GetWeeklyWeatherForLatLong());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "7 days Weather",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        BlocBuilder<WeatherBloc, WeatherState>(
          buildWhen: (previous, current) {
            return (current.type == WeatherType.weekly ||
                current.type == WeatherType.initial);
          },
          builder: (context, state) {
            if (state is Error && state.type == WeatherType.weekly) {
              return ErrorOrEmptyContainer(
                message: 'Somthing went wrong while getting weekly data',
              );
            }
            if ((state is Loading || state is Empty) &&
                (state.type == WeatherType.weekly ||
                    state.type == WeatherType.initial)) {
              return loadingWidget();
            }
            if (state is WeeklyWeatherLoaded) {
              weeklyWeather = state.weeklyWeatherData;

              return weeklyTile(weeklyWeather!.sevenDayWeatherdata);
            }
            return loadingWidget();
          },
        ),
      ],
    );
  }

  Widget weeklyTile(List<WeeklyWeatherData> weekData) {
    if (weekData.isEmpty) {
      return ErrorOrEmptyContainer(
        message:
            'No weekly forcasting weather info available for this location',
        forError: false,
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: weekData.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return WeeklyWeatherTile(weatherData: weekData[index]);
        },
      );
    }
  }

  Widget loadingWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return WeatherCardShimmer();
        },
      ),
    );
  }
}
