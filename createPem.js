const fs = require("fs");
const { KeyMaterial } = require("./privateKeyDetails.json");

fs.writeFileSync("./privateKey.pem", KeyMaterial, "utf8");
