const { Player } = require("../models");
// preloaded mängijad
(async () => {
  await Player.bulkCreate([
    { name: "Lionel Messi", position: "Forward", number: 10 },
    { name: "Virgil van Dijk", position: "Defender", number: 4 },
    { name: "Thibaut Courtois", position: "Goalkeeper", number: 1 },
  ]);
  console.log("Players seeded!");
  process.exit();
})();
