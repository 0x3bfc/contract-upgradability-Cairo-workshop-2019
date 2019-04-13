pragma solidity 0.4.25;

contract Proxy {

}

contract UpgradabilityProxy is Proxy {
    bytes32 private constant implementationPosition = keccak256("com.oceanprotocol.implementation");

    function implementation()
        public
        view
        returns(address implementationAddress)
    {
        bytes32 position = implementationPosition;
        assembly {
            implementationAddress := sload(position)
        }
    }

    function setImplementation(address newImplementationAddress)
        internal
    {
        bytes32 position = implementationPosition;
        assembly{
            sstore(position, newImplementationAddress)
        }
    }
}

contract OwnedUpgradabilityProxy is UpgradabilityProxy {

    bytes32 private constantpProxyOwnerPosition = keccak256("com.oceanprotocol.proxy.owner");
}


