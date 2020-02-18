pragma solidity >=0.4.21 <0.7.0;


import "./Leilao.sol";

contract LeilaoBox is Leilao {
    
    Leilao[] public leiloes;
    
    function createLeilao(
        string memory _titulo, 
        uint _precoInicial,
        string memory _descricao
        ) public {
            Leilao novoLeilao = new Leilao(msg.sender, _titulo, _precoInicial, _descricao);
            leiloes.push(novoLeilao);
        }
        
        function getTodosLeiloes() public view returns(Leilao[] memory) {
            return leiloes;
        }
}


