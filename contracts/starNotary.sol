pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract StarNotary is ERC721 {

    struct Star {
        string name;
    }

//  Add a name and a symbol for your starNotary tokens
    string public constant name = "StarLight";
    string public constant symbol = "SRLT";

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    function createStar(string _name, uint256 _tokenId) public  {
        Star memory newStar = Star(_name);

        tokenIdToStarInfo[_tokenId] = newStar;

        _mint(msg.sender, _tokenId);
    }

    //This function allows users to look up the star name given the start token
    function lookUptokenIdToStarInfo(uint256 _tokenId) view public returns (string result) {

        //return name from list of stars
        result = tokenIdToStarInfo[_tokenId].name;
    }

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender);

        starsForSale[_tokenId] = _price;
    }

    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0);

        uint256 starCost = starsForSale[_tokenId];
        address starOwner = ownerOf(_tokenId);
        require(msg.value >= starCost);

        _removeTokenFrom(starOwner, _tokenId);
        _addTokenTo(msg.sender, _tokenId);

        starOwner.transfer(starCost);

        if(msg.value > starCost) {
            msg.sender.transfer(msg.value - starCost);
        }
        starsForSale[_tokenId] = 0;
      }

// Add a function called exchangeStars, so 2 users can exchange their star tokens...
//Do not worry about the price, just write code to exchange stars between users.

    function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public{

        //Check exchange requester is the owner
        require(ownerOf(_tokenId1) == msg.sender);

        //Get addresses
        address star1Owner = ownerOf(_tokenId1);
        address star2Owner = ownerOf(_tokenId2);

        //Remove star ownership
        _removeTokenFrom(star1Owner, _tokenId1);
        _removeTokenFrom(star2Owner, _tokenId2);

        //Add exchnaged star ownership
        _addTokenTo(star1Owner, _tokenId2);
        _addTokenTo(star2Owner, _tokenId1);

    }

//

// Write a function to Transfer a Star. The function should transfer a star from the address of the caller.
// The function should accept 2 arguments, the address to transfer the star to, and the token ID of the star.
//
    function transferStar(address _receiver, uint256 _tokenId) public{

        //Check requester is star owner
        require(ownerOf(_tokenId) == msg.sender);

        //remove ownership 
        _removeTokenFrom(msg.sender, _tokenId);

        //add ownership to receiver of transfer
        _addTokenTo(_receiver, _tokenId);

    }


}
