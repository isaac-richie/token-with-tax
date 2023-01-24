// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PlatusToken is ERC20 {

    address public owner ;
    uint taxdivindend = 8;

    constructor() ERC20("Platus", "Plt") {}
  
  function mintToken (uint amount) public {
      _mint(msg.sender, amount);
  }

  function transfer(address to, uint amount) public override returns (bool) {
     //sender must have enough funds to send
     //take 8% from the token about to be sent
     //send the reamiming funds
     //emit the transfer event

     uint balanceSender = balanceOf(msg.sender);

     require(balanceSender >= amount, "not enough amout for transfer");

     uint taxamount =  amount/taxdivindend;
     uint transferAmount = amount - taxamount;

      _transfer(msg.sender, to, transferAmount);
      _transfer(msg.sender, address(0xeFf0dF4df0636B0DD19F4b9738C40EEbBD3E909b), taxamount);

     return true;
  }

}