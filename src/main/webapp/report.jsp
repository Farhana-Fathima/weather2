<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="weather2.WeatherDataProcessor" %>
<%@ page import="weather2.WeatherData" %>
<%
String filePath = "D:\\input\\weth.csv";
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String parameter = request.getParameter("parameter");

List<WeatherData> data = WeatherDataProcessor.readAndCleanCSV(filePath);
String report = WeatherDataProcessor.generateReport(data, startDate, endDate, parameter);

// Extract key statistics for meters
double avgTemp = WeatherDataProcessor.calculateAverage(data, "temperature");
double avgHumidity = WeatherDataProcessor.calculateAverage(data, "humidity");
double avgRainfall = WeatherDataProcessor.calculateAverage(data, "rainfall");
%> --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="weather2.WeatherDataProcessor" %>
<%@ page import="weather2.WeatherData" %>
<%
String filePath = "D:\\input\\weth.csv";
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String parameter = request.getParameter("parameter");
String location = request.getParameter("place");

List<WeatherData> data = WeatherDataProcessor.readAndCleanCSV(filePath);

// Filter data by selected place if not "all"
if (!"all".equalsIgnoreCase(location)) {
    data = WeatherDataProcessor.filterByPlace(data, location);
}

// Generate report and calculate statistics
String report = WeatherDataProcessor.generateReport(data, startDate, endDate, parameter, location);
double avgTemp = WeatherDataProcessor.calculateAverage(data, "temperature");
double avgHumidity = WeatherDataProcessor.calculateAverage(data, "humidity");
double avgRainfall = WeatherDataProcessor.calculateAverage(data, "rainfall");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weather Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-primary: #121212;
            --bg-secondary: #1e1e1e;
            --text-primary: #e0e0e0;
            --text-secondary: #b0b0b0;
            --accent-color: #4a90e2;
            --border-color: #333;
            --low-color: #4CAF50;
            --medium-color: #FFC107;
            --high-color: #F44336;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .report-container {
            background-color: var(--bg-secondary);
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 800px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h1 {
            text-align: center;
            color: var(--accent-color);
            margin-bottom: 25px;
            font-size: 2.5rem;
            letter-spacing: -1px;
            animation: slideDown 0.7s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .report-content {
            background-color: var(--bg-primary);
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
            animation: contentReveal 0.8s ease-out;
        }

        @keyframes contentReveal {
            from {
                max-height: 0;
                opacity: 0;
                overflow: hidden;
            }
            to {
                max-height: 1000px;
                opacity: 1;
            }
        }

        .meters-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        .meter-group {
            background-color: var(--bg-secondary);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .meter-group:hover {
            transform: scale(1.05);
        }

        .meter-label {
            color: var(--text-secondary);
            margin-bottom: 10px;
        }

        .meter {
            width: 100%;
            height: 25px;
            background-color: var(--bg-primary);
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            margin-top: 10px;
        }

        .meter-value {
            height: 100%;
            width: 0;
            transition: width 0.8s cubic-bezier(0.25, 0.1, 0.25, 1);
            position: absolute;
            top: 0;
            left: 0;
        }

        .low { background-color: var(--low-color); }
        .medium { background-color: var(--medium-color); }
        .high { background-color: var(--high-color); }

        .back-link {
            display: block;
            text-align: center;
            padding: 12px 20px;
            background-color: var(--accent-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .back-link:hover {
            background-color: #3a7bd5;
        }

        @media (max-width: 768px) {
            .meters-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="report-container">
        <h1>Weather Report</h1>
        
        <div class="report-content">
            <p><%= report %></p>
        </div>

        <%-- <div class="meters-container">
            <div class="meter-group">
                <div class="meter-label">Temperature</div>
                <div class="meter">
                    <div id="tempMeter" class="meter-value"></div>
                </div>
                <div class="meter-label"><%= String.format("%.1f°C", avgTemp) %></div>
            </div>

            <div class="meter-group">
                <div class="meter-label">Humidity</div>
                <div class="meter">
                    <div id="humidityMeter" class="meter-value"></div>
                </div>
                <div class="meter-label"><%= String.format("%.1f%%", avgHumidity) %></div>
            </div>

            <div class="meter-group">
                <div class="meter-label">Rainfall</div>
                <div class="meter">
                    <div id="rainfallMeter" class="meter-value"></div>
                </div>
                <div class="meter-label"><%= String.format("%.1f mm", avgRainfall) %></div>
            </div>
        </div> --%>

        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>

    <%-- <script>
        function updateMeter(meterId, value, type) {
            const meter = document.getElementById(meterId);
            let width = 0;
            let meterClass = '';

            switch(type) {
                case 'temperature':
                    width = value > 30 ? 100 : (value > 15 ? (value - 15) * 6.666 : value * 6.666);
                    meterClass = value > 30 ? 'high' : (value > 15 ? 'medium' : 'low');
                    break;
                case 'humidity':
                    width = value > 70 ? 100 : (value > 30 ? (value - 30) * 2.333 : value * 3.333);
                    meterClass = value > 70 ? 'high' : (value > 30 ? 'medium' : 'low');
                    break;
                case 'rainfall':
                    width = value > 30 ? 100 : (value > 10 ? (value - 10) * 5 : value * 10);
                    meterClass = value > 30 ? 'high' : (value > 10 ? 'medium' : 'low');
                    break;
            }

            meter.style.width = `${width}%`;
            meter.className = `meter-value ${meterClass}`;
        }

        // Update meters with actual values
        updateMeter('tempMeter', <%= avgTemp %>, 'temperature');
        updateMeter('humidityMeter', <%= avgHumidity %>, 'humidity');
        updateMeter('rainfallMeter', <%= avgRainfall %>, 'rainfall');
    </script> --%>
</body>
</html>
