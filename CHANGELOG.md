# CHANGELOG



## v1.11.5 (2023-08-21)

### Documentation

* docs: add small sentence about aws registry ([`5204a6e`](https://github.com/antipodestudios/python-template/commit/5204a6ef497ab31f07e97075bb04a8a7694f0b60))

### Fix

* fix: rename repository-init.sh on codebase also ([`0eb7097`](https://github.com/antipodestudios/python-template/commit/0eb7097e6ddefae79c0abc22e36b491399e93c70))


## v1.11.4 (2023-08-20)

### Fix

* fix: rename package template ([`91581f6`](https://github.com/antipodestudios/python-template/commit/91581f6018af07599cec31515eb95f30e4573bf3))


## v1.11.3 (2023-08-20)

### Fix

* fix: backport missing config for application template ([`f26f896`](https://github.com/antipodestudios/python-template/commit/f26f89693366ad7b10531447337ce89a6cc20af3))


## v1.11.2 (2023-08-20)

### Fix

* fix: rename package publish-versioned.sh rule and script ([`08c1d98`](https://github.com/antipodestudios/python-template/commit/08c1d981d414eb1ff493d18423df3cca0dd90bac))

* fix: unify next-version and publish ([`352d4f3`](https://github.com/antipodestudios/python-template/commit/352d4f35b643a09e78eedc79cf9fc74e1a5c0ca0))


## v1.11.1 (2023-08-20)

### Ci

* ci: unify next-version and publish package ([`b75221e`](https://github.com/antipodestudios/python-template/commit/b75221ea786a604802b15595ef60a7463be67a7c))

### Fix

* fix: remove breaking mypy configuration ([`75cd350`](https://github.com/antipodestudios/python-template/commit/75cd350a0a305527751a4f796c4621e032e083c8))

* fix: remove description for GH Actions ([`51e2a79`](https://github.com/antipodestudios/python-template/commit/51e2a79581628a505247b1119a86839ea712609f))

* fix: uncomment git commits at the end of init script ([`78ca36b`](https://github.com/antipodestudios/python-template/commit/78ca36b894d47cbc88be47023b8ff2d01ba87fdf))

* fix: correct repository-init.sh in readme ([`e214634`](https://github.com/antipodestudios/python-template/commit/e214634e44eb900a7c2e5156ad8b4560c6cd482c))


## v1.11.0 (2023-08-20)

### Ci

* ci: add commit-lint job to release job ([`711eeb0`](https://github.com/antipodestudios/python-template/commit/711eeb0ea06b7583b41b87546c6d8607fccebaf9))

### Documentation

* docs: update README.md with AWS credentials explanation ([`17a5e55`](https://github.com/antipodestudios/python-template/commit/17a5e55c72a7ee5f0e67f3c7762a200a97d3669b))

### Feature

* feat: add release workflow for template ([`176a8fd`](https://github.com/antipodestudios/python-template/commit/176a8fd949a4eb0abb9833615225232b52337977))

* feat: repository init script handle package and application template ([`73b5045`](https://github.com/antipodestudios/python-template/commit/73b5045bb36bf34d95139a40ffcbdd8031181bc9))

* feat: prepare files for application template ([`358de1b`](https://github.com/antipodestudios/python-template/commit/358de1b22db115db6b43f62927785d3ad680d439))

* feat: prepare files for package template ([`65d7063`](https://github.com/antipodestudios/python-template/commit/65d7063d544b4721463d3e3756a4b1b02bcb27ba))

### Fix

* fix: remove double checkout in gh action ([`46e63b4`](https://github.com/antipodestudios/python-template/commit/46e63b459af91b1fdc37a1dbf856bede425066aa))

* fix: wrong script path for poetry config with codeartifact ([`bf18200`](https://github.com/antipodestudios/python-template/commit/bf18200b33ca111f2e7e6730f16cadabd3485a48))

* fix: remove unused target in package configuration ([`b6577f3`](https://github.com/antipodestudios/python-template/commit/b6577f311bfe60ea3c6dcadc2b5e1fe526c220cb))

* fix: missing rules in Makefile.package ([`fdaf007`](https://github.com/antipodestudios/python-template/commit/fdaf0072445539b923327990e4fd23ba04106228))

* fix: missing rules in Makefile.app ([`28268e0`](https://github.com/antipodestudios/python-template/commit/28268e057ea65740c73b70fcfea11c85869401a5))

* fix: typo ([`6df0fa6`](https://github.com/antipodestudios/python-template/commit/6df0fa64b8ce62cd9a7f922d546204605f3fd9d2))

* fix: add .PHONY and remove .venv on clean (outside the container only) ([`8491dfc`](https://github.com/antipodestudios/python-template/commit/8491dfceab868727d59b3dac7a11b14f532a37de))


## v1.10.0 (2023-08-18)

### Feature

* feat: mutualise dockerfile argument ([`f806177`](https://github.com/antipodestudios/python-template/commit/f80617753e2cfaa66a24c7df21ab36349eb54594))

* feat: buildtime fetch from codeartifact (all targets) ([`8a32ba5`](https://github.com/antipodestudios/python-template/commit/8a32ba5c6770b7d4cffc85b6b8a211beeafaad79))


## v1.9.0 (2023-08-18)

### Feature

* feat: do not use AWS env variables in next-release rule ([`82ddfec`](https://github.com/antipodestudios/python-template/commit/82ddfeca2c74c11598d8581e26e9a7242c9f01d4))

* feat: buildtime fetch from codeartifact (development target only) ([`5121d02`](https://github.com/antipodestudios/python-template/commit/5121d02283a69659e9c54e9d248f9dd974f9e357))

* feat: use codeartifact repository ([`55bea62`](https://github.com/antipodestudios/python-template/commit/55bea6247a59aef18bf90b2c64c68cadf75a7b30))

### Fix

* fix: generate aws credentials file from github action ([`512e0aa`](https://github.com/antipodestudios/python-template/commit/512e0aa283d2b4d7e93ae7274363d712f6404f39))


## v1.8.0 (2023-08-17)

### Feature

* feat: backport aws configuration in template ([`63103ff`](https://github.com/antipodestudios/python-template/commit/63103ff6070198186f1233e6669ed1d22efc2424))

### Fix

* fix: remove unused ssh config ([`46b5da0`](https://github.com/antipodestudios/python-template/commit/46b5da00ebb9e4ef36ea4a0dd003dbca4da3888f))

### Unknown

* doc: remove ssh section for now ([`9bffa58`](https://github.com/antipodestudios/python-template/commit/9bffa588a28e001057f00afbc269345bbcb4d487))


## v1.7.1 (2023-08-17)

### Fix

* fix: remove antipode logging ([`11937cd`](https://github.com/antipodestudios/python-template/commit/11937cdbae80d53a4d00a1a65072bc84b711c6d7))


## v1.7.0 (2023-08-17)

### Chore

* chore: ignore server.log file ([`6465aa4`](https://github.com/antipodestudios/python-template/commit/6465aa41302c0e51898cd1f4aaaf349fbfc3ec24))

### Ci

* ci: add ssh-agent ([`452e8b7`](https://github.com/antipodestudios/python-template/commit/452e8b7b59e3ed26f26b48a55a4da70205352b91))

### Documentation

* docs: add documentation on development and production stages ([`c128eec`](https://github.com/antipodestudios/python-template/commit/c128eec1fff9ea9adaf168a5914822c5b48cfaaa))

* docs: readme update ([`b40413e`](https://github.com/antipodestudios/python-template/commit/b40413e813bf8f9964867cab1e0223bde412be33))

### Feature

* feat: add lambda stage to dockerfile ([`e9f4bef`](https://github.com/antipodestudios/python-template/commit/e9f4bef20f801584c22a873ad74d6973ccafaca7))

* feat: use new makefile rules in CI + renaming some rules ([`0c43b81`](https://github.com/antipodestudios/python-template/commit/0c43b8193dd7add8487d20db56150c3b1ac41142))

* feat: use simplified makefile ([`7cf0c92`](https://github.com/antipodestudios/python-template/commit/7cf0c92b794de1c8d960a965e048bc39958b0a09))

* feat: poe the poet installed and configured ([`de71df5`](https://github.com/antipodestudios/python-template/commit/de71df56d3576d62d186a53f14db5e8d5fd0e20d))

* feat: remove .venv on clean ([`a11b063`](https://github.com/antipodestudios/python-template/commit/a11b063e8bfb8163fc35eecb65a60b753f3151d1))

* feat: update vscode settings and python tools to avoid deprecated warnings ([`e2870c0`](https://github.com/antipodestudios/python-template/commit/e2870c0d098fa3d04743df5852b3afb079b496e0))

* feat: add unbinded volume to avoid venv errors ([`78037be`](https://github.com/antipodestudios/python-template/commit/78037beb8225929aece308dace9f3113798be4df))

* feat: add copilot ([`65a2a57`](https://github.com/antipodestudios/python-template/commit/65a2a57af140b1d800f7b6c74604e663a9d53b9c))

* feat: handle ssh config with custom Hosts on dev container ([`65f1595`](https://github.com/antipodestudios/python-template/commit/65f15954be2a06247e4d5826a9ed009550a105a9))

* feat: disable format on save ([`bf83704`](https://github.com/antipodestudios/python-template/commit/bf8370499f33a63a60d7acc46055b297070a6253))

* feat: remove unused stage builder ([`a21785d`](https://github.com/antipodestudios/python-template/commit/a21785d66eafbad77f441a6c26882c4e6339fd9a))

* feat: production build working ([`b84d9f2`](https://github.com/antipodestudios/python-template/commit/b84d9f2009a29c44c2731fd6c24d5132172629d5))

* feat: add git to production ([`2a4911c`](https://github.com/antipodestudios/python-template/commit/2a4911c6686a73ab16fb5de20a8c2d97044d044a))

* feat: install antipode logging ([`4264114`](https://github.com/antipodestudios/python-template/commit/426411446cd9368263b8f558ed92e635df706512))

* feat: mount ssh config file ([`b47230b`](https://github.com/antipodestudios/python-template/commit/b47230b3cc277526c1ecaf32ebe0d6b4ed611f0d))

* feat: production target ready ([`cbeb051`](https://github.com/antipodestudios/python-template/commit/cbeb0512c1e761c7a0a4c79f89d03882ec633dc4))

* feat: completion working on development ([`7641a07`](https://github.com/antipodestudios/python-template/commit/7641a07520c2a2b327f2d038fe5f2c0ed92f44bb))

* feat: add git to dev deps ([`f17925a`](https://github.com/antipodestudios/python-template/commit/f17925aa56a8069b607ec9bedee94f323be9bc1b))

* feat: use poetry 1.5.1 ([`00dc1fd`](https://github.com/antipodestudios/python-template/commit/00dc1fdae7e2144b99a733334cac3c93c903d263))

### Fix

* fix: use poetry venv in script ([`c64f0cf`](https://github.com/antipodestudios/python-template/commit/c64f0cf93de903bcda5b654b95e6469389fb0807))

* fix: poetry file format ([`4dc656f`](https://github.com/antipodestudios/python-template/commit/4dc656f98999a44675c6d31e2d12ec3a9215f96d))

* fix: black args added to vscode settings ([`b1b7c9b`](https://github.com/antipodestudios/python-template/commit/b1b7c9bc397798de227d6b81527849b426be1a22))

* fix: update docker-compose on the right job ([`db8969e`](https://github.com/antipodestudios/python-template/commit/db8969efea95931c028463baad4e172f0a286236))

* fix: use the right compose file ([`069897c`](https://github.com/antipodestudios/python-template/commit/069897c0ab07fd4104b0ad92c05bc2320f3e68af))

* fix: small improvements ([`e224a76`](https://github.com/antipodestudios/python-template/commit/e224a7683c1c3c0f9dc0c5a70d886178a34d2c75))

* fix: format ([`4e33739`](https://github.com/antipodestudios/python-template/commit/4e33739d2a4c0df35c4da2a1915cc3f2f3012d57))

* fix: remove unused ([`9cf0321`](https://github.com/antipodestudios/python-template/commit/9cf032129897c101f3306a5fc4ca597104e53d6b))

* fix: remove python-decouple ([`c12a853`](https://github.com/antipodestudios/python-template/commit/c12a85384b4885cc7d82c95b6f3c7d8e5314291d))

* fix: bashrc working ([`df775c1`](https://github.com/antipodestudios/python-template/commit/df775c1540c53e5cf16bd9367619b4a053fb8118))

* fix: remove unused ssh volume mount ([`a728d09`](https://github.com/antipodestudios/python-template/commit/a728d09bbdda166afc9d660f54b94e76274c4452))


## v1.6.0 (2023-08-07)

### Feature

* feat: use new devcontainer schema ([`2c60728`](https://github.com/antipodestudios/python-template/commit/2c60728926631b332718e91c25a940e4e4910c75))

### Fix

* fix: remove personal brand from codebase ([`382c715`](https://github.com/antipodestudios/python-template/commit/382c715c8f2ff92a09a9187b9206a7f8cb1e2309))


## v1.5.2 (2023-08-07)

### Fix

* fix: modify names from personal template ([`bbab440`](https://github.com/antipodestudios/python-template/commit/bbab440319b1673e8e0c0b59e826017fade61be2))

### Unknown

* doc: update readme regarding github actions ([`f1fe5b4`](https://github.com/antipodestudios/python-template/commit/f1fe5b451cfa174bd1828490ddb0fa54d0b30643))


## v1.5.1 (2023-01-20)

### Fix

* fix: no errors in code quality when no tests files ([`5509f01`](https://github.com/antipodestudios/python-template/commit/5509f011f99040573a0a9da9d0d34e708b603768))


## v1.5.0 (2023-01-20)

### Feature

* feat: container hostname specified as project name ([`19db416`](https://github.com/antipodestudios/python-template/commit/19db41668e2a2c2253efb7c2d069137dae4a49b5))


## v1.4.0 (2023-01-20)

### Feature

* feat: activate bash autocomplete in dev container ([`0c585ff`](https://github.com/antipodestudios/python-template/commit/0c585ffceefa91a02c4cf5549c2c2a58abd2cf83))

* feat: make unit_tests exit with no errors if tests/ is empty ([`f88c2e3`](https://github.com/antipodestudios/python-template/commit/f88c2e3623850f9b232d56bed511e08da50e8573))

* feat: commit all changes after repo-init + add .keep file in tests ([`272e8eb`](https://github.com/antipodestudios/python-template/commit/272e8ebb76aeddf5010b17b8fbd171868f373ef0))


## v1.3.0 (2023-01-20)

### Chore

* chore: rename jobs ([`09d7652`](https://github.com/antipodestudios/python-template/commit/09d7652de219c48af0c5f29471dec99ac3675fd0))

### Feature

* feat: enhance repo-init script ([`0f20ba0`](https://github.com/antipodestudios/python-template/commit/0f20ba023db98be546d18d457d295b438cb08426))


## v1.2.0 (2023-01-20)

### Chore

* chore: remove unused code ([`49645e6`](https://github.com/antipodestudios/python-template/commit/49645e6992b3ac298b36c052ee329c4390088a6e))

* chore: change make rule name for generating env variable ([`1c40380`](https://github.com/antipodestudios/python-template/commit/1c40380952e8fc708136a8f3d71ec87dfcffcd19))

### Ci

* ci: add git user for release ([`e7a537e`](https://github.com/antipodestudios/python-template/commit/e7a537e44bdb2f5b5ed5fa03140c545d6c07bf68))

* ci(branches): add github actions for develop branch ([`1a2efe0`](https://github.com/antipodestudios/python-template/commit/1a2efe0f037af4df80ab19c56ea61f7847eb39cd))

### Feature

* feat(continous delivery): add the ability to publish the next version ([`7c14b75`](https://github.com/antipodestudios/python-template/commit/7c14b7585ab74dad8cfa867eb5ed60feca3ddd65))

* feat: ci for master branch ([`f0000bc`](https://github.com/antipodestudios/python-template/commit/f0000bc026bacf97d5dfe7ec0b53b57a42712cb9))

* feat: add semantic-release configuration ([`5b8a06f`](https://github.com/antipodestudios/python-template/commit/5b8a06fdbf97c6ca114c2b2fb6aaad350874a3d0))

* feat: launch code quality checkers in CI ([`499185d`](https://github.com/antipodestudios/python-template/commit/499185d3a94b7b2e73eb92d63d452f2ce01bef87))

* feat: use docker-compose ([`78931a1`](https://github.com/antipodestudios/python-template/commit/78931a1ee535eb413f8b15008da5b2df75644a74))

* feat: better makefile with docker info ([`2e86b27`](https://github.com/antipodestudios/python-template/commit/2e86b2710be3136d983435fc5be6131a586a68d0))

* feat: use dev containers ([`a81d577`](https://github.com/antipodestudios/python-template/commit/a81d5776ccbdb4e7a8a804e81419fc5485453955))

### Fix

* fix: repair again ([`d2e3140`](https://github.com/antipodestudios/python-template/commit/d2e3140ee3ace11a150b796feb6d9036f39cdc11))

* fix: try to repair release ([`7ca11ba`](https://github.com/antipodestudios/python-template/commit/7ca11bad2230133d2fb72177e9e06ad5431ff207))

* fix: repair release cd ([`c11aeee`](https://github.com/antipodestudios/python-template/commit/c11aeeed9e2c87eb2bf7c6432f06f99913c87458))

* fix: repair publish release ([`64909d0`](https://github.com/antipodestudios/python-template/commit/64909d0104ff2d2ea5c4561bf1fb146f1f5eb7fa))

* fix: change job name ([`c86a818`](https://github.com/antipodestudios/python-template/commit/c86a818b3d7a298f7bcc69f91e430bf13bab7a38))


## v1.1.0 (2022-12-19)

### Feature

* feat: enhance code quality checker ([`d10566b`](https://github.com/antipodestudios/python-template/commit/d10566b71ca428c9a098114f3a056bc14b63e9b2))

* feat: enhance Dockerfile ([`688fc44`](https://github.com/antipodestudios/python-template/commit/688fc44090ba3221d9d3934da60e7876e6ddbe4a))

* feat: use isort ([`29130eb`](https://github.com/antipodestudios/python-template/commit/29130eb3af64a947276b3ef9446b35422a18b436))

* feat: use mypy ([`db26c86`](https://github.com/antipodestudios/python-template/commit/db26c86547e585d040e1619118a6fdf8ead8f181))

### Unknown

* tests ([`12591a5`](https://github.com/antipodestudios/python-template/commit/12591a5e7206fec8f56b189e514819a31dec6a10))

* v1.1.0 ([`93f3491`](https://github.com/antipodestudios/python-template/commit/93f3491d27a1aa0395b96451116f92a9b1563163))

* config: poetry version upgraded to 1.3.1 ([`4630cfe`](https://github.com/antipodestudios/python-template/commit/4630cfec413c1510e4cc748453953403f9304702))

* template: add template version file ([`2a3ddca`](https://github.com/antipodestudios/python-template/commit/2a3ddcac541ee9f6ea16984d18a326eb61bdef0b))

* doc: enhance readme ([`3664622`](https://github.com/antipodestudios/python-template/commit/3664622dc51b81e328e9c403573c7e5e43d35ab6))

* config: vscode mypy + isort config ([`4b3e9d7`](https://github.com/antipodestudios/python-template/commit/4b3e9d70535d976de245e85b5b483a9995d49453))

* hotfix: repo-init.sh modifies README.md without destroying it ([`e2a0180`](https://github.com/antipodestudios/python-template/commit/e2a018024c813bc31bd7b754495ef0c037ac8949))


## v1.0.0 (2022-10-25)

### Feature

* feat: add init script ([`cdfd36f`](https://github.com/antipodestudios/python-template/commit/cdfd36fc72da2ae8bccfea86d0e5d8a6c06391d9))

* feat: code quality checker CI ([`89a2682`](https://github.com/antipodestudios/python-template/commit/89a2682f4bd81afaeb329a08a163ec347e3227bd))

* feat: first commit ([`97df20f`](https://github.com/antipodestudios/python-template/commit/97df20fd232e86aede19dc9ebccbe1cd8868a047))

### Unknown

* Merge pull request #4 from ademoverflow/develop

Develop ([`691f733`](https://github.com/antipodestudios/python-template/commit/691f733e446ff90e3a7b12451e1230912f6dcc5a))

* enhance init script ([`3857752`](https://github.com/antipodestudios/python-template/commit/385775248ff9ede2a07b5d4f5cab1dbc29da0aa5))

* add usage ([`03e2e4c`](https://github.com/antipodestudios/python-template/commit/03e2e4cfa0fa1c42785753471b2577a05dfe04ce))

* python 3.10 ([`bcc96d3`](https://github.com/antipodestudios/python-template/commit/bcc96d3d72dec7f311dac565c47231327eede721))

* Merge pull request #3 from ademoverflow/develop

Develop ([`4cc13ac`](https://github.com/antipodestudios/python-template/commit/4cc13ace64d720447086cd2affda9f0a3ef451ce))

* small fix ([`b7e491c`](https://github.com/antipodestudios/python-template/commit/b7e491c34bb8e63e01ec94a0daa0999c0b979fc2))

* script ok ([`d1aaecb`](https://github.com/antipodestudios/python-template/commit/d1aaecb32c5c5f8073bd77cd3702e9c8fddf66e2))

* update ([`d091fcb`](https://github.com/antipodestudios/python-template/commit/d091fcb9d295b87b6723e337a8d4def31642632c))

* update readme ([`b6db16a`](https://github.com/antipodestudios/python-template/commit/b6db16a266e160d1f058b623c73e309ba6576c38))

* Merge pull request #2 from ademoverflow/develop

Develop ([`affeb8f`](https://github.com/antipodestudios/python-template/commit/affeb8f6641dfeca61f448cc0d6ac710dcbd1f18))

* Merge pull request #1 from ademoverflow/github-actions

testing ([`e45c6cc`](https://github.com/antipodestudios/python-template/commit/e45c6ccd2139a445165706257a660071b8730d93))

* small update ([`a94d33a`](https://github.com/antipodestudios/python-template/commit/a94d33ab8e67e0fa42508f427d79c116d9a462e7))
