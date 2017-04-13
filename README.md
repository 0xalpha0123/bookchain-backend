#### Purpose
This is Bookchain, it is a decentralized virtual library to keep track of your physical library. Library? Yes, we do mean books.
This app consists of two components, this is the back-end portion. The front-end
is written in React, and is located here [Bookchain-react](https://github.com/Sh1pley/bookchain-react). This repository is written in Solidity and is built upon the block chain.

#### Getting Started
1. This project is built in Solidity, want more info? See the resources section
   below.
2. git clone or fork this repository `$ git clone https://github.com/njgheorghita/bookchain.git`
3. Install Solidity `$ npm install -g solc`
4. Install Truffle `$ npm install -g truffle`
5. Install Testrpc `$ npm install ethereumjs-testrpc`

#### Running
1. Run `$ truffle migrate` this will migrate the contracts

#### Testing
1. In a separate terminal session run `$ testrpc`

*Running the command `testrpc`, runs the localhost blockchain on port 8545*

2. Run `$ truffle test` this command will run the test suite.

*You can also run `truffle test test/<filename>` to run a single test file
instead of the entire suite*

#### Resources
* [Ethereum](https://www.ethereum.org)
* [Solidity](https://solidity.readthedocs.io/en/develop/#)
* [Truffle](http://truffleframework.com/docs/)
* [Testrpc](https://github.com/ethereumjs/testrpc)
* [Web3](https://github.com/ethereum/web3.j://github.com/ethereum/web3.js)

#### Contributions
1. Fork the repository
2. Find a problem
3. Make a PR
