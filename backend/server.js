const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

const countries = {
  Nigeria: {
    capital: 'Abuja',
    population: 232679478,
    region: 'Africa'
  },
  Ghana: {
    capital: 'Accra',
    population: 34121985,
    region: 'Africa'
  },
  Kenya: {
    capital: 'Nairobi',
    population: 56432944,
    region: 'Africa'
  },
  UnitedKingdom: {
    capital: 'London',
    population: 69300000,
    region: 'Europe'
  },
  Canada: {
    capital: 'Ottawa',
    population: 41417056,
    region: 'Americas'
  },
  UnitedStates: {
    capital: 'Washington, D.C.',
    population: 340110988,
    region: 'Americas'
  },
  France: {
    capital: 'Paris',
    population: 66650000,
    region: 'Europe'
  },
  Japan: {
    capital: 'Tokyo',
    population: 123000000,
    region: 'Asia'
  }
};

app.get('/api/destinations', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM destinations ORDER BY id DESC'
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/api/destinations', async (req, res) => {
  try {
    const { country } = req.body;

    const key = country.replace(/[\s.]+/g, '');
    const countryInfo = countries[key];

    if (!countryInfo) {
      return res.status(404).json({
        error: 'Country not found in local dataset'
      });
    }

    const result = await pool.query(
      `INSERT INTO destinations
       (country, capital, population, region)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [
        country,
        countryInfo.capital,
        countryInfo.population,
        countryInfo.region
      ]
    );

    res.status(201).json(result.rows[0]);

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.delete('/api/destinations/:id', async (req, res) => {
  try {
    await pool.query(
      'DELETE FROM destinations WHERE id = $1',
      [req.params.id]
    );

    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
