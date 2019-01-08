const HDWalletProvider = require("truffle-hdwallet-provider");
module.exports = {
networks: {
  development: {
   host: "127.0.0.1",
   port: 9545,
   network_id: "*" // Match any network id
 },
 rinkeby: {
  provider: function() {
 return new HDWalletProvider("cover general conduct soccer veteran mechanic layer fiscal limb fever deposit leader", "https://rinkeby.infura.io/v3/73c9836db4874832bcb4ec8caa392472")
     },
      network_id: '4',
      gas: 4500000,
      gasPrice: 10000000000,
    }
   }
 };