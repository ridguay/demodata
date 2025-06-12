# [15.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v15.3.0...v15.4.0) (2025-06-10)


### Features

* added interface storage accounts for data mall teams as part of the special purpose data set capability ([c89551c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c89551c9c446d577e8566969b8454fb79cd15fa7)), closes [#20642](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/20642)

# [15.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v15.2.0...v15.3.0) (2025-06-05)


### Features

* Add role assignments for file arrival triggers ([ea963d3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ea963d3d01392e1eb75052e26e990d141abfc337)), closes [#21107](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/21107)

# [15.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v15.1.1...v15.2.0) (2025-06-04)


### Features

* Changed Admin username on the virtual machines ([1c7fd3b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1c7fd3b01666c4b28bdc8d7fe74ced1091aebd16))

## [15.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v15.1.0...v15.1.1) (2025-05-27)


### Bug Fixes

* **meta:** Remove legacy code, move domain-specific base and functional into a domain folder. ([f3e4ffc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f3e4ffc58ea81d02eb36412f817c8201ee03e8a6))

# [15.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v15.0.0...v15.1.0) (2025-05-26)


### Features

* Added Integration Runtime App ([a3e657b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a3e657b67281d5615df2b49d3d41ad5d49132198))

# [15.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.32.0...v15.0.0) (2025-05-23)


### Features

* **meta:** Refactor meta subscription ([59c1a60](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/59c1a602a14c3895c74840b01fd1fa8066c4fe2d))


### BREAKING CHANGES

* **meta:** This change requires us to deploy meta from the base and functional layer. We will delete the legacy code in a follow-up pull request to keep it somewhat manageable to review.

# [14.32.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.31.0...v14.32.0) (2025-05-23)


### Features

* Remove toggle for data engineer and remove user-specific clusters for mall teams ([cfc7e66](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cfc7e66e596658b6585e3957d60396ed11be8673)), closes [#17797](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/17797)

# [14.31.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.30.2...v14.31.0) (2025-05-19)


### Features

* updated cluster version in terraform variables as default ([6a2f4cf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6a2f4cf1e35bec93bc37d115282fa1de5e1592dc)), closes [#17808](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/17808)

## [14.30.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.30.1...v14.30.2) (2025-05-15)


### Bug Fixes

* Network Security Group has been added to VM Nics to closed 4 vulnerabilities ([8a02b11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8a02b11a5f51f2c71873d04e19dd3051b46ceb72))

## [14.30.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.30.0...v14.30.1) (2025-05-14)


### Bug Fixes

* Added script to check the version of JRE installed on the SHiR vm's. To be used as a check if upgrade was successful. ([ad2545c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ad2545cdc757c4f69bad5664ebcb30f4c838b740))

# [14.30.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.29.3...v14.30.0) (2025-05-13)


### Features

* Add role assignments for Deloitte ([3890abc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3890abc6ccdcdc23a79cf8f426021a3d5222b6a0))

## [14.29.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.29.2...v14.29.3) (2025-05-13)


### Bug Fixes

* Updated JRE Install script to also restart the Integration Runtime Service after Java has been installed. ([6cf1e0a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6cf1e0a7e42fdeee30e86bfefc6e2e9938cf5f70))

## [14.29.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.29.1...v14.29.2) (2025-05-12)


### Bug Fixes

* Removed SAP IP Addresses from whitelist ([7355125](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7355125ecaaae525ecc8b92b5fcee4180c94d04f))

## [14.29.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.29.0...v14.29.1) (2025-05-01)


### Bug Fixes

* **meta:** Make a set for tfstate containers, remove unused modules ([eb8a58f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/eb8a58f3c4f42a22656459cdb75f50600dbb87fd))

# [14.29.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.28.0...v14.29.0) (2025-04-25)


### Features

* **adf:** Add diagnostic settings for second ADF ([755db9c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/755db9cbbd394edc52f9203d3e4a233cb64d63a9))

# [14.28.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.27.1...v14.28.0) (2025-04-23)


### Features

* Removed terraform configuration files and updated reference to new location ([44a7fd6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/44a7fd65ef9a433899e01e856337720468179133))

## [14.27.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.27.0...v14.27.1) (2025-04-23)


### Bug Fixes

* LibCurl Vulnerability fixed ([50bdb3e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/50bdb3e2bbf67ed581ab61537761962cc854a900))

# [14.27.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.26.0...v14.27.0) (2025-04-23)


### Features

* Allow Azure services to access sources key vault ([757a4ef](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/757a4ef0a16930050481aab4202fb12ab0a3fc0a))

# [14.26.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.25.2...v14.26.0) (2025-04-22)


### Features

* force annotated tag creation in semantic-release ([1b8c63f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1b8c63facea4a52decefa003dc18cb6b4744b803))

## [14.25.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.25.1...v14.25.2) (2025-04-16)


### Bug Fixes

* Add gitignore whitespace ([a48842b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a48842b85bc7f1fd3e3958ac7ced23c2a54ef948))

## [14.25.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.25.0...v14.25.1) (2025-04-15)


### Bug Fixes

* Dummy change ([009c093](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/009c0938fb414d45eaa7ddb9fac814065d3ea074))

# [14.25.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.24.0...v14.25.0) (2025-04-15)


### Features

* Update storage account flags in PRD for all envs ([99b28c9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/99b28c98b3f99a565919fcc388cd330879ecd43a)), closes [#18028](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/18028)

# [14.24.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.23.0...v14.24.0) (2025-04-10)


### Features

* Update Spark version for individual to 15.3 LTS ([eafa944](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/eafa9446407bd39de7f34a7f9fbf9ae757c93eee))

# [14.23.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.22.2...v14.23.0) (2025-04-02)


### Features

* Remove the PE from the new ADF in dev ([aa79bde](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/aa79bde7ed27d89d7fc670c1852bbdc953efdd3e)), closes [#18052](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/18052)

## [14.22.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.22.1...v14.22.2) (2025-04-01)


### Bug Fixes

* Remove demo2 pdv, add ip space to ind ([3c7a201](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3c7a201f4dc08b4bd5d94ecd2de884ef75a73b04))

## [14.22.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.22.0...v14.22.1) (2025-04-01)


### Bug Fixes

* Storage Account for SAP Datasphere POC ([6da5c9e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6da5c9e1359a8f2c316f60a2ffa2ef791ed35f8b))

# [14.22.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.21.0...v14.22.0) (2025-04-01)


### Features

* 16928 Update storage account key settings to comply with NN policies ([8a46020](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8a46020f4fd38be150428cb2df89f9d8e1586961)), closes [#16928](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16928)

# [14.21.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.20.4...v14.21.0) (2025-04-01)


### Features

* tf modules for Deloitte storage account and yaml configuration file modified ([dbfb66a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/dbfb66a77ac3889f7bf88d486c07f65deda67600)), closes [#16791](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16791)

## [14.20.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.20.3...v14.20.4) (2025-04-01)


### Bug Fixes

* add condition for MPE name output in ADF module ([34bd794](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/34bd7945b4154af6867097d23fbbefaff36e0271))

## [14.20.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.20.2...v14.20.3) (2025-04-01)


### Bug Fixes

* Entra group names for Unity Catalog ([5d43935](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5d439351f676343786ab9e64a0839fc3a48b9029))

## [14.20.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.20.1...v14.20.2) (2025-04-01)


### Bug Fixes

* Add each.value to retryable errors for adf_deploy_component_payloads ([e3593b1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e3593b1b4a24b18b0270a3586ed9df5e0cb33f52))

## [14.20.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.20.0...v14.20.1) (2025-04-01)


### Bug Fixes

* Move Entra ID groups for UC to config files ([3befc00](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3befc00566b8337c771f42fcd68f528f2c423db1))

# [14.20.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.7...v14.20.0) (2025-03-28)


### Features

* Onboard GLAM to Unity Catalog ([de411e3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/de411e38674b0d2e26a61c0d5f4d3a28f405c3b7))

## [14.19.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.6...v14.19.7) (2025-03-26)


### Bug Fixes

* Rename ADF managed private enpoint (ommitting env name) ([23acc0e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/23acc0e5d11987118cd674e60fdf8441f52ea52c)), closes [#17454](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/17454)

## [14.19.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.5...v14.19.6) (2025-03-25)


### Bug Fixes

* Removed the SAP HANA Principals from the code and variables ([1f1d9bf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1f1d9bf7f8c257f5d2905f966c8d0d0bd090c9e8))

## [14.19.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.4...v14.19.5) (2025-03-25)


### Bug Fixes

* Entra ID group name construction for UC permissions ([90c8988](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/90c89887e8ad67ed5134ccf6813fd25c8f0e9beb))

## [14.19.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.3...v14.19.4) (2025-03-25)


### Bug Fixes

* BDT onboarding to Unity Catalog ([b34d763](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b34d7631a2b332cebbeb8f009ec5fa6ddf30a05b))

## [14.19.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.2...v14.19.3) (2025-03-25)


### Bug Fixes

* Glam users and DE Removal Pns, Ind and CnW ([76e1e16](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/76e1e16713eea349dc21e0884cb854f3da2baff2))

## [14.19.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.1...v14.19.2) (2025-03-24)


### Bug Fixes

* Disable Data Engineer Roles Pns Acc ([ff1d92c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ff1d92c559e14c09e5ac1c1c23a1b39e566a32e3))

## [14.19.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.19.0...v14.19.1) (2025-03-20)


### Bug Fixes

* Add Service Principal as a Storage Table Data Contributor ([0b1d4c1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0b1d4c1de4c55ba21708fe7d473c06b5fff9f892))

# [14.19.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.18.1...v14.19.0) (2025-03-20)


### Features

* Glam configuration added ([3d7efd5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3d7efd535a61883d728ae888273456dd1fd64f62))

## [14.18.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.18.0...v14.18.1) (2025-03-19)


### Bug Fixes

* Added User Access Administrator role for IAM ([bff6aa1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/bff6aa15f6260cb737a8e6f47239fa0478b15f21))

# [14.18.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.17.3...v14.18.0) (2025-03-19)


### Features

* Decom legacy clusters for pensions ([c7cebb6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c7cebb60629ea7073065d23c27a6e129505b9c3d)), closes [#17607](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/17607)

## [14.17.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.17.2...v14.17.3) (2025-03-14)


### Bug Fixes

* Fixed demo1 and demo2 again ([fde2071](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fde20718acfa33a4bf62ca7da2611c8604bf3f24))

## [14.17.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.17.1...v14.17.2) (2025-03-14)


### Bug Fixes

* Legacy clusters was missing ([3adf66f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3adf66f156db3c822786b9bf03e3bdded2b8fbef))

## [14.17.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.17.0...v14.17.1) (2025-03-14)


### Bug Fixes

* Disable UC for BDT platform ([64fc9cb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/64fc9cb4cfe656e41882dff68125cff11b53540d))

# [14.17.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.6...v14.17.0) (2025-03-14)


### Features

* Onboard BDT and fix the role assignments ([c09349a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c09349aa21e07edeb268424e51bf10ff72fa7e33))

## [14.16.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.5...v14.16.6) (2025-03-11)


### Bug Fixes

* add permissions for the new ADF ([5c9e9d7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5c9e9d7c1fe920feb1816f048c28ff44628e23bc))

## [14.16.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.4...v14.16.5) (2025-03-11)


### Bug Fixes

* pin Terraform provider versions in modules ([c2deca8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c2deca8f2338a0877988aca68e968d9c7a77df01)), closes [#17067](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/17067)

## [14.16.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.3...v14.16.4) (2025-03-11)


### Bug Fixes

* Updated Java Runtime Environment VM Application ([43d73e4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/43d73e454b214aa19e7471f8a29929c207b4288d))

## [14.16.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.2...v14.16.3) (2025-03-11)


### Bug Fixes

* Add lifecycle rules back to kv and storage networking ([72af973](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/72af973480501776738a46adc65e5148c8389acc)), closes [#17072](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/17072)

## [14.16.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.1...v14.16.2) (2025-03-10)


### Bug Fixes

* cluster size for pensions ([7718803](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/771880301e0bf879456c0210b659a2a7bec04ee2)), closes [#16968](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16968)

## [14.16.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.16.0...v14.16.1) (2025-03-10)


### Bug Fixes

* Role Assignments bug fix. It was impossible to assign two or more roles to a service principal and storage containers fix. ([3a1733e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3a1733ececcfefd0fdb60ac4e49636d95787caf3))

# [14.16.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.15.0...v14.16.0) (2025-03-10)


### Features

* Add VSTS config to second ADF in dev env ([02509a4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/02509a4c1b17441e111d38b7c9d85d1d8dfc3107)), closes [#16866](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16866)

# [14.15.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.14.0...v14.15.0) (2025-03-10)


### Features

* Add Azure IR for C&W, fix Azure IR name for both ADFs ([ea670f2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ea670f28b7b648b9c3450c3176e18d59c2cc0a23)), closes [#16932](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16932) [#16933](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16933)

# [14.14.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.13.1...v14.14.0) (2025-03-07)


### Features

* add milan to meta ([cc00881](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cc00881746d6d7fa2b767ce99d3add28e4211840))

## [14.13.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.13.0...v14.13.1) (2025-03-06)


### Bug Fixes

* Hopefully fixes issues and also request from CnW Implemented in dev, tst and acc for SAP CDC Extraction ([2369c99](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2369c993dd2d2e17a26725a00e7d9b0f95fe82da))

# [14.13.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.12.4...v14.13.0) (2025-03-06)


### Features

* Created a toggle to enable/disable the deployment of legacy clusters. ([2028ea7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2028ea791daf50d175b978c8468b895133fa4d1e))

## [14.12.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.12.3...v14.12.4) (2025-03-05)


### Bug Fixes

* ensure the VM name for mall-main does not exist 15 chars ([5a2f277](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5a2f2778eac814c1cccec3a19a8b65bd39da67c3))

## [14.12.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.12.2...v14.12.3) (2025-03-05)


### Bug Fixes

* skip for custom_notebooks in mall type instances ([cc0506d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cc0506d152949600aa1dd7b283f8bca634084fcc))

## [14.12.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.12.1...v14.12.2) (2025-03-05)


### Bug Fixes

* UC enabled flags in pdv ([5895d8d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5895d8d6bc8b0e76e4a233eb94657a5981fc93b3))

## [14.12.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.12.0...v14.12.1) (2025-03-04)


### Bug Fixes

* add second ADF instance to mall-main in sbx and pdv ([49b7055](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/49b705590ba1ba1c5752acd39d4aa479281c1f0a))

# [14.12.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.11.0...v14.12.0) (2025-03-03)


### Features

* merge the mall and domain products into a single product ([b9cff42](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b9cff423c300f696c568db0bee57a7917cc2ddf7)), closes [#16123](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16123)

# [14.11.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.10.0...v14.11.0) (2025-03-03)


### Features

* Created a new ADF, moving from single terragrunt variable to list of ADF. ([a011283](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a0112833910c46d7f013536045da7218fb8665b2)), closes [#14209](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/14209)

# [14.10.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.9.2...v14.10.0) (2025-03-03)


### Features

* Add Fokke's CPA user to individual team's DE config ([c2a7b83](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c2a7b8398f633022e59ffa211673f145719debc8)), closes [#16724](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16724)

## [14.9.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.9.1...v14.9.2) (2025-02-27)


### Bug Fixes

* Ensure modules are ordered correctly so UC volume can be created ([ec32cc3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ec32cc32731dcf96588f8d8bccb3924bcc8629e9)), closes [#16609](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16609)

## [14.9.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.9.0...v14.9.1) (2025-02-27)


### Bug Fixes

* Add toggle for UC volumes, fix private DNS zone bindings for PEs ([1d4bbd1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1d4bbd101561ed007092dd2d98f526150420cc4e)), closes [#16609](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/16609)

# [14.9.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.8.1...v14.9.0) (2025-02-24)


### Features

* Update cluster settings for pensions: min 1 worker, disable Photon ([2d2dcd9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2d2dcd91891a028b1da8af512f1555a46ecdb9c0)), closes [#15958](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/15958)

## [14.8.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.8.0...v14.8.1) (2025-02-21)


### Bug Fixes

* Added VM App for CDC Driver ([7e3d260](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7e3d2602f8d0aa46bb107b349a2caa407c8ec0c6))

# [14.8.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.7.1...v14.8.0) (2025-02-19)


### Features

* Added Storage Account table private endpoint and access for the adf service principal. ([f273899](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f273899e6d16cfbd639d5adb9171d55fe52757df))

## [14.7.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.7.0...v14.7.1) (2025-02-18)


### Bug Fixes

* Change schedules to match Windows Updates pipeline ([9daaf3a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9daaf3a8172d030daa38c4bd7eac5df9bcdc447c))

# [14.7.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.6.2...v14.7.0) (2025-02-11)


### Features

* Added databricks workspace, storage and roles for IAM reporting. ([39f8efb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/39f8efb73105ebdbdd70d6a77b82d910dff81954))

## [14.6.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.6.1...v14.6.2) (2025-02-06)


### Bug Fixes

* mall Entra group name suffix ([8db5796](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8db57963e2a8a42ccfe1a96b6d518a458fec8fb7))

## [14.6.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.6.0...v14.6.1) (2025-02-06)


### Bug Fixes

* LAW for IAM added to Meta and platform product now send Activity log to IAM LAW ([c4ca960](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c4ca960460c8b6f6857831aeb236436868221665))

# [14.6.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.5.0...v14.6.0) (2025-02-05)


### Features

* Added CIS Hardening VM App to VM's ([1f01480](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1f0148065b9f80691d8c10a0497682468e334952))

# [14.5.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.7...v14.5.0) (2025-02-03)


### Features

* Add new build agents pool ([5378486](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/537848621b952bccb99600db370ce80dc9a8faa7))

## [14.4.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.6...v14.4.7) (2025-02-03)


### Bug Fixes

* Smaller cluster individual dev ([4301954](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/43019546a89a3c8eaaf266d3104c4010dc1eb37f))

## [14.4.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.5...v14.4.6) (2025-02-03)


### Bug Fixes

* Downscaled Pensions SHiR VM Acc ([36600ce](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/36600ce81e280461164dbb41c63450d0324dfb62))

## [14.4.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.4...v14.4.5) (2025-02-03)


### Bug Fixes

* granting UC permissions on SP and group ([4f16532](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4f1653208ce85aec7535342fb371f58ee85f29a3))

## [14.4.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.3...v14.4.4) (2025-01-29)


### Bug Fixes

* Pensions Shir vm even bigger ([f8e7239](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f8e72390df21c468797f9dd7cddab5d1de2ea2cd))

## [14.4.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.2...v14.4.3) (2025-01-29)


### Bug Fixes

* Added Artifactory Username and password changes to mall product ([9c17255](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9c17255a60216556ae2bcf8eaebd2f49ac05a19e))

## [14.4.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.1...v14.4.2) (2025-01-29)


### Bug Fixes

* Revert "Merged PR 2506: Unity Catalog schema and volume creation + granting group permissions ([714572d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/714572dfdc746f5a4d44c091fe944e8098c8d823))

## [14.4.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.4.0...v14.4.1) (2025-01-29)


### Bug Fixes

* Fix whitespace to trigger new release ([1c1a74c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1c1a74cd4ecedb23c474ef1224fe5b37b35fcf55))

# [14.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.3.0...v14.4.0) (2025-01-29)


### Features

* Updated variables.tf ([806e340](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/806e340e49a3dcc09d8d42a6753c59ba6c815455))

# [14.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.2.3...v14.3.0) (2025-01-29)


### Bug Fixes

* Removed unused and problematic code from the UC Databricks cluster init script which could cause issues when starting the clusters. ([2d8144c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2d8144c7fa75abc0bb7c6d5075b93cd1ae4ab81c))


### Features

* Create a UC schema (lpdap_databricks_cluster) and a volume underneath it (cluster_packages), that will be owned by the service principal.Rights to the Entra group will be granted: [READ VOLUME],[USE SCHEMA], so the objects are visible in the UI to the group members. ([29a4c3b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/29a4c3b321bc9ef07a18ce4d0e2f74bcb5adc699))
* Removed the user id from Menno from the code and changed it to a npa account. ([7e6bef8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7e6bef8b6f796a41a8bf0467f612f8cbbb0eb059))

## [14.2.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.2.3...v14.2.4) (2025-01-23)


### Bug Fixes

* Removed unused and problematic code from the UC Databricks cluster init script which could cause issues when starting the clusters. ([3267c51](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3267c51ba66288afe0b0c602c538bdc4d6660c53))

## [14.2.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.2.2...v14.2.3) (2025-01-21)


### Bug Fixes

* **PNS:** Temporary Upscale VM size PNS ACC ([62cbe61](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/62cbe6110dc37336a6f0d6a301a6dbcdc04c0c98))

## [14.2.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.2.1...v14.2.2) (2025-01-20)


### Bug Fixes

* Onboard Individual to Unity Catalog in Predev ([d68c284](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d68c2844fc1c3238c773608827631b5298067355))

## [14.2.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.2.0...v14.2.1) (2025-01-15)


### Bug Fixes

* ADF KV Sources Role Assignment ([e63b331](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e63b331891968d447ce31a038424ad15cfae294e))

# [14.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.13...v14.2.0) (2025-01-15)


### Features

* **Databricks:** Parametrize cluster configuration ([4f01114](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4f01114b5ad99e1bc340e69d9d458bb674ecfab4)), closes [#14677](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/14677)

## [14.1.13](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.12...v14.1.13) (2025-01-10)


### Bug Fixes

* **mall:** Meta key vault vars and artifactory password data object ([4d72913](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4d72913a386318e503f5db5ddeff637cffd4b1c0))

## [14.1.12](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.11...v14.1.12) (2025-01-09)


### Bug Fixes

* Some tech debt, bugs preventing from deploying from scratch ([9333130](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9333130e0dd5adee14cb512bd5a880b44a065496))

## [14.1.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.10...v14.1.11) (2025-01-09)


### Bug Fixes

* Fixed two possible errors that could cause the init script to fail (exit not 0) ([df7ba89](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/df7ba89196dadaa1a04827e24fdf538583b8d699))

## [14.1.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.9...v14.1.10) (2025-01-06)


### Bug Fixes

* Added VM apps in tst, acc and prd ([1a4aedb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1a4aedb5338240d6ed910db015f9b24fc63943d7))

## [14.1.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.8...v14.1.9) (2025-01-03)


### Bug Fixes

* Removed the certificates workaround from UC Cluster init script ([103019b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/103019b24b0e2094539d7ca870d0cab3d81e3c5d))

## [14.1.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.7...v14.1.8) (2025-01-02)


### Bug Fixes

* Added VM Apps in Dev, to test if the drivers really work with ADF Sources. ([2f33ccf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2f33ccf0a4430ca8ec2482d444c20349f34b8d70))

## [14.1.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.6...v14.1.7) (2025-01-02)


### Bug Fixes

* **configuration:** Add missing PDV config for Pensions ([fa86397](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fa86397d4b32d8efe0e9851d5d437bffa9617281))

## [14.1.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.5...v14.1.6) (2025-01-02)


### Bug Fixes

* 7781 - VM Application : SAP HANA Driver ([4644064](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4644064b5c5f2fb8d1cbbf20ae07c1c8f88544f5))

## [14.1.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.4...v14.1.5) (2024-12-19)


### Bug Fixes

* tfstate container list ([27243ff](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/27243ff6d717c11c295214d4b6378e4c31d65228))

## [14.1.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.3...v14.1.4) (2024-12-19)


### Bug Fixes

* Restored generic_subnet folder needed by meta ([9b49c69](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9b49c6908c2d2b34d3582d81c6e77f3195704d63))

## [14.1.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.2...v14.1.3) (2024-12-17)


### Bug Fixes

* Removed reconfig from code ([3e3cdb8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3e3cdb8da8c3e2a8715b90bf240afb139dd70dbd))

## [14.1.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.1...v14.1.2) (2024-12-16)


### Bug Fixes

* Removed Networking folder from Platform Product and platform network configuration from the configuration files. ([880d727](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/880d7271223035a76668ae14586657eb78833b33))

## [14.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.1.0...v14.1.1) (2024-12-09)


### Bug Fixes

* Added quote for ip address ([b57055f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b57055f3f9e2f5cdb7bd9c2337f711d5a36e9988))

# [14.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.0.4...v14.1.0) (2024-12-06)


### Features

* Created toggle variable for deploying or not UC modules. ([2d40a12](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2d40a127af2c157d309ec7fd7abbad2d5ebf0948))

## [14.0.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.0.3...v14.0.4) (2024-12-06)


### Bug Fixes

* Add 2 role assignments to Automation Identity ([d3e4c2a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d3e4c2a2a689dfdde43ecb9fa40d918e459dbf15)), closes [#11494](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/11494)

## [14.0.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.0.2...v14.0.3) (2024-12-05)


### Bug Fixes

* Pensions private endpoints for TST ([e4ab988](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e4ab9884931a6ae68a86d2d9ca5e29a7705c7f12))

## [14.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.0.1...v14.0.2) (2024-12-05)


### Bug Fixes

* **tech debt:** Remove unnecessary Databricks stuff, add sleep to storage module ([7702218](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7702218ddfd2b201a6414b4538c9ad6ce1441946))

## [14.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v14.0.0...v14.0.1) (2024-12-04)


### Bug Fixes

* Revert databricks subnet ranges ([892a930](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/892a930635e0c36e8b55f9fd5e13ef5d65c21406))

# [14.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.11...v14.0.0) (2024-12-02)


### Features

* Networking Domain Split ([d332adb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d332adb02d1c78820fb26036b31899c9afd6aad7))


### BREAKING CHANGES

* In this PR, we implement in-product subnets to isolate the domain instances and make them independent of the overarching platform product.

## [13.5.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.10...v13.5.11) (2024-11-26)


### Bug Fixes

* Fixed the configuration files for individual and pensions. ([3c58d51](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3c58d514c122afffe312304bb34aad7ad15452f5))

## [13.5.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.9...v13.5.10) (2024-11-25)


### Bug Fixes

* Fixed roles deployment data engineers ([d6467b3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d6467b394b281f167575a7761855a9fa3cc25dc4))

## [13.5.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.8...v13.5.9) (2024-11-25)


### Bug Fixes

* Roles Data Engineers will not be deployed to dev and tst ([e40b5e2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e40b5e2744c735232676ecb6926b38965870af0a))

## [13.5.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.7...v13.5.8) (2024-11-20)


### Bug Fixes

* For the Pensions CDC POC Public access to the storage account is needed. ([48b43a5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/48b43a5cf5a3d724d844c45f3dee8e0abab85839))

## [13.5.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.6...v13.5.7) (2024-11-20)


### Bug Fixes

* UC Volume Name in Predev ([dd41b31](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/dd41b31188e37bf4eb4a19d84cb31de17744f321)), closes [#13068](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/13068)

## [13.5.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.5...v13.5.6) (2024-11-20)


### Bug Fixes

* Disabled Data engineers Role deployment in individual.yaml ([b2ba1cd](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b2ba1cd2344885f9b1465fc57aabebe7a6663011))

## [13.5.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.4...v13.5.5) (2024-11-19)


### Bug Fixes

* Replaced Jeroen's Account with Menno's ([a21bfad](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a21bfadb9f477707cc66c34d737dec11a50ca6f1))

## [13.5.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.3...v13.5.4) (2024-11-19)


### Bug Fixes

* Test release pipeline. ([21798eb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/21798eb55575c56f732f9cf6b415bca9773d9eec))

## [13.5.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.2...v13.5.3) (2024-11-18)


### Bug Fixes

* Dependencies for databricks resources and deploy-to-dev modules ([a7128d7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a7128d7f82db8b571f4d625d5feb84e233e06a12))

## [13.5.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.1...v13.5.2) (2024-11-14)


### Bug Fixes

* Remove ref to uc user specific clusters ([25558a0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/25558a09401bcd809784fc6fe3203bf2b0b2f3af))

## [13.5.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.5.0...v13.5.1) (2024-11-14)


### Bug Fixes

* Inconsistent lock files ([d259a27](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d259a2791064c477ddfdd7bca04a2d25d6087da8))

# [13.5.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.4.0...v13.5.0) (2024-11-14)


### Features

* Add linked services for UC user-specific clusters ([fa3f020](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fa3f0200998e0b8a5a50ceddb67eea4269f57c71)), closes [#12825](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/12825)

# [13.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.3.0...v13.4.0) (2024-11-14)


### Features

* Move Databricks clusters and workspace config from Base to Functional ([9e1972a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9e1972a34843b2926843082933e3e3074f893231)), closes [#12407](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/12407)

# [13.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.13...v13.3.0) (2024-11-14)


### Features

* add a Version blob on the meta storage container to identify infra version ([07f4f73](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/07f4f739ef1db3a417c11b18a9876d1587bb8137)), closes [#10992](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/10992)

## [13.2.13](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.12...v13.2.13) (2024-11-13)


### Bug Fixes

* Disabled Infra roles Deploy CnW data engineers Tst ([28a49c8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/28a49c8055248cb0930e28c8f0cd3bfad5921ec4))

## [13.2.12](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.11...v13.2.12) (2024-11-13)


### Bug Fixes

* Disabled Role deployment CnW dev ([57a621d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/57a621d01be5a0d20d21c116be2c63f5168165a9))

## [13.2.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.10...v13.2.11) (2024-11-12)


### Bug Fixes

* Created config files for predev ([16841db](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/16841db21de3eb3b5a5769d6f2b24343e0429b19))

## [13.2.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.9...v13.2.10) (2024-11-12)


### Bug Fixes

* Updated pensions.yaml, disable deploy data engineers roles in tst ([184b93c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/184b93cc39f50170bff0fb366597150218737082))

## [13.2.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.8...v13.2.9) (2024-11-11)


### Bug Fixes

* Updated pensions.yaml do not deploy data engineers. for iam roll out to pensions dev ([c745b15](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c745b15289ada3f7296884536a825d7a1121b215))

## [13.2.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.7...v13.2.8) (2024-11-08)


### Bug Fixes

* Added local. ([a378c9b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a378c9bf9045674c1903e7ceb5db22790669f950))

## [13.2.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.6...v13.2.7) (2024-11-07)


### Bug Fixes

* Fixed IAM Issues with App ID's and Object ID's. ([41bbf5f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/41bbf5f482ea1d61288ab773cddf25a76387cf73))

## [13.2.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.5...v13.2.6) (2024-11-07)


### Bug Fixes

* The correct IAM Application ID. ([cd2db1f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cd2db1f9074b1a1772fab655f6732cce744cf07f))

## [13.2.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.4...v13.2.5) (2024-11-07)


### Bug Fixes

* Proper Address Space for SBX ([f38cc34](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f38cc34433da8755ffd5cdd28ed91d42b5a85b2a)), closes [#12473](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/12473)

## [13.2.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.3...v13.2.4) (2024-11-06)


### Bug Fixes

* Individual configuration file boolean wrong value ([3f9d57c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3f9d57ccf2b8066df5f70589ce7a2101beea4904))

## [13.2.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.2...v13.2.3) (2024-11-05)


### Bug Fixes

* Missing variable Mall product ([5530773](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/55307731095a188f5ea375823988c1cbfa03e7c1))

## [13.2.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.1...v13.2.2) (2024-11-05)


### Bug Fixes

* Remove sandbox network dependencies ([3b2fefd](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3b2fefd3dc23663cf74b67479dbefc51d6bb2b07))

## [13.2.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.2.0...v13.2.1) (2024-11-05)


### Bug Fixes

* Created a toggle for Role deployment Data Engineers ([4fe8ae1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4fe8ae1ed65198183c3c1c7fca7cfc35b824fcb0))

# [13.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.11...v13.2.0) (2024-11-05)


### Features

* Virtual Network for Sandbox Environment ([a25228e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a25228edd4277bfc35aacc6fcf37edf9c90d727e)), closes [#12386](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/12386)

## [13.1.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.10...v13.1.11) (2024-10-31)


### Bug Fixes

* Also contributor role is needed for creating the custom roles. ([996ee32](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/996ee32aa52195dadc1aca37bb99bab9e07dde8b))

## [13.1.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.9...v13.1.10) (2024-10-31)


### Bug Fixes

* Added IAM Service Principal with the Role Based Access Control Administrator to the platform product. ([f8bf5b6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f8bf5b60c1fd1b7eb2ffa1fbc2c73c88fe0071c3))

## [13.1.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.8...v13.1.9) (2024-10-31)


### Bug Fixes

* Small changes to Container registry and some bugfixes in the dependency paths. ([02dd253](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/02dd25391121d47c66c06bde1a1f6b8f56f4cb10))

## [13.1.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.7...v13.1.8) (2024-10-29)


### Bug Fixes

* Storage DAC permissions ([de9593c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/de9593c9022307d6392c28f8f51ac467df6fd0d2))

## [13.1.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.6...v13.1.7) (2024-10-28)


### Bug Fixes

* Added hosted agents subnet and nsg to meta code. ([0c66f1b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0c66f1bcfd6a9fafd79a2060c48f8101e4b88594))

## [13.1.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.5...v13.1.6) (2024-10-28)


### Bug Fixes

* Added photon mode from feature 12145-Enable_Photon to mall main ([0e4165c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0e4165c090bc61e97e60576dac3fa49c2d5295e3))

## [13.1.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.4...v13.1.5) (2024-10-25)


### Bug Fixes

* Replace substring comparison with regex based expression ([9472ef2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9472ef22a7a442655769258578e271004c74d39b))

## [13.1.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.3...v13.1.4) (2024-10-24)


### Bug Fixes

* Enabled Photon on the Unity Catalog cluster ([417745b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/417745b366a3b54374d6e7bd4b4208a94a4cbf20))

## [13.1.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.2...v13.1.3) (2024-10-24)


### Bug Fixes

* Correct Object ID for LPDAP-IAM-EA ([c7e1cb0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c7e1cb005d699682dc28cdb906bea60b9d09a12d))

## [13.1.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.1...v13.1.2) (2024-10-24)


### Bug Fixes

* Fixed the skip logic for package/library ([73c0c7c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/73c0c7cf34bd31b7f4a73840be7973b6be35202e))

## [13.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.1.0...v13.1.1) (2024-10-24)


### Bug Fixes

* Added IAM keyvault to meta subscription (10860) ([0f6b55f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0f6b55ffd609f46fa9d32ee37ce90fa37465404f))

# [13.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.11...v13.1.0) (2024-10-24)


### Features

* Added uc individual clusters, using same logic as before so that they have the same connectivity/IAM ([91e0b29](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/91e0b29c7f1bda5b94d559fc804c2b1e20c64f70))

## [13.0.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.10...v13.0.11) (2024-10-21)


### Bug Fixes

* endtime = duration ([1bdb9a6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1bdb9a628df298b62375ec7dc8edf61348209e26))

## [13.0.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.9...v13.0.10) (2024-10-21)


### Bug Fixes

* Time slots development changed due deployment error ([1dd1a60](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1dd1a602cb666456f95a7f7d14b130f4df275046))

## [13.0.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.8...v13.0.9) (2024-10-21)


### Bug Fixes

* Add version constraint for the Azure API provider in the functional layer ([7476840](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/747684001329a7735c8ce2784bb9e82193e0a6de))

## [13.0.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.7...v13.0.8) (2024-10-21)


### Bug Fixes

* Changed the schedule of the windows updates installation. ([79483dc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/79483dca2182f9f59fd87b16c3555c7b1ce33a4e))

## [13.0.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.6...v13.0.7) (2024-10-21)


### Bug Fixes

* **refactor:** Clean up legacy code after phase 5 of the infrastructure refactoring ([6c2a900](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6c2a900227b39972de676d0e044839368fa3f671))

## [13.0.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.5...v13.0.6) (2024-10-10)


### Bug Fixes

* remove updated cert stores for all connections except Kafka ([e51eabb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e51eabba8633de7b62ad63ec2aebe18ff29c5d2c)), closes [#11546](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/11546)

## [13.0.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.4...v13.0.5) (2024-10-09)


### Bug Fixes

* Fixed hardcoded folder ([58277de](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/58277de7406def4c2465bd8199d35d7a9ec40852))

## [13.0.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.3...v13.0.4) (2024-10-09)


### Bug Fixes

* Kafka & Unity Catalog fix ([9b53711](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9b5371181aa50025a7a69bbf1565b05f842f7408))

## [13.0.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.2...v13.0.3) (2024-10-08)


### Bug Fixes

* add retryable errors, fix UC init script location ([7a62caf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7a62cafe55881e91b1b6b3c41acb84aa6e12d154))

## [13.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.1...v13.0.2) (2024-10-08)


### Bug Fixes

* update Terragrunt lock files ([7c2f160](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7c2f1607fa7683da8497857043c85c1004d3cb23))

## [13.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v13.0.0...v13.0.1) (2024-10-08)


### Bug Fixes

* Add fixes for dev phase 5 rollout ([6637b14](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6637b14d1b395ba8d2ab9e441b71020ae0279605)), closes [#9885](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/9885)

# [13.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.8.0...v13.0.0) (2024-10-08)


### Features

* Merge modules from base layer and functional layer into two bigger modules ([126bff5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/126bff5c19827a8c298a1b7c0d44e9401175d34c))


### BREAKING CHANGES

* Merge base layer into one module and merge functional layer into one module

# [12.8.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.7.3...v12.8.0) (2024-10-07)


### Features

* the wheel file (.whl) is moved from dbfs to the external UC volume using "databricks_file" resource. ([3bfdb38](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3bfdb38236a67f44ee31722fbb4321d46f840b41)), closes [#10865](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/10865)

## [12.7.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.7.2...v12.7.3) (2024-10-03)


### Bug Fixes

* Made start_time for turning on the vm's allways one day in the future ([6dc34e7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6dc34e7cadecee6fcc5a7d1aad8aef79622e35ad))

## [12.7.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.7.1...v12.7.2) (2024-10-02)


### Bug Fixes

* rename the UC cluster resource name for easier merging of the modules later ([276bc02](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/276bc029d56fa74ffbb3c8275d792493790fbdde))

## [12.7.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.7.0...v12.7.1) (2024-09-27)


### Bug Fixes

* Added Wilma with CPA to PNS and CnW INC1669815 ([40dff9f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/40dff9f62c55f6e43737045dfccb863118b2097c))

# [12.7.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.6.1...v12.7.0) (2024-09-26)


### Features

* this PR creates a new LAW at the domain level, also moves all the domain reference to this new one law. ([43c39a7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/43c39a7d61e601b8b1fc32842e27e40b0d05bd92))

## [12.6.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.6.0...v12.6.1) (2024-09-24)


### Bug Fixes

* Add retryable error for pending clusters ([9eafd8c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9eafd8cb024ed2e348ed9c9062fa984eac3f1086))

# [12.6.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.5.2...v12.6.0) (2024-09-24)


### Features

* add env- and product specific pypi packages to databricks clusters ([c7e4d28](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c7e4d2839d5cca0090a4ee3285b65774cfdc166a)), closes [#10552](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/10552)

## [12.5.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.5.1...v12.5.2) (2024-09-23)


### Bug Fixes

* Bump databricks provider version ([bc94997](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/bc949973fa4f0da638afbab53df835875912d6bf))

## [12.5.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.5.0...v12.5.1) (2024-09-22)


### Bug Fixes

* Intergration Runtime also needed port 443 incoming ([824f7a0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/824f7a0b1576ba5a065dc4dc50bf178631a529ed))

# [12.5.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.4.3...v12.5.0) (2024-09-18)


### Features

* Added automatic starts for vms so that the windows update can take place ([fce792a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fce792abde05b1d97f3dab7f82f06754a87107ef))

## [12.4.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.4.2...v12.4.3) (2024-09-18)


### Bug Fixes

* Log Analytics depency path was wrong. ([ba14dd8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ba14dd86211c88632c3ae45a5d3a7f5a328450b6))

## [12.4.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.4.1...v12.4.2) (2024-09-16)


### Bug Fixes

* Deployment error was due to SHiR VM not turned on. ([2581b4c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2581b4ce5d90ad6a8a73aa21f739a930c6256c0b))

## [12.4.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.4.0...v12.4.1) (2024-09-16)


### Bug Fixes

* Disabled Linked Service creation for UC cluster_main ([55d5bf0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/55d5bf0811a237727781326e4db2aa7b6724c0de))

# [12.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.3.0...v12.4.0) (2024-09-12)


### Features

* Added new databricks cluster with a new name (cluster_main), using the delta cache accelerated virtual machines and runtime version 14.3. ([bea8b1e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/bea8b1eb3a2232012345aae5f2c34937502023c9))

# [12.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.2.0...v12.3.0) (2024-09-12)


### Features

* Created a schedule that will re-use the turnonvms run notebook to turn on the notebooks every 4 weeks ([57cac2c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/57cac2cb0fbfbf026f1fae84c44150ecb56770ba))

# [12.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.1.1...v12.2.0) (2024-09-11)


### Features

* Removed allow all security rule from the firewall security group. If anything breaks, which we do not expect, we can either move it to the correct ports from the other two rules or add a new rule that is specific in nature. ([39b3e30](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/39b3e300149000fa2761d4d83e263404b2a9d95c))

## [12.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.1.0...v12.1.1) (2024-09-09)


### Bug Fixes

* use environment service principal to deploy Managed Endpoint instead of the meta service principal ([ca8e531](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ca8e5312c5916ab6ef2c166ff6f58e069af3279a))

# [12.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.0.3...v12.1.0) (2024-09-06)


### Features

* Managed Private Endpoint, Integration Runtime, and Linked Service for Connection with SAP CDC ([57757f3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/57757f31c46c0bb972a94b9add0c7527aabf3f07)), closes [#10395](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/10395)

## [12.0.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.0.2...v12.0.3) (2024-09-04)


### Bug Fixes

* Add Michael to Mall Main ([6f1b5ad](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6f1b5ad87e9e74f2c9dedc4757c448f1518d9b0f))

## [12.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.0.1...v12.0.2) (2024-09-02)


### Bug Fixes

* add Henri's CPA account to all envs ([acab52e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/acab52e589a8b08077a32ecaf2ae0049bafc29b8))

## [12.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v12.0.0...v12.0.1) (2024-09-02)


### Bug Fixes

* Flag to configure network rules and extra tag (PNS) ([ae29d3d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ae29d3de913f8b4d335e3bba045a33dbe7811458)), closes [#10223](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/10223)

# [12.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.3.1...v12.0.0) (2024-08-28)


### Bug Fixes

* Mock PR to create breaking change ([d4fb7b7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d4fb7b77a2bf39e85dcfb391238a1ea8478b1aa5))


### BREAKING CHANGES

* Version 11.3.0 for the operational layer should have been a breaking change, this mock PR fixes that

## [11.3.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.3.0...v11.3.1) (2024-08-28)


### Bug Fixes

* provide access to pns members ([a99cde9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a99cde9195d4a8289599ecda620489affda24bda))

# [11.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.2.0...v11.3.0) (2024-08-28)


### Features

* created Operational Layer, with the following modules: ([4a830b8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4a830b89153687f5ba0565663df2a28d3e002744))

# [11.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.1.0...v11.2.0) (2024-08-26)


### Features

* Created a single module, solving the multiple databricks issue. ([e878b15](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e878b1569e6a1b79fb1d6c0842d4e2987e44fd6b))

# [11.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.0.4...v11.1.0) (2024-08-22)


### Features

* Created a single module, solving the multiple databricks issue. ([1dfe065](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1dfe06521af1e05468697436fe3b5b01d9e3db06))

## [11.0.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.0.3...v11.0.4) (2024-08-22)


### Bug Fixes

* user_specific_cluster hotfix for outputs from correct module. ([5dc53c4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5dc53c4b4474d17efe39d022cb2530a9ff6d573a))

## [11.0.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.0.2...v11.0.3) (2024-08-22)


### Bug Fixes

* databricks sync Git module conditional deployment ([7d9ef8a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7d9ef8a333d87394d77ae961cb60acdcccf5d204))

## [11.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.0.1...v11.0.2) (2024-08-22)


### Bug Fixes

* remove dev-only moved blocks, add storage lifecycle policies ([64ef05c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/64ef05c4ab88f1a6a889f0f2940f0e6228e12b1f))

## [11.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v11.0.0...v11.0.1) (2024-08-21)


### Bug Fixes

* update execute SQL notebook path ([aa74f69](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/aa74f69f8abf1a7fc48eb726899c042cbf86bd49))

# [11.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v10.0.4...v11.0.0) (2024-08-21)


### Features

* Add the base and functional layers for the TF/TF migration. ([2ee880a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2ee880a939fbbed94484c771c28f2d30dccabbe1)), closes [#9067](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/9067) [#9931](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/9931)


### BREAKING CHANGES

* we move a large part of our infrastructure to a new layered setup using base and functional layers. This involves moving a lot of the infrastructure (and therefore statefiles) around, which is a breaking change.

## [10.0.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v10.0.3...v10.0.4) (2024-08-20)


### Bug Fixes

* Add patch end time to domain_configuration for individual reconfig ([bb486fe](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/bb486fef64cd35ab824bbb90017911717204ee99))

## [10.0.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v10.0.2...v10.0.3) (2024-08-15)


### Bug Fixes

* **adf_infra_components:** Add moved block to prevent redeployment of the renamed ADF component 'run_sql_query_pipeline' ([cb5a122](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cb5a12208b128ffde0f078b349c4f9fedcab8f10))

## [10.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v10.0.1...v10.0.2) (2024-08-14)


### Bug Fixes

* Change resource name of run_sql_query adf infra component ([c5700a5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c5700a530e5e00580b304a9dcc9f3bf07de69bf6))

## [10.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v10.0.0...v10.0.1) (2024-08-14)


### Bug Fixes

* Added IAMtest subscription variable files ([cc892cc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cc892cc3a4f028ff15df7af0c2812367f2a8ac78))

# [10.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v9.1.0...v10.0.0) (2024-08-07)


### Features

* merge infra key vault and secrets, move to new module. ([9541f25](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9541f252dc637b9400daa24a60719510cedef49b)), closes [#9055](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/9055)


### BREAKING CHANGES

* We move the infra key vault to the new TF setup here, which includes merging the tfstate files. This makes the change non-BC.

# [9.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v9.0.2...v9.1.0) (2024-08-06)


### Features

* **storage:** Add extra storage container domain product ([40ddc7d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/40ddc7daf0ccc0a8bde79b0597caf5016be0364a))

## [9.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v9.0.1...v9.0.2) (2024-08-06)


### Bug Fixes

* Pensions dev app name and id were used in acc. ([7b5ab67](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7b5ab67e6105db1c6affcfc411e3817b742c82e2))

## [9.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v9.0.0...v9.0.1) (2024-08-06)


### Bug Fixes

* Added Bala Sastry to Platform Engineers and Sarah Ferrari to CnW team ([ab5d566](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ab5d566e73767a393fb02f5e4270bbe28f435b87))

# [9.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v8.1.2...v9.0.0) (2024-07-30)


### Features

* From this point, no reference to the specific domains folders will exist more than the products variables files. ([c7184ed](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c7184edfb855186bfc572e1fd4974da4989860a1))


### BREAKING CHANGES

* In this PR, we removed the old code parts of our IaC.

## [8.1.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v8.1.1...v8.1.2) (2024-07-30)


### Bug Fixes

* **config:** Object_id for platform engineers AAD group missed an 'a' ([2be028f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2be028fbfddc9766cf350b40fed0b5b65e67e41c))

## [8.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v8.1.0...v8.1.1) (2024-07-29)


### Bug Fixes

* Added powershell for smooth CSA 2 CPA migration. Last time with CnW we had to manually add the roles the data engineers had on their CSA to their CPA account. This script automates this. ([ff44487](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ff444870d5fa4bfe59af42ecf4b6c7b618f6c1fb))

# [8.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v8.0.1...v8.1.0) (2024-07-26)


### Features

* Environment type (env_type) flag for infrastructure_configuration. Enables easy testing in reconfig. Also fixed some issues in the configuration files resulting from the previous major release. ([8710cbf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8710cbf895b604982d53a05d138e507a49e69f5c)), closes [#8575](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8575)

## [8.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v8.0.0...v8.0.1) (2024-07-25)


### Bug Fixes

* add missing role assignment module where ADF gets access to start and stop the VM ([65a5dab](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/65a5dab0ab2fbb391550d110939e1eadc62730ae)), closes [#8931](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8931)

# [8.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.26.0...v8.0.0) (2024-07-22)


### Code Refactoring

* Dummy update to readme to introduce major version ([574dca6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/574dca6d9e344ebfefb3b917d10811fcb4c3dba5))


### BREAKING CHANGES

* After this breaking change, we can use the new product configuration environment variable and all configuration is consolidated in terraform, subdir configuration

# [7.26.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.12...v7.26.0) (2024-07-22)


### Features

* Moved and re-ordened configuration YAMLs to increase usage and reduce duplication. ([0444f18](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0444f18f2574694f9ed8511fa7c8becc88ba7f82))

## [7.25.12](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.11...v7.25.12) (2024-07-22)


### Bug Fixes

* Scaling down the VM ([3e4c16c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3e4c16c64ba9ee5391ef6f3736848635e3b8fc6a)), closes [#8503](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8503)

## [7.25.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.10...v7.25.11) (2024-07-17)


### Bug Fixes

* Added Job as DevOps Eng and updated Michel CSA to CPA ([873f490](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/873f490936ae4d62e036a3da8d8a7457a812db1f))

## [7.25.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.9...v7.25.10) (2024-07-15)


### Bug Fixes

* added vm size in the new config files. ([6497aa9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6497aa97663a6328d2dca7046f090d5761c82e99))

## [7.25.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.8...v7.25.9) (2024-07-11)


### Bug Fixes

* **access:** Access for Nijs Stekelenburg (PNS) ([a90251f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a90251fdebc12e46d85609a0bfb7fe8875183f07)), closes [#8842](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8842)

## [7.25.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.7...v7.25.8) (2024-07-05)


### Bug Fixes

* Scale up to Standard_D16_v5 ([8864761](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8864761ea3142a37c66fb14852960b8b403224a5)), closes [#8479](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8479)

## [7.25.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.6...v7.25.7) (2024-07-04)


### Bug Fixes

* Domain variables key in mall_main config file ([5a0759a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5a0759a6a3d59539fec523a9a6d1651c1dfba496))

## [7.25.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.5...v7.25.6) (2024-07-04)


### Bug Fixes

* Add mall_main domain_configuration to tst, change product name mall_main to mall ([0535998](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0535998a4f1f73ff9b59476288f96054740f21d5))

## [7.25.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.4...v7.25.5) (2024-07-03)


### Bug Fixes

* IP ranges in domain configuration of Pensions ([69edd4e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/69edd4eb073f80f2a21f9e31180d3ccd9ab005ab))

## [7.25.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.3...v7.25.4) (2024-07-03)


### Bug Fixes

* Add extra condition to if statement of deploy_package_to_specific_cluster ([ffaa4e4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ffaa4e470b50da75083bfc45001481a3aec93649))

## [7.25.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.2...v7.25.3) (2024-07-03)


### Bug Fixes

* Add root to locals for deploy_package_to_specific_clusters module ([451cbc5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/451cbc5e8f1f3bb717170dc55b1da882157767ac))

## [7.25.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.1...v7.25.2) (2024-07-03)


### Bug Fixes

* Adjusted variables.yaml for cpa switch ([c3222d7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c3222d7f1f5badd87847a344234810ad419f1203)), closes [#8071](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8071) [#8080](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8080) [#8082](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8082) [#8088](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/8088)

## [7.25.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.25.0...v7.25.1) (2024-07-01)


### Bug Fixes

* **product:** Stop ADF components payloads from being skipped when not desired ([f11bf28](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f11bf28351f18f04b976620862013cf91449b5d5))

# [7.25.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.24.5...v7.25.0) (2024-07-01)


### Features

* Added databrick cluster policies to enable DLT clusters to use a secret scope ([34023f4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/34023f48f5a70c71146ef2aeceb913194bf3a6eb))

## [7.24.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.24.4...v7.24.5) (2024-07-01)


### Bug Fixes

* **product:** bug that synced the Databricks workspace in every domain in every environment to the Customer Workflow git repository ([0fb2f16](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0fb2f16589b24df7d79be47f0feb657434649cc2))

## [7.24.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.24.3...v7.24.4) (2024-06-27)


### Bug Fixes

* Dependency issues for user specific clusters ([81d853e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/81d853ecada9e14280651a34873944eeb44125bb))

## [7.24.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.24.2...v7.24.3) (2024-06-20)


### Bug Fixes

* Added Krystel and Joost to pensions DE ([802520f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/802520fce22e744b0456a619227b8de26c68f750))

## [7.24.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.24.1...v7.24.2) (2024-06-18)


### Bug Fixes

* user_specific_cluster module had a wrong check to see if it needs to be deployed. The databricks user specific cluster only need to be deploy in dev. New variable has been created to enabled/disable deployment of the user specific clusters. ([02f797f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/02f797f4cde0e090f689d34f0aacbfe909984665))

## [7.24.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.24.0...v7.24.1) (2024-06-11)


### Bug Fixes

* Updated doc ([8f292f9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8f292f96c0b2ab63ebdae2af3054328fa3d0cf06))

# [7.24.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.23.0...v7.24.0) (2024-06-11)


### Features

* Added Java JRE VM Application ([878af28](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/878af284a77e6a4df584a543b897b0a909a10086))

# [7.23.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.22.4...v7.23.0) (2024-06-11)


### Features

* created the new input files for the new Terraform refactoring, each domain contains a domain_configuration.yaml file and each env contains a env_configuration.yaml. New variables have been created for this propose only in the new terraform code, keeping the current code compatible. ([6e33023](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6e330237a5e6ea873af49309a033bca9b777a655))

## [7.22.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.22.3...v7.22.4) (2024-06-10)


### Bug Fixes

* Remove java installation from SHIR ([5b10d83](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5b10d832f05f3c0646a2356c5070c5ba02cf71f9)), closes [#6737](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6737)

## [7.22.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.22.2...v7.22.3) (2024-06-10)


### Bug Fixes

* Updated some terragrunt lock files. ([6bac1f8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6bac1f88c57d9622af5bad6ef1bbf377116f6c51))

## [7.22.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.22.1...v7.22.2) (2024-06-07)


### Bug Fixes

* Remove tight dependency on Kafka secret ([be4c8ca](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/be4c8cad202fcef7c555922a1982c2985275ddaa))

## [7.22.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.22.0...v7.22.1) (2024-06-07)


### Bug Fixes

* Map acceptance to IBM test environment, small naming conventions ([cce4a70](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cce4a7092120c570637b3e23b77a9fea65efb5e9))

# [7.22.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.21.0...v7.22.0) (2024-06-07)


### Features

* Handle Kafka Certificate in Databricks Workspaces ([b2414d3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b2414d3d0e5721305f82b7c06f90f0dc6cbe00a0)), closes [#6546](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6546)

# [7.21.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.20.0...v7.21.0) (2024-06-04)


### Features

* Added new central VM Applications Gallery to the LPDAP meta subscription code and added snow_findings app to SHiR virtual machines. The snow_findings app runs a powershell script which a reads a csv file with registrity settings which need to be applied the Windows VM's to close SNOW findings. ([00c51ba](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/00c51ba8310b6c15e7b2ba9ca5cfcf3d45a63d02))

# [7.20.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.19.2...v7.20.0) (2024-06-03)


### Features

* ADFaaS reformatted as a product. ([6285914](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6285914d3f3b234ba3daa7686ff10402ea49d80f))

## [7.19.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.19.1...v7.19.2) (2024-05-31)


### Bug Fixes

*  Change vm size back to Standard_D4_v4 (ind acc) ([ace62dc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ace62dc35a79165af842a912d53265802b5b40ee)), closes [#7319](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/7319)

## [7.19.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.19.0...v7.19.1) (2024-05-30)


### Bug Fixes

* resizing vmshirind01acc0 to "Standard_D16_v5", temporary for 24 hours ([b89e962](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b89e962b5c7e3efb146f1bfa6e8670d8973e6ad4)), closes [#7319](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/7319)

# [7.19.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.18.3...v7.19.0) (2024-05-23)


### Features

* Terragrunt Product for the Data Mall Platform ([5b01178](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5b01178e12e8bf6c0359f23e5c42cee623fc09c9)), closes [#5165](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/5165)

## [7.18.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.18.2...v7.18.3) (2024-05-22)


### Bug Fixes

* Missing folder in dev individual ([049b6ec](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/049b6ec580c2cc93c4251db899b328480d090c40))

## [7.18.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.18.1...v7.18.2) (2024-05-22)


### Bug Fixes

* Deleted access_policy folder from ~4/keyvault_adf_disc_encryption ([24432c3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/24432c3d25fdc5d24d47d5020d064c074d1a667d))

## [7.18.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.18.0...v7.18.1) (2024-05-16)


### Bug Fixes

* Another access_policies folder that should not be there anymore. ([56986c1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/56986c146a85400eda2aed487da49244f6720aae))

# [7.18.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.17.5...v7.18.0) (2024-05-16)


### Features

* Added layer 4-5-6-7 to the data domain product ([23e7942](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/23e79425283b7a9f0f0524219e80317645695696))

## [7.17.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.17.4...v7.17.5) (2024-05-16)


### Bug Fixes

* Added new schedule for patching solution ([03755bf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/03755bf485bd8dda0e471588ba685d53279ba49b))

## [7.17.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.17.3...v7.17.4) (2024-05-14)


### Bug Fixes

* added CPA accounts for data engineers and pentesters ([dbbc0d7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/dbbc0d7c859b29f15956abe35bb63727e5f574c8)), closes [#6686](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6686) [#6799](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6799) [#6800](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6800) [#6801](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6801)

## [7.17.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.17.2...v7.17.3) (2024-05-13)


### Bug Fixes

* Added disk encryption to DB clusters ([36f33fd](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/36f33fdd4f9b0e52b5bcd70da98c4aac86965b2d))

## [7.17.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.17.1...v7.17.2) (2024-05-08)


### Bug Fixes

* retyable errors added to rec + dev user_specific_clusters ([13e051a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/13e051a125e690eb37e4e64f8b63a8828d581456))

## [7.17.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.17.0...v7.17.1) (2024-05-07)


### Bug Fixes

* Remove access policy files from all envs ([17634dd](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/17634dd19d72de7b8567713e064a3942292d0380)), closes [#6160](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6160)

# [7.17.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.16.1...v7.17.0) (2024-05-07)


### Features

* Enable automatic patch and add to Maintenance Configuration ([187c389](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/187c38982bcb1b94fc2807d0b1a925c2e32ba039))

## [7.16.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.16.0...v7.16.1) (2024-05-06)


### Bug Fixes

* added retryable_errors to databricks ~5. ([c849222](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c849222efade3f3629b6eb5d600c67e259337016)), closes [#5745](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/5745)

# [7.16.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.15.0...v7.16.0) (2024-05-06)


### Features

* added a variable to yaml files of all envs/domains for the VMs size. ([96d210d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/96d210d541afe73fdc8b83ba0907e971237f8776))

# [7.15.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.11...v7.15.0) (2024-05-01)


### Features

* refactor done for layers 1-2-3, new folder structure create for products. ([5eda64a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5eda64ad6c0a05ef3c2fb1be069fa862dbdc9a06))

## [7.14.11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.10...v7.14.11) (2024-04-30)


### Bug Fixes

* Remove acc and prd permissions from Milan Hricko ([cca7d7d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cca7d7d66c44cd4e8ab5c9afe02f16b07459600c))

## [7.14.10](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.9...v7.14.10) (2024-04-29)


### Bug Fixes

* Add Databricks App to Sources Key Vault Role Assignments (Mall Main) ([167fcd3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/167fcd311def2f634846a44e19e670f532623345)), closes [#6365](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6365)

## [7.14.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.8...v7.14.9) (2024-04-29)


### Bug Fixes

* Add Milan Hricko to mall domain ([94282b1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/94282b195ba3c22d91407b329f92a9a3cac03cf7))

## [7.14.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.7...v7.14.8) (2024-04-29)


### Bug Fixes

* Correct role for Databricks Access Connector, should be Storage Blob Data Contributor. ([2bf2835](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2bf28354477deb05565a4c73fdfa7920f3f53e95))

## [7.14.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.6...v7.14.7) (2024-04-24)


### Bug Fixes

* Remove key-vault-infra folder, change reference path in key-vault-source tg file (all environments) ([fb4a324](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fb4a324b3f3b99b37cce38d7be1c3f7807338b22)), closes [#6254](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/6254)

## [7.14.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.5...v7.14.6) (2024-04-23)


### Bug Fixes

* Remove character ([730e778](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/730e7789a799100cb9ffde5b576150d0c39fddad))

## [7.14.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.4...v7.14.5) (2024-04-22)


### Bug Fixes

* Clean-up resource-group-based role assignments, add new team members to Individual ([a98e31b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a98e31bc090a3313511eb4c40a00988060c653bc)), closes [#5967](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/5967)

## [7.14.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.3...v7.14.4) (2024-04-19)


### Bug Fixes

* Fixed Pydantic 2.3.0 library issue with DBW 13.3 and 14.3 ([06ae2c5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/06ae2c51c70dccf45237037f5d0a5d1bb324bf37))

## [7.14.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.2...v7.14.3) (2024-04-19)


### Bug Fixes

* Removed Joost, Yuki and Vincent and added Shravya, Peter, Puja and Sandeep from/to Individual ([92ec0ca](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/92ec0ca1ab174dca5d786c289c3f4306951d7140))

## [7.14.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.1...v7.14.2) (2024-04-18)


### Bug Fixes

* Added Meny to and removed Jacob, Crystel, Joost and Yuki from Pensions data domain ([39127a5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/39127a5c0f675e1f9244c307b432c19dc5b5780c))

## [7.14.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.14.0...v7.14.1) (2024-04-16)


### Bug Fixes

* switching from access policies to RBAC, for the usage of both key vaults: ([0f6e91e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0f6e91e823a941b064bf1d4ab5e46bc588263cb6)), closes [#4621](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/4621)

# [7.14.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.6...v7.14.0) (2024-04-16)


### Features

* Update DBW Version PRD ([f0ea8ea](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f0ea8ea62cf20aab9c2d7707dfdf6a50e7966c2e))

## [7.13.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.5...v7.13.6) (2024-04-11)


### Bug Fixes

* Add Ellen in de Braekt to Pensions ([db9a600](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/db9a60071c2d7f68be7a290774902aa30d90b3c9))

## [7.13.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.4...v7.13.5) (2024-04-09)


### Bug Fixes

* Added the option for monitoring virtual machines to the shadow tree or however we call env ([03d630e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/03d630e18c2dfe3ea17879b56ca5c16fed0b626b)), closes [#4674](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/4674)

## [7.13.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.3...v7.13.4) (2024-04-08)


### Bug Fixes

* Fixed LAW DataCollectionRule, eventlogs of the vm's are now forwarded to the LAW. ([393ec51](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/393ec516a96b357ee52f3b514e31b925b42a93d7))

## [7.13.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.2...v7.13.3) (2024-04-05)


### Bug Fixes

* In order to have available PAT and HOST secrets, from databricks, the module databricks_asset_bundles_secrets has been added for mall team. This module has been added in all envs. Also the root .hcl file was updated with the details of the provider for meta. The secrets will be stored in the meta KV and later used by the DAB deployment. ([fe46702](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fe467025af5a592f6b78d19d85762d3cbf5312fb))

## [7.13.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.1...v7.13.2) (2024-04-05)


### Bug Fixes

* Typo in variables ([04372a8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/04372a88bc73619eedb2fbca7b56c42a7b11e6d4))

## [7.13.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.13.0...v7.13.1) (2024-04-04)


### Bug Fixes

* Typo in Yuki's name ([23d4a95](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/23d4a95f5e55878c3ef1e7fdeae38c5e1cb69d2f))

# [7.13.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.7...v7.13.0) (2024-04-04)


### Features

* Databricks version is now upgraded to version 12.2 LTS ([f922cb2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f922cb255009955ff3fdf64d0edf08892be05156))

## [7.12.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.6...v7.12.7) (2024-04-03)


### Bug Fixes

* Added Juki and removed Gijs ([f7df48c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f7df48c3a1d5d0433957551c10c60d7aaf8f53fe))

## [7.12.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.5...v7.12.6) (2024-04-02)


### Bug Fixes

* Removed bcg from folders and variables ([3b73601](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3b736016c1597511cae1e07089e84ede58b24101))

## [7.12.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.4...v7.12.5) (2024-03-26)


### Bug Fixes

* Added Set-UserPath.ps1 to /utils (powershell script to extend the PATH Environment variable) ([18f00b8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/18f00b8d97829e5fb742d7201fe42256e4de8571))

## [7.12.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.3...v7.12.4) (2024-03-25)


### Bug Fixes

* Added steffen ([590c4c2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/590c4c21f005e3aa8a9334cd5316b25328107ea4))

## [7.12.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.2...v7.12.3) (2024-03-19)


### Bug Fixes

* Add Délano to DevOps engineers in all environments ([335ec3d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/335ec3d3d383d4f512f409bb33a8fad8c19f7720))

## [7.12.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.1...v7.12.2) (2024-03-19)


### Bug Fixes

* Wilma access CnW ([524fd9c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/524fd9c28ce05e95a8c109d44aeec3d03caa00aa))

## [7.12.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.12.0...v7.12.1) (2024-03-13)


### Bug Fixes

* **permissions:** Add Jaap Wagemans to pensions ([0394ee2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0394ee26360c34a32f05b4f7dc8866c4b6ed23fa))

# [7.12.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.11.4...v7.12.0) (2024-03-07)


### Features

* Add git sync option to ADF module and add uniform naming for the SHIR in ADFaaS platforms ([cdd4bd5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cdd4bd5b637a994a428f0952c6f7d2ba409a41ad))

## [7.11.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.11.3...v7.11.4) (2024-03-07)


### Bug Fixes

* **permissions:** add Florian to individual ([c0ef74b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c0ef74b113c119a82bce858fb9f16be0adeaf496))

## [7.11.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.11.2...v7.11.3) (2024-03-04)


### Bug Fixes

* Fix runbook content bug ([43f14c5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/43f14c595653c01792d450e9394e0a5faef0b4c9))

## [7.11.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.11.1...v7.11.2) (2024-03-04)


### Bug Fixes

* Fixed databricks service principal access ([d642e11](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d642e11cd2d6c2eb4b8d3d851f97c542efad6793))

## [7.11.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.11.0...v7.11.1) (2024-03-04)


### Bug Fixes

* Access for Rob, bug fix for SAP Access issue ([e3cf5cf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e3cf5cf11307a51ce88db247f4ca3982e1de997f))

# [7.11.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.10.4...v7.11.0) (2024-03-04)


### Features

* Allow Databricks to access Data Factory for temporary monitoring ([4ac7e00](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4ac7e0080698100b6ac4826f859831fd42213cd9))

## [7.10.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.10.3...v7.10.4) (2024-02-28)


### Bug Fixes

* Added Rajesh Kumar to Individual ([0ff9363](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0ff93638c3174ba293bc9eab264fa9b55ec3f961))

## [7.10.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.10.2...v7.10.3) (2024-02-27)


### Bug Fixes

* added Richard to the DE pensions ([6b309a0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6b309a0dc5b788ceb14f0525a6e05baabd7fe675)), closes [#4757](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/4757)

## [7.10.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.10.1...v7.10.2) (2024-02-27)


### Bug Fixes

* Databricks Access To Sources Key Vault ([743ac06](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/743ac06a85200418426160272558df5ac51ef2df))

# [7.10.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.9.3...v7.10.0) (2024-02-23)


### Features

* Added Databricks Access Connector for Unity Catalog to the terraform code. ([6200fc0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6200fc0d10d17a6c22c22a45c5371d5bbb95b6cf))

## [7.9.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.9.2...v7.9.3) (2024-02-21)


### Bug Fixes

* Added Joost to Data Mall ([d283410](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d28341087ac26e924ef9b67559f8b6446e5d4869))

## [7.9.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.9.1...v7.9.2) (2024-02-19)


### Bug Fixes

* blob lease tool ([2047a9e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2047a9e823497853db04d353e598cbc9dd07360d))

## [7.9.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.9.0...v7.9.1) (2024-02-13)


### Bug Fixes

* new lease blob tool ([6738f0c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6738f0cc11040ebfdbf3a4be86d21855551cebca))

# [7.9.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.8.2...v7.9.0) (2024-02-13)


### Features

* added SAP HANA Service principals to the databricks environments. ([dace860](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/dace86038cb74f00f993134173fc3bdb812a581e))

## [7.8.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.8.1...v7.8.2) (2024-02-09)


### Bug Fixes

* network resource group bug ([c957afd](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c957afd934c465211b3240cb1713326d191644f1))

## [7.8.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.8.0...v7.8.1) (2024-02-05)


### Bug Fixes

* added condition for json and none comprresion level ([0b603ee](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/0b603ee9cb61ecfe9fbbf0156589741d6053033b))

# [7.8.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.7.0...v7.8.0) (2024-02-01)


### Features

* Add ADF-as-a-Service implementation for the Finance Life Individual team ([c5d5ed5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c5d5ed515f3a1c6c67d3079c68c7f4060c24bdf3))

# [7.7.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.9...v7.7.0) (2024-02-01)


### Features

* Implement bcg_poc domain in the acc environment ([3968755](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/3968755150a1907e4ede1dd1d68bff334559b584))

## [7.6.9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.8...v7.6.9) (2024-01-29)


### Bug Fixes

* add kv-sources for mall team ([7776a8e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7776a8e8fe0be18cccd97d1d6747992ac9ed8453)), closes [#3778](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/3778)

## [7.6.8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.7...v7.6.8) (2024-01-24)


### Bug Fixes

* added maven variables and installation ([f634ea3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f634ea32282616f32a1ab9f280ee8eb1d7913840)), closes [#3934](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/3934)

## [7.6.7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.6...v7.6.7) (2024-01-16)


### Bug Fixes

* inconsistent conditional result types error in Azure Data Factory storage account linked service ([e1dd7cc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e1dd7cc98fbcef05c0a96cd6d5d0aca23cbea5bc))

## [7.6.6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.5...v7.6.6) (2024-01-12)


### Bug Fixes

* Implement of idempotent in needed modules ([9bba632](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9bba6329ee8ba62630acd07bbc167e58ffd95aad)), closes [#3916](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/3916)

## [7.6.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.4...v7.6.5) (2024-01-12)


### Bug Fixes

* user provisioning Gijs and Meint (data mall) ([ab05f3d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ab05f3ddcd3951077badf98471dba2d81b0bb083))

## [7.6.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.3...v7.6.4) (2023-12-19)


### Bug Fixes

* mall team access ([d547a71](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d547a717caba1d1ae23b5662d06460daee7755d7))

## [7.6.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.2...v7.6.3) (2023-12-19)


### Bug Fixes

* Revert "Data Mall team access" ([e7c2541](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e7c25412c58fb1bd81194e3fab2ba8286ce641d8))

## [7.6.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.1...v7.6.2) (2023-12-15)


### Bug Fixes

* Use dev payloads when deploying adf components to reconfig ([095c7df](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/095c7df52b1774d931743f369bf69d88017f7821))

## [7.6.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.6.0...v7.6.1) (2023-12-13)


### Bug Fixes

* added silver container ([752ddcc](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/752ddcc05984813e88925b2a4ea27cdec0aec36b))

# [7.6.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.5.4...v7.6.0) (2023-12-13)


### Features

* Store the Databricks host and PAT in the meta key vault for each domain for Databricks Asset Bundles support ([691ffdf](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/691ffdfafe033289e34ced6f069d915b688389cd))

## [7.5.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.5.3...v7.5.4) (2023-12-13)


### Bug Fixes

* added git sync to dev mall main ([5137299](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5137299a4d83983b623e4cc562f9e9a71cf3af63)), closes [#4071](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/4071)

## [7.5.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.5.2...v7.5.3) (2023-12-12)


### Bug Fixes

* Prevent run_sql_query_pipeline module from deploying before databricks_linked_service is deployed ([78425d5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/78425d5930b0ecec975f600dd454a5b15a432bbf))

## [7.5.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.5.1...v7.5.2) (2023-12-11)


### Bug Fixes

* Prevent az authorization error when deploying VM extensions by setting subscription in null-resource ([cc14de0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/cc14de066faf317a76078fe809c41530b502d146))

## [7.5.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.5.0...v7.5.1) (2023-12-08)


### Bug Fixes

* assignment roles file missing in individuals. ([fbce662](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fbce6629c7df5b1af393fea1cb6881f6fd88581e))

# [7.5.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.4.4...v7.5.0) (2023-12-07)


### Features

* Enabled logging to Log Analytics for storage accounts. Also fix several warning related to log analytics for the other azure resources. ([5ae1c31](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5ae1c31c8ecf5012869192977b29cf5a5b95c2db))

## [7.4.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.4.3...v7.4.4) (2023-12-06)


### Bug Fixes

* Added pinned to the clusters ([5ad77c6](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5ad77c63091f434819eda819fe6813efd0ab27f2)), closes [#3748](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/3748)

## [7.4.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.4.2...v7.4.3) (2023-12-05)


### Bug Fixes

* role assignments storage ([54582e5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/54582e5c5d342c82c182fe126e273542fe9d5f1d))

## [7.4.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.4.1...v7.4.2) (2023-12-04)


### Bug Fixes

* variables file and path issues. ([c21c89c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c21c89cee8900afa419127b88437a1d6400a3de9))

## [7.4.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.4.0...v7.4.1) (2023-12-04)


### Bug Fixes

* The public access to the log analytics workspace was disabled, which caused the VM's not being able to connect to log analytics. Also 2 extensions were missing from the vm's. ([96dfd8c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/96dfd8c6aa51e6177fe794e14111b83deb2c466b))

# [7.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.3.0...v7.4.0) (2023-11-30)


### Features

*  new mall data domain. ([5cc4691](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5cc4691cda3495cc252844433a4273eb64d2844f))

# [7.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.2.5...v7.3.0) (2023-11-28)


### Features

* Sync Azure DevOps project the Databricks workspace for the dev environment ([944b220](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/944b220fa641ba8de261c604f15dd5f4236984c1))

## [7.2.5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.2.4...v7.2.5) (2023-11-27)


### Bug Fixes

* Fixed DataBricks Public Network, it did not have the Private Endpoint Network Policy set ([61d3be5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/61d3be5cc9ba4013123ab14790443cc15696f80d))

## [7.2.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.2.3...v7.2.4) (2023-11-22)


### Bug Fixes

* login for AZ local exec ([2b24e6d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2b24e6d5ebd746530ce32638b2df0d759e49e6b0))

## [7.2.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.2.2...v7.2.3) (2023-11-22)


### Bug Fixes

* Add security rule blocking SHIR access from ADF ([697662b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/697662b58a182b0a52af731c465e280213614bec))

## [7.2.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.2.1...v7.2.2) (2023-11-20)


### Bug Fixes

* az connection to subscription ([7741365](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/774136594d9a77f10f6745555ea75d8997ef110d))

## [7.2.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.2.0...v7.2.1) (2023-11-16)


### Bug Fixes

* key reference fix ([d136c92](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d136c92458a785564d577a850f9c639881bacea0))

# [7.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.1.0...v7.2.0) (2023-11-16)


### Features

* Enabled Routing table for Private Endpoints ([8c25eb1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8c25eb1ac5cd6823214f90a07cacefe7c8e93040))

# [7.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.0.2...v7.1.0) (2023-11-16)


### Features

* Added Automation Account and Windows Update solution to log analytics to be able to schedule Windows Updates Installation on the virtual machines ([d81d904](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d81d904204e4e40fe7e4b027bd036392555dac21))

## [7.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.0.1...v7.0.2) (2023-11-15)


### Bug Fixes

* created new map with logins for the secrets module ([794b498](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/794b4989fbeebb2c1262e821678a6eb6cf2535f4))

## [7.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v7.0.0...v7.0.1) (2023-11-13)


### Bug Fixes

* Remove Steffen Dennis and Milan roles from pensions dev ([608c13c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/608c13c9c89da28e88d8a5e98a08171316622dff))

# [7.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v6.1.0...v7.0.0) (2023-11-13)


### Code Refactoring

* Created new module to run scripts ([d2cf71f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d2cf71ff8635de4ee44924c693038cca7017f23e)), closes [#3533](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/issues/3533)


### BREAKING CHANGES

* Install VM extensions in a separate Terragrunt module

# [6.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v6.0.0...v6.1.0) (2023-11-06)


### Features

* Script to add roles to subscriptions ([8db2ffe](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8db2ffe2a48db7f07b1d0d33df2b8970cabcd739))

# [6.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.3.2...v6.0.0) (2023-09-21)


### Features

* add run_sql_query_pipeline to adf ([29b0064](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/29b00645607f8e71ae23e5b4e52bc6f87a82d6e4))


### BREAKING CHANGES

* move Terraform modules in data-pipeline-core and data-logic-core

## [5.3.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.3.1...v5.3.2) (2023-09-14)


### Bug Fixes

* add access to Vincent (CSACM36OL) and Michel (CSASK43OH) and remove Roel (CSATV24TA) ([9140fa1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9140fa1751462d7032281e80fecd4aafb71cbb2c))

## [5.3.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.3.0...v5.3.1) (2023-09-06)


### Bug Fixes

* reference to object ids ([96eb1b7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/96eb1b7af712fba9c6b76c77767833dc5ce9e439))

# [5.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.2.0...v5.3.0) (2023-09-06)


### Features

* install pydantic on all Databricks cluster ([4830aed](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4830aedaceb4d8620f2b0258db2aa1a020dd60a5))

# [5.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.1.2...v5.2.0) (2023-09-05)


### Features

* Deny Bastion Policy Added ([8964a7a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8964a7a05763ab94b2da20810281bc7d054674c6))

## [5.1.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.1.1...v5.1.2) (2023-09-04)


### Bug Fixes

* small hotfixes to enable deploy-to-dev pipelines ([1cdf28f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1cdf28fe67ca8bcfb6b2fd1c1177a86e3edade2e))

## [5.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.1.0...v5.1.1) (2023-08-31)


### Bug Fixes

* remove dev components from tst ([9e55d36](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9e55d36d6f9082b69a9d2f962021dc14c64f7237))

# [5.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v5.0.0...v5.1.0) (2023-08-30)


### Features

* Added Azure tags to the modules ([e362383](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e362383db246881267fa0ba9a46ebe9d50294184))

# [5.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.4.2...v5.0.0) (2023-08-29)


### Bug Fixes

* Added VDI (Citrix) network range ([7085251](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/7085251a748ec4fc2943b38fa02ef39f579a257a))


### Features

* scale up platform to support multiple data domains ([4989deb](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/4989deb70efcfc9372922303034e6d95b5b47eed))


### BREAKING CHANGES

* add customer_workflow, individual and pensions data platforms

## [4.4.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.4.1...v4.4.2) (2023-08-01)


### Bug Fixes

* **databricks:** in acc and prd, set node type to DS3, set min workers to 1 and max workers to 16 ([e0025f0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e0025f0962ada8a492a88e8a7b4389010d69645a))

## [4.4.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.4.0...v4.4.1) (2023-07-19)


### Bug Fixes

* add dev aad group members to reconfig ([e3fae18](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e3fae183c32e14a6c4bbd0a03aed7a35d43054b7))

# [4.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.3.2...v4.4.0) (2023-07-12)


### Features

* Split up PSDL environment into 4 environments, added notebook_mounting_secrets, removed databricks_workspace_configuration, change subnets in environment variables, change tfstate file locations to subfolders per environment. ([a445536](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a445536e0378436193ac22da3060ac6f6003970d))

## [4.3.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.3.1...v4.3.2) (2023-07-11)


### Bug Fixes

* remove empty access policies to prevent context timeout during deployment ([1368eb9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/1368eb9990b3a0120568e1b877f2c4807673edc2))

## [4.3.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.3.0...v4.3.1) (2023-07-11)


### Bug Fixes

* **Access Policies:** fox typo in secret and key permissions which prevented them from being deployed ([207caad](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/207caad7c03c14640101af88cdc826fc447eb27d))

# [4.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.2.0...v4.3.0) (2023-07-10)


### Features

* **IAM:** give the GSBxAB Azure AD groups access to the resources on the platform ([c84e0c4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c84e0c4c8fa3e51238e2bfe59fb8afe985dc54b4))

# [4.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.1.1...v4.2.0) (2023-07-04)


### Features

* support payloads containing blob event triggers ([9f8aafa](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9f8aafad2ad988e5dcbc494f83b778989964b6d6))

## [4.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.1.0...v4.1.1) (2023-07-04)


### Bug Fixes

* IP ranges added to infra key vaults ([c564914](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c564914b37a17668e8475f0127c28e528fa3c849))

# [4.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v4.0.0...v4.1.0) (2023-07-04)


### Features

* Added ip ranges to keyvaults for access ([72fcbf4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/72fcbf4495efbdc1a80060baa59c3d2695221e49))

# [4.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.5.0...v4.0.0) (2023-06-22)


### Features

* enable multiple notebooks to be uploaded to Databricks ([5c5b13f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/5c5b13f4520e91d7d0316b3e467564e37a55c9cb))


### BREAKING CHANGES

* change the environment variable RUN_NOTEBOOK_PATH to NOTEBOOKS_DIR_PATH

# [3.5.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.4.0...v3.5.0) (2023-06-20)


### Features

* pdsl databricks worspace ([8a9dd4c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/8a9dd4c50e67b0f03b2be68f577b88ba22bdd740))

# [3.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.3.1...v3.4.0) (2023-06-15)


### Features

* add spark config for date issues ([a7fd800](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a7fd800e4765d828fc26e4ed854ab03792f51835))

## [3.3.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.3.0...v3.3.1) (2023-06-08)


### Bug Fixes

* fix typo on data_factory_components ([eb503b1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/eb503b170ab95f8514fcc2b52d9a3aa326ad256e))

# [3.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.2.0...v3.3.0) (2023-06-08)


### Features

* Allow for more configuration in the ADF trigger component ([50dded0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/50dded0bd4f74ed8b6cc39d97480f642987c1b2d))

# [3.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.1.4...v3.2.0) (2023-06-07)


### Features

* add landing container + fix linked service adf-storage ([a6ddc40](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/a6ddc40a4e4901b20896243694e60fb590724a09))

## [3.1.4](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.1.3...v3.1.4) (2023-05-30)


### Bug Fixes

* set node_type_id for user specific clusters in dev ([f2fedd9](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f2fedd9f0c1d46aea49d9546155b3033686977ba))

## [3.1.3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.1.2...v3.1.3) (2023-05-25)


### Bug Fixes

* add new tags to the virtual machines ([f261c8c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/f261c8c26a65db494b0277868769e35778dcdc4e))

## [3.1.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.1.1...v3.1.2) (2023-05-25)


### Bug Fixes

* change node type of Databricks cluster from Standard_DS3_v2 to Standard_DS4_v2 for the acc and prd environments ([ced3f1f](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/ced3f1f3cad03c87c0e4b738d3ef66541ed1ba47))

## [3.1.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.1.0...v3.1.1) (2023-05-10)


### Bug Fixes

* **ci:** fix release pipeline such that the artifacts have the proper directory structure ([89549d5](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/89549d56c36cf1f96d698f51031a5ca7eadac8fa))

# [3.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.0.2...v3.1.0) (2023-05-09)


### Features

* add configuration for the prd environment ([c2fe464](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c2fe464b7a2d03fbe2e122da0a770042f8843bfb))

## [3.0.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.0.1...v3.0.2) (2023-05-01)


### Bug Fixes

* redundant commit to test release ([99977f7](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/99977f7db7e65cb4086556ef1006b445a78f6830))
* redundant commit to test release ([2cd0752](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/2cd0752b04c20209b28b6b42ff4273ee4c8420ed))
* redundant commit to test release ([da52ae3](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/da52ae3be6c5b1c80c1013bcc2dccd322c1c0b42))

## [3.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v3.0.0...v3.0.1) (2023-04-26)


### Bug Fixes

* redundant change to test generic release ([70f8944](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/70f8944a1c4e9c0f93573064f4954af6b7b15e4c))
* redundant change to test release ([83bd1ea](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/83bd1ea1a9d9cd4ce3abc0a19def5d4c417ef153))

# [3.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v2.0.1...v3.0.0) (2023-04-11)


### Features

* remove meta component in ADF data pipeline deployments ([276ba1a](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/276ba1afda21225e88110a78382fa9ca01b0b20d))


### BREAKING CHANGES

* remove meta component in ADF data pipeline deployments

## [2.0.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v2.0.0...v2.0.1) (2023-04-04)


### Bug Fixes

* use Jeroen's PAT to Artifactory temporarily ([c16a203](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c16a203f68817f263d0dfba373a4fae6ccb79312))

# [2.0.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.6.0...v2.0.0) (2023-04-03)


### Features

* create layered infrastructure ([fc834d1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/fc834d126c8cc37b0bd4734c0dec61f63ae2db00))


### BREAKING CHANGES

* Refactor infrastructure into layers layered

# [1.6.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.5.0...v1.6.0) (2023-03-28)


### Features

* add meta component ([278d6d0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/278d6d0c34d27fb8bbce1a69482696c2f161897f))

# [1.5.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.4.2...v1.5.0) (2023-03-14)


### Features

* downscale user specific db cluster ([75f7c1e](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/75f7c1ec6f121a9c9a4633e025d8778733a92787))

## [1.4.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.4.1...v1.4.2) (2023-03-13)


### Bug Fixes

* add tag to shir ([e5e1ba0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/e5e1ba08793c155d10d59680415345dd8ee02ed1))

## [1.4.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.4.0...v1.4.1) (2023-03-09)


### Bug Fixes

* **role assignments:** fix bug that prevented Data Factory to start and stop the VM ([9b66e3b](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/9b66e3b90cd9083400151c195c039b85103730ca))

# [1.4.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.3.0...v1.4.0) (2023-03-08)


### Features

* **dev:** Create separate clusters for each developer ([02b941c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/02b941c43363caa2c06ca723847518ffad2417dc))

# [1.3.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.2.2...v1.3.0) (2023-02-27)


### Features

* **role assignments:** ensure Data Factory is allowed to start and stop the VM ([b0742fa](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/b0742fa92b74e27c64ef4d9d9d5d1aa462d7a520))

## [1.2.2](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.2.1...v1.2.2) (2023-02-27)


### Bug Fixes

* **semantic-release:** demo semantic release ([d06e596](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/d06e596303ba7d3c99044403f0eef0e49d57b2d4))

## [1.2.1](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.2.0...v1.2.1) (2023-02-23)


### Bug Fixes

* **databricks:** make sure init scripts are installed before the databricks cluster is created ([c40a0f8](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/c40a0f89815964436634998e288ab14ef405a028))

# [1.2.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.1.0...v1.2.0) (2023-02-16)


### Features

* set diagnostic settings to resource specific ([1450451](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/14504511c411ee04df09f8f3e816f72700adc7b7))

# [1.1.0](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/compare/v1.0.0...v1.1.0) (2023-02-16)


### Features

* **semantic-release:** redundant change to show Semantic Release ([923091c](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/923091c8fe909f60348ee934a927b5f40d3ed973))

# 1.0.0 (2023-02-15)


### Bug Fixes

* typo in utils/terraform_format.sh ([6658f1d](https://dev.azure.com/NN-Life-Pensions/LPDAP_Azure/_git/infra-modules/commit/6658f1d3cf45b04f65ed6df8da5d040d18b03b34))


### BREAKING CHANGES

* start with Semantic Release
