pragma solidity 0.5.3;

import 'https://github.com/openzeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol';

contract SampleContract is Ownable {
    // state variables
    uint256 public value = 0;
    // modifier
    modifier onlyValidValue(uint256 _value)
    {
        require(
            value > 0,
            'Invalid value'
        );
        _;
    }
    // event
    event ValueUpdated(
        uint256 indexed oldValue,
        uint256 indexed newValue,
        uint256 updatedAt
    );
    // modifier

    // constructor
    constructor(address contractOwner)
        public
    {
        require(contractOwner != address(0));
        transferOwnership(contractOwner);
    }

    function setValue(uint256 _value)
        public      // visibility is public
        onlyOwner() // inherited modifier from Ownable!
        returns(bool)
    {
        return _setValue(_value);
    }

    function _setValue(uint256 newValue)
        private
        onlyValidValue(newValue)
        returns(bool)
    {
        uint256 oldValue = value;
        value = newValue;
        emit ValueUpdated(oldValue, newValue, block.number);
    }
}