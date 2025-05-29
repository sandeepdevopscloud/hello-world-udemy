<!DOCTYPE html>
<html>
<head>
  <title>Sample Form</title>
</head>
<body>
  <h2>Registration Form</h2>

  <form action="/submit-form" method="post">
    <label for="fullname">Full Name:</label><br>
    <input type="text" id="fullname" name="fullname" required><br><br>

    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password" required><br><br>

    <label>Gender:</label><br>
    <input type="radio" id="male" name="gender" value="male">
    <label for="male">Male</label><br>
    <input type="radio" id="female" name="gender" value="female">
    <label for="female">Female</label><br><br>

    <label for="message">Message:</label><br>
    <textarea id="message" name="message" rows="4" cols="30"></textarea><br><br>

    <input type="submit" value="Submit">
  </form>

</body>
</html>

