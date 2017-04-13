pragma solidity ^0.4.8;

contract BookCoin {
  // ERC20 State
  mapping (address => uint256) public balances;
  mapping (address => mapping (address => uint256)) public allowances;
  uint public totalSupply;

  // Human State
  string public name;
  string public symbol;
  string public version;
  uint8 public decimals;

  // Minter State
  address public centralMinter;

  // Backed By Ether State
  uint256 public buyPrice;
  uint256 public sellPrice;

  // ERC20 Events
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  // Modifiers
  modifier onlyMinter { if (msg.sender != centralMinter) throw; _; }

  // Constructor
  function BookCoin(uint256 _initialAmount, address _minter) {
    centralMinter = _minter;
    balances[msg.sender] = _initialAmount;
    totalSupply = _initialAmount;
    name = "BookCoin";
    decimals = 18;
    symbol = "BKC";
    version = "0.1";
  }

  function balanceOf(address _address) constant returns (uint256 balance) {
    return balances[_address];
  }

  // what value did the owner give the spender to spend on their behalf
  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    return allowances[_owner][_spender];
  }

  function transfer(address _to, uint256 _value) returns (bool) {
    // does sender have enough money?
    if (balances[msg.sender] < _value) throw;
    // watch for large inputs that overflow  uint256//balances
    if (balances[_to] + _value < balances[_to]) throw;
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    Transfer(msg.sender, _to, _value);
    return true;
  }

  // allows exchanges to transact tokens on your behalf
  function approve(address _spender, uint256 _value) returns (bool success) {
    allowances[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function transferFrom(address _owner, address _to, uint256 _value) returns (bool success) {
    if (balances[_owner] < _value) throw;
    if ((balances[_to] + _value) < balances[_to]) throw;
    // if (allowances[_owner][msg.sender] < _value) throw;
    balances[_owner] -= _value;
    balances[_to] += _value;
    // allowances[_owner][msg.sender] -= _value;
    Transfer(_owner, _to, _value);
    return true;
  }

  // Minter functions
  function mint(uint256 _amountToMint) {
    balances[centralMinter] += _amountToMint;
    totalSupply += _amountToMint;
    Transfer(this, centralMinter, _amountToMint);
  }

  function transferMinter(address _newMinter) onlyMinter {
    centralMinter = _newMinter;
  }

  // Backed by Ether functions 
  // Must create the contract so that it has enough Ether to buy back ALL tokens on the market,
  // or else the contract will be insolvent and users won't be able to sell their tokens
  function setPrices(uint256 _newSellPrice, uint256 _newBuyPrice) onlyMinter {
    sellPrice = _newSellPrice;
    buyPrice = _newBuyPrice;
  }

  function buy() payable returns (uint amount) {
    amount = msg.value / buyPrice;
    if (balances[centralMinter] < amount) throw;   // validate there are enough tokens minted
    balances[centralMinter] -= amount;
    balances[msg.sender] += amount;
    Transfer(centralMinter, msg.sender, amount);
    return amount;
  }

  function sell(uint _amount) returns (uint revenue) {
    if (balances[msg.sender] < _amount) throw;     // validate sender has enough tokens to sell
    balances[centralMinter] += _amount;
    balances[msg.sender] -= _amount;
    revenue = _amount * sellPrice;
    if (!msg.sender.send(revenue)) {
      throw;
    } else {
      Transfer(msg.sender, centralMinter, _amount);
      return revenue;
    }
  }

  // self destruct function
}