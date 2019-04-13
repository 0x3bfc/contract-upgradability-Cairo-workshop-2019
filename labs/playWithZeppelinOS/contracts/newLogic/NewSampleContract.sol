pragma solidity ^0.5.0;

import "../SampleContract.sol";

contract NewSampleContract is SampleContract {

  function getSender()
    public
    view
    returns(address)
  {
    return samples.getSender();
  }
}