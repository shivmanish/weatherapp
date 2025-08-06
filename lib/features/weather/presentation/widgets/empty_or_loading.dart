part of weather_forecasting;

class EmptyOrLoading extends StatelessWidget {
  const EmptyOrLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
