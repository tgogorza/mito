pragma solidity ^0.5.11;

import "./ownable.sol";
import "./safemath.sol";

contract TokenGrid is Ownable {
    using SafeMath for uint256;

    event NewToken(uint x, uint y);
    event ChangedColor(uint tokenId, uint x, uint y);

    uint gridHeight = 1000;
    uint gridWidth = 1000;
    uint defaultR = 128;
    uint defaultG = 128;
    uint defaultB = 128;

    struct Token {
      uint32 tokenId;
      uint16 x;
      uint16 y;
      uint8 R;
      uint8 G;
      uint8 B;
    }

    Token[] public grid;

    mapping (uint => address) public tokenToOwner;
    mapping (address => uint) ownerTokenCount;

    function _createToken(uint16 _x, uint16 _y) internal {
        uint _id = _y * gridWidth + _x;
        grid.push(Token(_id, _x, _y, defaultR, defaultG, defaultB));
        tokenToOwner[id] = msg.sender;
        ownerTokenCount[msg.sender].add(1);
        emit NewToken(_x, _y);
        // emit ChangedColor(_id, _x, _y);
    }

    function initializeGrid() private {
        // require(ownerTokenCount[msg.sender] == 0);
        for(j = 0; j < gridHeight; j++)
            for(i = 0; i < gridWidth; i++)
                _createToken(i, j);
    }

}
