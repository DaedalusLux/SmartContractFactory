require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
let secrets = require("./secret.json");



module.exports = {
  defaultNetwork: "mainnet",
  networks: {
    hardhat: {
    },
    mainnet: {
      url: "https://bsc-dataseed1.binance.org",
      accounts: [secrets.Pkey]
    },

    Bsctestnet: {
      // url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      url: "https://rpc-mainnet.maticvigil.com",
      accounts: [secrets.Pkey]
    },

    Matic: {
      url: `https://polygon-mainnet.infura.io/v3/${secrets.InfuraId}`,
      accounts: [secrets.Pkey]
    }
  },

  





  etherscan: {
    apiKey: "XYQXKPT6PCE3EGW9KPPN1X5N5V471SD5KN"
    
  },
  solidity: {
    version: "0.8.16",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },

  mocha: {
    timeout: 40000
  }
}
