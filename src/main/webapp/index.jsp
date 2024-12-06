<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weather Data Processor</title>
    <style>
        :root {
            --bg-primary: #121212;
            --bg-secondary: #1e1e1e;
            --text-primary: #e0e0e0;
            --text-secondary: #b0b0b0;
            --accent-color: #4a90e2;
            --border-color: #333;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            background-color: var(--bg-secondary);
            border-radius: 12px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        h1 {
            text-align: center;
            color: var(--accent-color);
            margin-bottom: 20px;
            font-size: 2rem;
        }

        h3 {
            color: var(--text-secondary);
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 10px;
            margin-bottom: 15px;
        }

        form {
            background-color: var(--bg-primary);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid var(--border-color);
        }

        input[type="text"], 
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            background-color: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            color: var(--text-primary);
            outline: none;
        }

        input[type="text"]:focus, 
        select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: var(--accent-color);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #3a7bd5;
            transform: translateY(-2px);
        }

        input[type="submit"]:active {
            transform: translateY(1px);
        }

        input::placeholder {
            color: var(--text-secondary);
        }

        @media (max-width: 600px) {
            .container {
                width: 95%;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Weather Data Processor</h1>
        
        <!-- <form action="report.jsp" method="POST">
            <h3>Generate Report</h3>
            <input type="text" name="startDate" placeholder="Start Date (YYYY-MM-DD)">
            <input type="text" name="endDate" placeholder="End Date (YYYY-MM-DD)">
            
            <select name="parameter">
                <option value="temperature">Temperature</option>
                <option value="humidity">Humidity</option>
                <option value="rainfall">Rainfall</option>
            </select>
            
            <input type="submit" value="Generate Report">
        </form> -->
        
        <form action="report.jsp" method="POST">
    <h3>Generate Report</h3>
    <input type="text" name="startDate" placeholder="Start Date (YYYY-MM-DD)">
    <input type="text" name="endDate" placeholder="End Date (YYYY-MM-DD)">

    <select name="parameter">
        <option value="temperature">Temperature</option>
        <option value="humidity">Humidity</option>
        <option value="rainfall">Rainfall</option>
    </select>

    <select name="place">
        <option value="all">All Locations</option>
        <option value="Ahmedabad">Ahmedabad</option>
        <option value="Bangalore">Bangalore</option>
        <option value="chennai">Chennai</option>
        <option value="Delhi">Delhi</option>
        <option value="Hyderabad">Hyderabad</option>
        <option value="Kolkata">Kolkata</option>
        <option value="Jaipur">Jaipur</option>
        <option value="pune">Pune</option>
        <option value="Kochi">Kochi</option>
        <option value="Mumbai">Mumbai</option>
        
    </select>

    <input type="submit" value="Generate Report">
</form>
        
        
        

        <form action="search.jsp" method="POST">
            <h3>Search Data</h3>
            <input type="text" name="query" placeholder="Enter search query">
            
            <select name="type">
                <option value="date">Date</option>
                <option value="location">Location</option>
            </select>
            
            <input type="submit" value="Search">
        </form>
    </div>
</body>
</html>