const app = require('./app');
const PORT = process.env.PORT || 8000;

app.listen(3000, () => {
  console.log(`App is running on http://localhost:${PORT}`);
});