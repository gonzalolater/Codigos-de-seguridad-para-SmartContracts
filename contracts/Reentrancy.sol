// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Reentrancy {
    mapping(address => uint256) private balances;

    function retirarFondos() public {
        uint256 monto = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool resultado, ) = msg.sender.call{value: monto}("");
        require(resultado);
    }
}

contract Ataque {
    address direccionContratoVulnerable;

    receive() external payable {
        direccionContratoVulnerable.call(abi.encodePacked("retirarFondos()"));
    }
}
