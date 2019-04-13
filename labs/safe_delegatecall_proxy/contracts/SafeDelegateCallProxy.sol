pragma solidity 0.4.25;

contract SampleLogicContract {
    uint public a;

    function set(uint val)
        public
        returns (bool)
    {
        a = val;
        return true;
    }
}

contract ProxyContract {
    uint public a;
    address public contractPtr;

    constructor()
        public
    {
        contractPtr = address(new SampleLogicContract());
    }

    function set(uint val)
        public
        returns (bool)
    {
        bool state = contractPtr.delegatecall(bytes4(keccak256("set(uint256)")), val);
        require(
            state,
            'invalid delegatecall'
        );
        return true;
    }
}