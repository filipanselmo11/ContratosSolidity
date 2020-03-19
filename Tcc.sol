pragma solidity >=0.4.0 <0.7.0;

contract Tcc {
    //address id;
    //string exame;
    struct Paciente {
      address id; //Endereco que identifica o paciente de forma única
      bytes32 exame;// Hash do pdf de exame do usuário, que será armazenado no ipfs

    }
    mapping(address => Paciente) public pacientes;
    /*
    function setHashPaciente(address _id) public {
        id = _id;
    }

    function obterHashPaciente(address id) public view returns(address) {
        return id;
    }*/
    function() public returns(){

    }

    function() {
        
    }
}