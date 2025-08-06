part of weather_forecasting;

class TodayExtraData extends StatelessWidget {
  final HourlyWeatherData todayWeather;
  const TodayExtraData(this.todayWeather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(35)),
      ),
      child: Column(
        children: [
          Text(
            "${todayWeather.main.temp.round()}\u00B0",
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Image(
            image: AssetImage(todayWeather.image),
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenHeight(50),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Text(
            todayWeather.time,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: getProportionateScreenHeight(16),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class TodayExtraDataShimmer extends StatelessWidget {
  const TodayExtraDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[500]!,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(15)),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.white),
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(35)),
        ),
        child: Column(
          children: [
            // Temperature Placeholder
            Container(
              height: getProportionateScreenHeight(20),
              width: getProportionateScreenWidth(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            // Image Placeholder
            Container(
              width: getProportionateScreenWidth(50),
              height: getProportionateScreenHeight(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            // Time Placeholder
            Container(
              height: getProportionateScreenHeight(16),
              width: getProportionateScreenWidth(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
