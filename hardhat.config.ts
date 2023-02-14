import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";
dotenv.config();


const config: HardhatUserConfig = {
  solidity: "0.8.17",

  networks:{
    goerli:{
      url:process.env.GOERLI_RPC,
    // @ts-ignore
      accounts:[process.env.PRIVATEKEY1, process.env.PRIVATEKEY2, process.env.PRIVATEKEY3, process.env.PRIVATEKEY4],
    }
  }
};

export default config;
