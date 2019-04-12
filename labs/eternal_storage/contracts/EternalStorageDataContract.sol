pragma solidity 0.5.3;

// import 'https://github.com/openzeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';

contract EternalStorageDataContract is Ownable {

    mapping(bytes32 => uint256) uInt256Storage;

    constructor(address contractOwner)
        public
    {
        require(contractOwner != address(0));
        transferOwnership(contractOwner);
    }

    function getUint256(bytes32 key)
        public
        view
        returns(uint256)
    {
        return uInt256Storage[key];
    }

    function setUint256(bytes32 key, uint new_val)
        public
        onlyOwner
    {
        uInt256Storage[key] = new_val;
    }
}

