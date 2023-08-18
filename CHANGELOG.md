# Changelog

<!--next-version-placeholder-->

## v1.10.0 (2023-08-18)
### Feature
* Mutualise dockerfile argument ([`f806177`](https://github.com/antipodestudios/python-template/commit/f80617753e2cfaa66a24c7df21ab36349eb54594))
* Buildtime fetch from codeartifact (all targets) ([`8a32ba5`](https://github.com/antipodestudios/python-template/commit/8a32ba5c6770b7d4cffc85b6b8a211beeafaad79))

## v1.9.0 (2023-08-18)
### Feature
* Do not use AWS env variables in next-release rule ([`82ddfec`](https://github.com/antipodestudios/python-template/commit/82ddfeca2c74c11598d8581e26e9a7242c9f01d4))
* Buildtime fetch from codeartifact (development target only) ([`5121d02`](https://github.com/antipodestudios/python-template/commit/5121d02283a69659e9c54e9d248f9dd974f9e357))
* Use codeartifact repository ([`55bea62`](https://github.com/antipodestudios/python-template/commit/55bea6247a59aef18bf90b2c64c68cadf75a7b30))

### Fix
* Generate aws credentials file from github action ([`512e0aa`](https://github.com/antipodestudios/python-template/commit/512e0aa283d2b4d7e93ae7274363d712f6404f39))

## v1.8.0 (2023-08-17)
### Feature
* Backport aws configuration in template ([`63103ff`](https://github.com/antipodestudios/python-template/commit/63103ff6070198186f1233e6669ed1d22efc2424))

### Fix
* Remove unused ssh config ([`46b5da0`](https://github.com/antipodestudios/python-template/commit/46b5da00ebb9e4ef36ea4a0dd003dbca4da3888f))

## v1.7.1 (2023-08-17)
### Fix
* Remove antipode logging ([`11937cd`](https://github.com/antipodestudios/python-template/commit/11937cdbae80d53a4d00a1a65072bc84b711c6d7))

## v1.7.0 (2023-08-17)
### Feature
* Add lambda stage to dockerfile ([`e9f4bef`](https://github.com/antipodestudios/python-template/commit/e9f4bef20f801584c22a873ad74d6973ccafaca7))
* Use new makefile rules in CI + renaming some rules ([`0c43b81`](https://github.com/antipodestudios/python-template/commit/0c43b8193dd7add8487d20db56150c3b1ac41142))
* Use simplified makefile ([`7cf0c92`](https://github.com/antipodestudios/python-template/commit/7cf0c92b794de1c8d960a965e048bc39958b0a09))
* Poe the poet installed and configured ([`de71df5`](https://github.com/antipodestudios/python-template/commit/de71df56d3576d62d186a53f14db5e8d5fd0e20d))
* Remove .venv on clean ([`a11b063`](https://github.com/antipodestudios/python-template/commit/a11b063e8bfb8163fc35eecb65a60b753f3151d1))
* Update vscode settings and python tools to avoid deprecated warnings ([`e2870c0`](https://github.com/antipodestudios/python-template/commit/e2870c0d098fa3d04743df5852b3afb079b496e0))
* Add unbinded volume to avoid venv errors ([`78037be`](https://github.com/antipodestudios/python-template/commit/78037beb8225929aece308dace9f3113798be4df))
* Add copilot ([`65a2a57`](https://github.com/antipodestudios/python-template/commit/65a2a57af140b1d800f7b6c74604e663a9d53b9c))
* Handle ssh config with custom Hosts on dev container ([`65f1595`](https://github.com/antipodestudios/python-template/commit/65f15954be2a06247e4d5826a9ed009550a105a9))
* Disable format on save ([`bf83704`](https://github.com/antipodestudios/python-template/commit/bf8370499f33a63a60d7acc46055b297070a6253))
* Remove unused stage builder ([`a21785d`](https://github.com/antipodestudios/python-template/commit/a21785d66eafbad77f441a6c26882c4e6339fd9a))
* Production build working ([`b84d9f2`](https://github.com/antipodestudios/python-template/commit/b84d9f2009a29c44c2731fd6c24d5132172629d5))
* Add git to production ([`2a4911c`](https://github.com/antipodestudios/python-template/commit/2a4911c6686a73ab16fb5de20a8c2d97044d044a))
* Install antipode logging ([`4264114`](https://github.com/antipodestudios/python-template/commit/426411446cd9368263b8f558ed92e635df706512))
* Mount ssh config file ([`b47230b`](https://github.com/antipodestudios/python-template/commit/b47230b3cc277526c1ecaf32ebe0d6b4ed611f0d))
* Production target ready ([`cbeb051`](https://github.com/antipodestudios/python-template/commit/cbeb0512c1e761c7a0a4c79f89d03882ec633dc4))
* Completion working on development ([`7641a07`](https://github.com/antipodestudios/python-template/commit/7641a07520c2a2b327f2d038fe5f2c0ed92f44bb))
* Add git to dev deps ([`f17925a`](https://github.com/antipodestudios/python-template/commit/f17925aa56a8069b607ec9bedee94f323be9bc1b))
* Use poetry 1.5.1 ([`00dc1fd`](https://github.com/antipodestudios/python-template/commit/00dc1fdae7e2144b99a733334cac3c93c903d263))

### Fix
* Use poetry venv in script ([`c64f0cf`](https://github.com/antipodestudios/python-template/commit/c64f0cf93de903bcda5b654b95e6469389fb0807))
* Poetry file format ([`4dc656f`](https://github.com/antipodestudios/python-template/commit/4dc656f98999a44675c6d31e2d12ec3a9215f96d))
* Black args added to vscode settings ([`b1b7c9b`](https://github.com/antipodestudios/python-template/commit/b1b7c9bc397798de227d6b81527849b426be1a22))
* Update docker-compose on the right job ([`db8969e`](https://github.com/antipodestudios/python-template/commit/db8969efea95931c028463baad4e172f0a286236))
* Use the right compose file ([`069897c`](https://github.com/antipodestudios/python-template/commit/069897c0ab07fd4104b0ad92c05bc2320f3e68af))
* Small improvements ([`e224a76`](https://github.com/antipodestudios/python-template/commit/e224a7683c1c3c0f9dc0c5a70d886178a34d2c75))
* Format ([`4e33739`](https://github.com/antipodestudios/python-template/commit/4e33739d2a4c0df35c4da2a1915cc3f2f3012d57))
* Remove unused ([`9cf0321`](https://github.com/antipodestudios/python-template/commit/9cf032129897c101f3306a5fc4ca597104e53d6b))
* Remove python-decouple ([`c12a853`](https://github.com/antipodestudios/python-template/commit/c12a85384b4885cc7d82c95b6f3c7d8e5314291d))
* Bashrc working ([`df775c1`](https://github.com/antipodestudios/python-template/commit/df775c1540c53e5cf16bd9367619b4a053fb8118))
* Remove unused ssh volume mount ([`a728d09`](https://github.com/antipodestudios/python-template/commit/a728d09bbdda166afc9d660f54b94e76274c4452))

### Documentation
* Add documentation on development and production stages ([`c128eec`](https://github.com/antipodestudios/python-template/commit/c128eec1fff9ea9adaf168a5914822c5b48cfaaa))
* Readme update ([`b40413e`](https://github.com/antipodestudios/python-template/commit/b40413e813bf8f9964867cab1e0223bde412be33))

## v1.6.0 (2023-08-07)

### Feature

* Use new devcontainer schema ([`2c60728`](https://github.com/antipodestudios/python-template/commit/2c60728926631b332718e91c25a940e4e4910c75))

### Fix

* Remove personal brand from codebase ([`382c715`](https://github.com/antipodestudios/python-template/commit/382c715c8f2ff92a09a9187b9206a7f8cb1e2309))

## v1.5.2 (2023-08-07)

### Fix

* Modify names from personal template ([`bbab440`](https://github.com/antipodestudios/python-template/commit/bbab440319b1673e8e0c0b59e826017fade61be2))

## v1.5.1 (2023-01-20)

### Fix

- No errors in code quality when no tests files ([`5509f01`](https://github.com/antipodestudios/python-template/commit/5509f011f99040573a0a9da9d0d34e708b603768))

## v1.5.0 (2023-01-20)

### Feature

- Container hostname specified as project name ([`19db416`](https://github.com/antipodestudios/python-template/commit/19db41668e2a2c2253efb7c2d069137dae4a49b5))

## v1.4.0 (2023-01-20)

### Feature

- Activate bash autocomplete in dev container ([`0c585ff`](https://github.com/antipodestudios/python-template/commit/0c585ffceefa91a02c4cf5549c2c2a58abd2cf83))
- Make unit_tests exit with no errors if tests/ is empty ([`f88c2e3`](https://github.com/antipodestudios/python-template/commit/f88c2e3623850f9b232d56bed511e08da50e8573))
- Commit all changes after repo-init + add .keep file in tests ([`272e8eb`](https://github.com/antipodestudios/python-template/commit/272e8ebb76aeddf5010b17b8fbd171868f373ef0))

## v1.3.0 (2023-01-20)

### Feature

- Enhance repo-init script ([`0f20ba0`](https://github.com/antipodestudios/python-template/commit/0f20ba023db98be546d18d457d295b438cb08426))

## v1.2.0 (2023-01-20)

### Feature

- **continous delivery:** Add the ability to publish the next version ([`7c14b75`](https://github.com/antipodestudios/python-template/commit/7c14b7585ab74dad8cfa867eb5ed60feca3ddd65))
- Ci for master branch ([`f0000bc`](https://github.com/antipodestudios/python-template/commit/f0000bc026bacf97d5dfe7ec0b53b57a42712cb9))
- Add semantic-release configuration ([`5b8a06f`](https://github.com/antipodestudios/python-template/commit/5b8a06fdbf97c6ca114c2b2fb6aaad350874a3d0))
- Launch code quality checkers in CI ([`499185d`](https://github.com/antipodestudios/python-template/commit/499185d3a94b7b2e73eb92d63d452f2ce01bef87))
- Use docker-compose ([`78931a1`](https://github.com/antipodestudios/python-template/commit/78931a1ee535eb413f8b15008da5b2df75644a74))
- Better makefile with docker info ([`2e86b27`](https://github.com/antipodestudios/python-template/commit/2e86b2710be3136d983435fc5be6131a586a68d0))
- Use dev containers ([`a81d577`](https://github.com/antipodestudios/python-template/commit/a81d5776ccbdb4e7a8a804e81419fc5485453955))

### Fix

- Repair again ([`d2e3140`](https://github.com/antipodestudios/python-template/commit/d2e3140ee3ace11a150b796feb6d9036f39cdc11))
- Try to repair release ([`7ca11ba`](https://github.com/antipodestudios/python-template/commit/7ca11bad2230133d2fb72177e9e06ad5431ff207))
- Repair release cd ([`c11aeee`](https://github.com/antipodestudios/python-template/commit/c11aeeed9e2c87eb2bf7c6432f06f99913c87458))
- Repair publish release ([`64909d0`](https://github.com/antipodestudios/python-template/commit/64909d0104ff2d2ea5c4561bf1fb146f1f5eb7fa))
- Change job name ([`c86a818`](https://github.com/antipodestudios/python-template/commit/c86a818b3d7a298f7bcc69f91e430bf13bab7a38))
