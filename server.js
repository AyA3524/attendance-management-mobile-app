const express = require('express');
const sql = require('mssql');
const app = express();
const PORT = 3000;

const cors = require('cors');
app.use(cors());
app.use(express.json());

// Configuration for SQL Server database
const config = {
  server: 'localhost',
  database: 'attendance management app ',
  user: 'sa',
  password: '2004',
  options: {
    encrypt: false
  }
};

// API endpoint to handle user authentication
app.post('/login', async (req, res) => {
  const { id, password } = req.body;

  try {
    await sql.connect(config);
    const result = await sql.query`SELECT * FROM Employees WHERE EmployeeID= ${id} AND Password = ${password}`;

    if (result.recordset.length > 0) {
      // User authenticated successfully
      res.status(200).json({ success: true, message: 'Login successful' });
    } else {
      // Authentication failed
      res.status(401).json({ success: false, message: 'Invalid username or password' });
    }
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ success: false, message: 'An error occurred during authentication' });
  } finally {
    await sql.close();
  }
});

// API endpoint to get all employees
app.get('/employees', async (req, res) => {
  try {
    await sql.connect(config);
    const result = await sql.query`SELECT * FROM Employees`;

    if (result.recordset.length > 0) {
      console.log('Employees:', result.recordset); // Log the data to the console
      res.status(200).json({ success: true, data: result.recordset });
    } else {
      console.log('No employees found');
      res.status(404).json({ success: false, message: 'No employees found' });
    }
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ success: false, message: 'An error occurred while fetching employees' });
  } finally {
    await sql.close();
  }
});


app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
