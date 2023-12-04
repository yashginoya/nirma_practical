// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract ticket {

    struct userSt
    {
        uint256 balance;
        uint256 amt;
    }

    uint256 price = 0.001 ether;
    address user;
    mapping (address => userSt) public ticketH;

    

    constructor()
    {
        user = msg.sender;
    }

    function initializeUser() payable  public
    {
        ticketH[user] =  userSt(address(user).balance,0);
    }

    modifier userOnly()
    {
        require(msg.sender == user);
        _;
    }
 

    function buy(address usr,uint256 amt) payable  public userOnly
    {
        require(msg.value>=price*amt);
        ticketH[usr].balance = ticketH[usr].balance - price*amt;
        add(usr,amt);
    }

    function use(address usr,uint256 amt) public userOnly
    {
        sub(usr,amt);
        ticketH[usr].balance = ticketH[usr].balance + price*amt;
    }

    function add(address usr,uint256 amt) internal 
    {
       ticketH[usr].amt = ticketH[usr].amt + amt;
    }

    function sub(address usr,uint256 amt) internal
    {
        //require(ticketH[usr].amt<amt,"Insufficient tickets");
        ticketH[usr].amt =  ticketH[usr].amt - amt;
    }

    function withdraw() public 
    {
        require(msg.sender==user,"Invalid user");
        (bool isPossible, ) = payable (user).call{value: address(this).balance}("");
        require(isPossible);
    }
    
}