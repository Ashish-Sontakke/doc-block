import Web3 from "web3";

const App = {
  web3: null,
  account: null,

  start: async function () {
    const { web3 } = this;

    try {
      // get contract instance
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = SimpleStorage.networks[networkId];
      this.meta = new web3.eth.Contract(
        SimpleStorage.abi,
        '0x062dAD8F44C29d540c383fB17dA69E760BAEAe08',
      );

      // get accounts
      const accounts = await web3.eth.getAccounts();
      this.account = accounts[0];

      this.loadAccount();
    } catch (error) {
      console.error("Could not connect to contract or chain.");
    }
  },
  loadAccount: async function() {
    console.log("LLLLLLLLLLLLL", this.account);
  },
};

window.App = App;

window.addEventListener("load", function () {
  if (window.ethereum) {
    // use MetaMask's provider
    App.web3 = new Web3(window.ethereum);
    window.ethereum.enable(); // get permission to access accounts
  } else {
    console.warn(
      "No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live"
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    App.web3 = new Web3(
      new Web3.providers.HttpProvider("http://127.0.0.1:8545")
    );
  }

  App.start();
});
