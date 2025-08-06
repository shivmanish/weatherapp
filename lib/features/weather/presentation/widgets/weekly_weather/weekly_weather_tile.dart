part of weather_forecasting;

class WeeklyWeatherTile extends StatelessWidget {
  final WeeklyWeatherData weatherData;
  const WeeklyWeatherTile({required this.weatherData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getProportionateScreenWidth(10),
        left: getProportionateScreenWidth(10),
        right: getProportionateScreenWidth(10),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Theme.of(context).colorScheme.surface,
        ),
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(35)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenHeight(20),
        vertical: getProportionateScreenHeight(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            weatherData.day,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              decoration: TextDecoration.none,
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(125),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(weatherData.image),
                  width: getProportionateScreenWidth(30),
                ),
                SizedBox(width: getProportionateScreenWidth(15)),
                Flexible(
                  child: Text(
                    weatherData.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      decoration: TextDecoration.none,
                      fontSize: getProportionateScreenHeight(15),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "+${weatherData.max.round()}\u00B0",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  decoration: TextDecoration.none,
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(5)),
              Text(
                "+${weatherData.min.round()}\u00B0",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: getProportionateScreenHeight(15),
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherCardShimmer extends StatelessWidget {
  const WeatherCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(35),
          border: Border.all(width: 0.2, color: Colors.white),
        ),
        child: Row(
          children: [
            // Left icon placeholder
            Expanded(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
