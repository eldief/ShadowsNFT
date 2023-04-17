// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {IComponent} from "./IComponent.sol";
import {ExpansionsRegistry} from "../../ExpansionsRegistry.sol";

abstract contract Component is IComponent {
    ExpansionsRegistry public immutable expansionsRegistry;

    constructor(address registry) {
        expansionsRegistry = ExpansionsRegistry(registry);
    }
}
