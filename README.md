# CircleCI multirepo orb

[![CircleCI][cibadge]](https://circleci.com/gh/dnephin/workflows/multirepo-orb)
[![orb registry][orbbadge]](https://circleci.com/orbs/registry/orb/dnephin/multirepo)

[cibadge]: https://circleci.com/gh/dnephin/multirepo-orb/tree/master.svg?style=shield
[orbbadge]: https://img.shields.io/endpoint.svg?url=https://badges.circleci.io/orb/dnephin/multirepo

Support for skipping jobs in multi-purpose repos and monorepos.

This orb uses a CD workflow.
1. Changes are pushed to the `integration` branch.
2. The `integration` branch CI job publishes a `dev:testing` orb and git pushes
   to the `testing` branch.
3. The `testing` branch CI job runs tests. When the tests pass a new patch
   version of the orb is published, and the change is pushed to `master`.
