const express = require("express");
const bodyParser = require("body-parser");
const methodOverride = require("method-override");
const { Player } = require("./models");

const app = express();
app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride("_method"));

// List players
app.get("/", async (req, res) => {
  const players = await Player.findAll();
  res.render("index", { players });
});

// Create player
app.post("/players", async (req, res) => {
  await Player.create({
    name: req.body.name,
    position: req.body.position,
    number: req.body.number,
  });
  res.redirect("/");
});

// Delete player
app.delete("/players/:id", async (req, res) => {
  await Player.destroy({ where: { id: req.params.id } });
  res.redirect("/");
});

// Update player
app.put("/players/:id", async (req, res) => {
  await Player.update(
    {
      name: req.body.name,
      position: req.body.position,
      number: req.body.number,
    },
    { where: { id: req.params.id } }
  );
  res.redirect("/");
});

app.listen(3000, () => console.log("Server running at http://localhost:3000"));
