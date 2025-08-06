part of weather_forecasting;

const baseUrl = 'https://api.openweathermap.org/data/2.5';
const weeklyWeatherUrl =
    'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';

const apiKey = String.fromEnvironment('WEATHER_API_KEY');
