pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract GenkiToken is ERC20, Ownable {
  constructor() ERC20("Genki", "GENKI") {
    _mint(msg.sender, 1000000 * 10 ** decimals());
  }

  function decimals() public view virtual override returns (uint8) {
    return 18;
  }

  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  function burn(uint256 amount) public {
    _burn(msg.sender, amount);
  }
}
