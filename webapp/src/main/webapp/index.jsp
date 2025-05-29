<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sample Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: auto;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="number"],
        input[type="date"],
        select,
        textarea {
            width: calc(100% - 22px); /* Account for padding and border */
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Ensures padding and border are included in the element's total width and height */
        }
        input[type="radio"],
        input[type="checkbox"] {
            margin-right: 5px;
        }
        .radio-group, .checkbox-group {
            margin-bottom: 20px;
        }
        .radio-group label, .checkbox-group label {
            display: inline-block;
            font-weight: normal;
            margin-bottom: 0;
            margin-right: 15px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
            color: #777;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Registration Form</h2>
        <form action="/submit_form" method="post">
            
            <label for="fullName">Full Name:</label>
            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>

            <label for="email">Email Address:</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

            <label for="age">Age:</label>
            <input type="number" id="age" name="age" min="18" max="99" placeholder="Enter your age">

            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" required>

            <label for="gender">Gender:</label>
            <div class="radio-group">
                <input type="radio" id="male" name="gender" value="male">
                <label for="male">Male</label>
                <input type="radio" id="female" name="gender" value="female">
                <label for="female">Female</label>
                <input type="radio" id="other" name="gender" value="other">
                <label for="other">Other</label>
            </div>

            <label for="country">Country:</label>
            <select id="country" name="country">
                <option value="">--Please select a country--</option>
                <option value="usa">United States</option>
                <option value="canada">Canada</option>
                <option value="uk">United Kingdom</option>
                <option value="india">India</option>
                <option value="australia">Australia</option>
            </select>

            <label for="interests">Interests (select all that apply):</label>
            <div class="checkbox-group">
                <input type="checkbox" id="coding" name="interests" value="coding">
                <label for="coding">Coding</label>
                <input type="checkbox" id="reading" name="interests" value="reading">
                <label for="reading">Reading</label>
                <input type="checkbox" id="sports" name="interests" value="sports">
                <label for="sports">Sports</label>
                <input type="checkbox" id="travel" name="interests" value="travel">
                <label for="travel">Travel</label>
            </div>

            <label for="bio">Short Bio:</label>
            <textarea id="bio" name="bio" rows="4" placeholder="Tell us a little about yourself..."></textarea>

            <button type="submit">Submit Form</button>
        </form>

        <div class="form-footer">
            <p>&copy; 2025 Sample Form. All rights reserved.</p>
        </div>
    </div>

</body>
</html>

