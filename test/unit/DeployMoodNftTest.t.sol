// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Constants} from "../../src/Constants.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string memory expectedUri = string.concat(
            "data:image/svg+xml;base64,",
            "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0icmVkIj5oaSEgeW91IGRlY29kZWQgdGhpczwvdGV4dD48L3N2Zz4="
        );
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="red">hi! you decoded this</text></svg>';

        string memory generatedUri = deployer.svgToImageUri(svg);

        console.log(generatedUri);

        assert(keccak256(bytes(expectedUri)) == keccak256(bytes(generatedUri)));
    }
}
