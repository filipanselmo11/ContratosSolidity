pragma solidity ^0.4.3;
/**
 * @title Ownable
 * @dev Um contrato Ownable tem um endereço de dono, e fornece funções básicas de autorização,
 * que simplificam a implementação de "permissões de usuário".
 */
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev O construtor Ownable define o `owner` (dono) original do contrato como o sender
   * da conta
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Lança um erro se chamado por outra conta que não seja o dono.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Permite que o atual dono transfira o controle do contrato para um novo dono.
   * @param newOwner O endereço de transferência para o novo dono.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}