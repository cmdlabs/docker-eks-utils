# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.4.0] - 2021-09-16
### Added
- wget
- yq
- tree

### Updated
- helm updated to 3.7.0
- helm secrets updated to 3.8.3
- helmfile updated to v0.140.1
- sops updated to v3.7.1
- aws cli updated to 1.20.23

## [2.3.0] - 2021-03-23
### Updated
- Updated kubectl to 1.19
- Updated all other tools to latest versions
- Switch to new stable/incubator repositories

## [2.2.1] - 2020-07-27
### Updated
- helmfile version 0.125.0
- helm-diff version to 3.1.2

## [2.2.0] - 2020-06-24
### Added
- groff for aws help

### Updated
- manage sops version and bump to 3.5.0

## [2.1.0] - 2020-06-17
### Added
- helmfile
- helm git
- helm s3
- helm secrets

## [2.0.0] - 2020-04-27
### Breaking
- Entrypoint has been changed from bash to kubectl
- Removed bash

### Updated
- alpine to 3.11
- kubectl to 1.15.10
- helm to 3.2.0
- helmdiff to 3.1.1
- aws to 1.18.46

### Changed
- Switched from dockerhub autobuilds to gitlabci

## [1.0.0] - 2019-12-17
### Changed
- helm v3
### Removed
- velero
- kubectx
- helm tiller

## [0.10.0] - 2019-11-26
### Updated
 - alpine to 3.10
 - kubectl to 1.14.6
 - helm to 2.16.1
 - helm tiller to 0.9.3
 - helm diff to 2.11.0+5
 - kubectx to 0.7.1
 - velero to 1.2.0
### Removed
 - Removed aws-iam-authenticator

## [0.9.0] - 2019-09-19
### Removed
- Removed all shell scripts
### Added
- Add README.md

## [0.8.0] - 2019-07-02
### Updated
- helm to 2.14.1
- awscli to 1.16.191
- kubectl to 1.13.7

## [0.7.0] - 2019-05-23
### Updated
- helm to 2.14.0

## [0.6.1] - 2019-04-15
### Changed
- Extract tiller to path to prevent it being downloaded every time.

## [0.6.0] - 2019-04-09
### Updated
- aws to 1.16.140
- helm to 2.13.1

## [0.5.0] - 2019-03-29
### Removed
- Removed support for EKS 1.10

### Added
- Added support for EKS 1.12

### Updated
- kubectl to 1.12.7

## [0.4.0] - 2019-03-29

### Updated
- kubectl to 1.11.9

## [0.3.0] - 2019-03-08

### Added

- Velero CLI tool

## [0.2.0] - 2019-03-07

### Added

- Added envsubst [#4](https://github.com/cmdlabs/docker-eks-utils/issues/4)

## [0.1.0] - 2019-02-24

### Added

- Everything
