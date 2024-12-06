package weather2;

public class WeatherData {
	
        String date;
        String location;
        double temperature;
        double humidity;
        double rainfall;
        

        public WeatherData(String date, String location, double temperature, double humidity, double rainfall) {
            this.date = date;
            this.location = location;
            this.temperature = temperature;
            this.humidity = humidity;
            this.rainfall = rainfall;
        }

		public String getDate() {
			return date;
		}

		public String getLocation() {
			return location;
		}

		public double getTemperature() {
			return temperature;
		}

		public double getHumidity() {
			return humidity;
		}

		public double getRainfall() {
			return rainfall;
		}

		public String getPlace() {
			
			return location;
		}
		

}
