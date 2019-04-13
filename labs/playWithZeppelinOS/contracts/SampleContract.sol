pragma solidity ^0.5.0;

import './SampleLib.sol';
import "zos-lib/contracts/Initializable.sol";
import 'openzeppelin-eth/contracts/ownership/Ownable.sol';

contract SampleContract is Ownable {

  using SampleLib for SampleLib.SampleStruct;

  SampleLib.SampleStruct samples;

  function initialize() initializer() public {
    Ownable.initialize(msg.sender);
  }

  function create()
    public
  {
      samples.create(msg.sender, true);
  }

  function getSender()
    public
    view
    returns(address)
  {
    return samples.getSender();
  }
}