require("@nomicfoundation/hardhat-toolbox");
require("hardhat-gas-reporter");
require("dotenv").config();

module.exports = {
  solidity: {
    version: "0.8.16",
    settings: {
      optimizer: {
          enabled: true,
          runs: 200,
      }
    }
  },

  gasReporter: {
    enabled: true && process.env.COINMARKETCAP_API_KEY,
    gasPrice: 15,
    currency: "ETH",
    coinmarketcap: process.env.COINMARKETCAP_API_KEY
  }
};