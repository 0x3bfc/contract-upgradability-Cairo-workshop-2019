# playWithZeppelinOS

### Installation
```bash
$ npm install truffle@5.0.4
$ npm install -g ganache-cli
$ npm install zos
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

