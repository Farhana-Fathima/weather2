package weather2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class WeatherDataProcessor {

    // Method to read CSV and return cleaned data
    public static List<WeatherData> readAndCleanCSV(String filePath) {
        List<WeatherData> weatherDataList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            br.readLine(); // Skip header
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");
                try {
                    String date = values[0].trim();
                    String location = values[1].trim();
                    double temperature = Double.parseDouble(values[2].trim());
                    double humidity = Double.parseDouble(values[3].trim());
                    double rainfall = Double.parseDouble(values[4].trim());
                    weatherDataList.add(new WeatherData(date, location, temperature, humidity, rainfall));
                } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                    // Skip malformed rows
                    System.out.println("Skipping invalid row: " + line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return weatherDataList;
    }

    // Method to calculate average statistics
    public static String generateReport(List<WeatherData> data, String startDate, String endDate, String parameter, String location) {
        double total = 0;
        int count = 0;

        for (WeatherData wd : data) {
            if (wd.date.compareTo(startDate) >= 0 && wd.date.compareTo(endDate) <= 0) {
                switch (parameter.toLowerCase()) {
                    case "temperature":
                        total += wd.temperature;
                        break;
                    case "humidity":
                        total += wd.humidity;
                        break;
                    case "rainfall": 
                        total += wd.rainfall;
                        break;
                    default:
                        return "Invalid parameter!";
                }
                count++;
            }
        }

        if (count == 0) return "No data found for the specified period.";
        return "Average "+" " + parameter +" "+ " from " +" "+ startDate +" "+ " to "+" " + endDate +" "+ "at"+" "+ location +" " + "is" +" "+ (total / count);
    }

    // Method to search by date or location
    public static List<WeatherData> search(List<WeatherData> data, String query, String type) {
        List<WeatherData> result = new ArrayList<>();
        for (WeatherData wd : data) {
            if (type.equalsIgnoreCase("date") && wd.date.equals(query)) {
                result.add(wd);
            } else if (type.equalsIgnoreCase("location") && wd.location.equalsIgnoreCase(query)) {
                result.add(wd);
            }
        }
        return result;
    }
    
    
    public static List<WeatherData> filterByPlace(List<WeatherData> data, String location) {
        List<WeatherData> filteredData = new ArrayList<>();
        for (WeatherData record : data) {
            if (record.getPlace().equalsIgnoreCase(location)) {
                filteredData.add(record);
            }
        }
        return filteredData;
    }

    
    public static double calculateAverage(List<WeatherData> data, String parameter) {
        if (data == null || data.isEmpty()) {
            return 0.0;
        }

        double sum = 0.0;
        int count = 0;

        for (WeatherData entry : data) {
            switch (parameter.toLowerCase()) {
                case "temperature":
                    sum += entry.getTemperature();
                    count++;
                    break;
                case "humidity":
                    sum += entry.getHumidity();
                    count++;
                    break;
                case "rainfall":
                    sum += entry.getRainfall();
                    count++;
                    break;
                default:
                    return 0.0;
            }
        }

        return count > 0 ? sum / count : 0.0;
    }
}


