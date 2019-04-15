# playWithZeppelinOS

### Installation
```bash
$ npm install truffle@5.0.4
$ npm install -g ganache-cli
$ npm install -g zos
$ npm i
```

### Getting started
- Compile contracts
```bash
$ truffle compile
```
- Start Ganache
```bash
$ ganache-cli --port 9545 --deterministic
```

- Create `zos.json` which contains all the information about the project related to ZeppelinOS.

```bash
$ npx zos init playWithZOS
```

- Add contract to `zos.json`

```bash
$ zos add SampleContract

Compiling contracts with Truffle...
Compiling ./contracts/SampleContract.sol...
Compiling ./contracts/SampleLib.sol...
Compiling ./contracts/upgrade/NewSampleContract.sol...
Compiling openzeppelin-eth/contracts/ownership/Ownable.sol...
Compiling zos-lib/contracts/Initializable.sol...
Writing artifacts to ./build/contracts
```

- Push or Deploy logic contract(s)

```bash
$ zos push --network development --verbose

[Compiler] Compiling contracts with Truffle...
Compiling ./contracts/SampleContract.sol...
Compiling ./contracts/SampleLib.sol...
Compiling ./contracts/upgrade/NewSampleContract.sol...
Compiling openzeppelin-eth/contracts/ownership/Ownable.sol...
Compiling zos-lib/contracts/Initializable.sol...
Writing artifacts to ./build/contracts


[NetworkAppController] Validating contract SampleContract
[NetworkAppController] Uploading SampleLib library...
[BaseSimpleProject] Deploying logic contract for SampleLib
[NetworkAppController] Uploading SampleContract contract as SampleContract
[BaseSimpleProject] Deploying logic contract for SampleContract
[ZosNetworkFile] Created zos.dev-1553721948227.json
```

- Create Proxy contract for the logic contract

```bash
$ npx zos create SampleContract --init initialize --network development

Deploying new ProxyAdmin...
Deployed ProxyAdmin at 0xcd41D693C6fD129Ce87E5878c41C1e9ae70c960c
Creating proxy to logic contract 0x3A868F5da8EFA2c314fBdb39dBa478cb69ac9360 and initializing by calling initialize with: 

Instance created at 0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019
0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019
Updated zos.dev-1553721948227.json
```

- Get the address of the proxy contract instance address `0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019`
- Let's use `truffle console` to validate the deployment
```bash
$ truffle console --network development
truffle(development)> sampleContract = await SampleContract.at('0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019')
undefined
truffle(development)> sampleContract.create()
{ tx: '0xdb0cb0cdf571a185d6195f3450f85e230b89cebd85ef113c87038a87efb16fb0',
  receipt: 
   { transactionHash: '0xdb0cb0cdf571a185d6195f3450f85e230b89cebd85ef113c87038a87efb16fb0',
     transactionIndex: 0,
     blockHash: '0xe92502a5085fed6481bedb26ca968d5e8c228e2e9053f9325de11ab33bc4b631',
     blockNumber: 12,
     gasUsed: 50669,
     cumulativeGasUsed: 50669,
     contractAddress: null,
     logs: [],
     status: true,
     logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
     rawLogs: [] },
  logs: [] }
truffle(development)> sampleContract.getSender()
'0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019'
```

Now everything is working as expected. Lets change the logic of the library and try 
to upgrade the code the existing on-chain code. Let's fix the bug in the `SampleLib.sol` byt 
replacing the new `NewSampleLib.sol` in `NewLib` directory. Please copy and paste the code to `contracts/SampleLib.sol`.
 
- If we tried to push again, ZeppelinOS (ZOS) will automatically detect the 
change in the code.

```bash
$ npx zos push --network development 
Compiling contracts with Truffle...
Compiling ./contracts/SampleContract.sol...
Compiling ./contracts/SampleLib.sol...
Compiling ./contracts/upgrade/NewSampleContract.sol...
Compiling openzeppelin-eth/contracts/ownership/Ownable.sol...
Compiling zos-lib/contracts/Initializable.sol...
Writing artifacts to ./build/contracts


Validating contract SampleContract
- Variable samples (SampleContract) contains a struct or enum. These are not automatically checked for storage compatibility in the current version. See https://docs.zeppelinos.org/docs/writing_contracts.html#modifying-your-contracts for more info.
Uploading SampleLib library...
Deploying logic contract for SampleLib
Uploading SampleContract contract as SampleContract
Deploying logic contract for SampleContract
Updated zos.dev-1553721948227.json
```

- Finally, update the logic contract `SampleContract.sol`

```bash
$ npx zos update --network development SampleContract
Upgrading proxy to logic contract 0x4B3a658607036AEcf69EcdBae0967e03c5eB027e
Upgrading proxy at 0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019 without running migrations...
TX receipt received: 0x3520a8c2ad6e4789eec7eb31314a31a4733d1feb649d8dd5aa4dad14b6847b1f
Instance at 0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019 upgraded
0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019
Updated zos.dev-1553721948227.json
```

- Testing
```bash
$ truffle console --network development
truffle(development)> sampleContract = await SampleContract.at('0x3F5043B7FD0103464D4BAAcD697DAD13C81a2019')
undefined
truffle(development)> sampleContract.create()
truffle(development)> sampleContract.getSender()
'0xf42eFca71be3A9e1BBc776d187Cecc4c9Fa7e4C1'
```

Now it returns the address of the sender and the bug was fixed!
