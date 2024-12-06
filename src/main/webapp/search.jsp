<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="weather2.WeatherDataProcessor" %>
<%@ page import="weather2.WeatherData" %>
<%
String filePath = "D:\\input\\weth.csv";
String query = request.getParameter("query");
String type = request.getParameter("type");

List<WeatherData> data = WeatherDataProcessor.readAndCleanCSV(filePath);
List<WeatherData> results = WeatherDataProcessor.search(data, query, type);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-primary: #121212;
            --bg-secondary: #1e1e1e;
            --text-primary: #e0e0e0;
            --text-secondary: #b0b0b0;
            --accent-color: #4a90e2;
            --border-color: #333;
            --temp-low: #4CAF50;
            --temp-medium: #FFC107;
            --temp-high: #F44336;
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
            padding: 20px;
            display: flex;
            justify-content: center;
        }

        .search-container {
            background-color: var(--bg-secondary);
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 1000px;
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
        }

        .no-results {
            text-align: center;
            color: var(--text-secondary);
            padding: 20px;
            background-color: var(--bg-primary);
            border-radius: 10px;
        }

        .results-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 20px;
        }

        .results-table th {
            background-color: var(--accent-color);
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .results-table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--border-color);
            background-color: var(--bg-primary);
            transition: background-color 0.3s ease;
        }

        .results-table tr:hover td {
            background-color: rgba(74, 144, 226, 0.1);
        }

        .temperature-cell {
            font-weight: bold;
        }

        .temperature-low {
            color: var(--temp-low);
        }

        .temperature-medium {
            color: var(--temp-medium);
        }

        .temperature-high {
            color: var(--temp-high);
        }

        .back-link {
            display: block;
            text-align: center;
            padding: 12px 20px;
            background-color: var(--accent-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .back-link:hover {
            background-color: #3a7bd5;
        }

        @media (max-width: 768px) {
            .search-container {
                padding: 15px;
            }

            .results-table {
                font-size: 0.9rem;
            }

            .results-table th, 
            .results-table td {
                padding: 8px 10px;
            }
        }
    </style>
</head>
<body>
    <div class="search-container">
        <h1>Search Results</h1>
        
        <%
        if (results.isEmpty()) {
        %>
            <div class="no-results">
                No data found for the query "<%=query %>" by <%=type %>.
            </div>
        <%
        } else {
        %>
            <table class="results-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Temperature</th>
                        <th>Humidity</th>
                        <th>Rainfall</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for (WeatherData wd : results) {
                        // Determine temperature class
                        String tempClass = "temperature-low";
                        if (wd.getTemperature() > 30) {
                            tempClass = "temperature-high";
                        } else if (wd.getTemperature() > 15) {
                            tempClass = "temperature-medium";
                        }
                    %>
                    <tr>
                        <td><%= wd.getDate() %></td>
                        <td><%= wd.getLocation() %></td>
                        <td class="temperature-cell <%= tempClass %>"><%= wd.getTemperature() %>°C</td>
                        <td><%= wd.getHumidity() %>%</td>
                        <td><%= wd.getRainfall() %> mm</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>
</body>
</html>