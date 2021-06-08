const dns = require("dns");
const arg = require("arg");

const args = arg({
  // Types
  "--domain": String,

  // Aliases
  "-d": "--domain",
  "-h": "--help", // -n <string>; result is stored in --name
});
if (!args["--domain"]) console.exception("missing required argument: --domain");
dns.lookup(args["--domain"], (err, address, family) => {
  console.log("本地缓存地址: %j 地址族: IPv%s", address, family);
});

dns.resolve(args["--domain"], (err, address, family) => {
  console.log("实际地址: %j 地址族: IPv%s", address, family);
});
