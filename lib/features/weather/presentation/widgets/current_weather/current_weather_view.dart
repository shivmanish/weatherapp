part of weather_forecasting;

class CurrentWeatherView extends StatefulWidget {
  final bool shouldGetWeatherData;
  final Widget? emptyWidget;
  const CurrentWeatherView({
    super.key,
    this.shouldGetWeatherData = true,
    this.emptyWidget,
  });

  @override
  State<CurrentWeatherView> createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  CurrentWeather? currentWeather;

  @override
  void initState() {
    if (widget.shouldGetWeatherData) {
      context.read<WeatherBloc>().add(GetWeatherForLatLong());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(getProportionateScreenWidth(50)),
          bottomRight: Radius.circular(getProportionateScreenWidth(50)),
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          buildWhen: (previous, current) {
            return (current.type == WeatherType.current ||
                current.type == WeatherType.initial);
          },
          builder: (context, state) {
            if (state is Loading && state.type == WeatherType.current) {
              return _loading();
            }
            if (state is Error && state.type == WeatherType.current) {
              return ErrorOrEmptyContainer(
                message:
                    state.message == locationFailureMessage
                        ? state.message
                        : 'Somthing went wrong while getting Current weather data',
              );
            }
            if (state is CurrentWeatherLoaded) {
              currentWeather = state.weather;
            }
            return weatherData();
          },
        ),
      ),
    );
  }

  Widget weatherData() {
    return currentWeather != null
        ? Column(
          children: [
            CurrentMainData(currentWeather!),
            Divider(color: Theme.of(context).colorScheme.surface),
            SizedBox(height: getProportionateScreenHeight(10)),
            CurrentExtraData(currentWeather!),
            SizedBox(height: getProportionateScreenHeight(10)),
          ],
        )
        : widget.emptyWidget ?? _loading();
  }

  Widget _loading() {
    return Column(
      children: [
        CurrentMainDataShimmer(),
        Divider(color: Theme.of(context).colorScheme.surface),
        SizedBox(height: getProportionateScreenHeight(10)),
        CurrentExtraDataShimmer(),
        SizedBox(height: getProportionateScreenHeight(10)),
      ],
    );
  }
}
