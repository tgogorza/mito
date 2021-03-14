pragma solidity ^0.5.11;

import "./tokengrid.sol";
import "./erc721.sol";

contract TokenOwnership is ERC721 {

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerTokenCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return tokenToOwner(_tokenId);
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerTokenCount[_to]++;
    ownerTokenCount[_from]--;
    tokenToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (tokenToOwner[_tokenId] == msg.sender || tokenApprovals[_tokenId] == msg.sender,
             "Cannot transfer token. It is not yours and you are not authorized");
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable {
    tokenApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(zombieApprovals[_tokenId] == msg.sender, "Not approved for transfer");
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}