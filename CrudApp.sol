pragma solidity >=0.4.21 <0.7.0;


contract CrudApp {
    
    struct pais {
        string nome;
        string lider;
        uint256 populacao;
        
    }
    
    pais[] paises;
    
    uint256  totalPais;
    
    constructor() public {
        totalPais = 0;
    }
    
    event EventPais(string nomePais, string lider, uint256 populacao);
    event AtualizarLider(string nomePais, string lider);
    event DeletaPais(string nomePais);
    
    function insere(string memory _nomePais, string memory _lider, uint256 memory _populacao) public returns (uint256 memory _'totalPais) {
        pais memory novoPais = pais(nomePais, lider, populacao);
        paises.push(novoPais);
        totalPais++;
        //emitindo o evento
        emit EventPais(nomePais, lider, populacao);
        return totalPais;
        
    }
    
    function atualizarLider(string memory _nomePais, string memory _novoLider) public returns(bool memory sucesso) {
        for(uint256 i=0; i < totalPais; i++) {
            if(compareStrings(paises[i].nome, nomePais)) {
                paises[i].lider = novoLider;
                emit AtualizarLider(nomePais, novoLider);
            }
        }
        return false;
    }
    
    function deletaPais(string memory _nomePais) public returns(bool sucesso) {
        require(totalPais > 0);
        for(uint256 i=0; i < totalPais; i++) {
            if(compareStrings(paises[i].nome, nomePais)) {
                paises[i] = paises[totalPais-1]; //empurrando por último no índice de matriz atual que vamos excluir
                delete paises[totalPais-1];
                totalPais--;
                paises.length--;
                //emitindo o evento
                emit DeletaPais(nomePais);
                return true;
            }
        }
        return false;
    }
    
    function getPais(string memory _nomePais) public view returns(string memory nome, string memory lider, uint256 memory populacao) {
        for(uint256 i=0; i < totalPais; i++){
            if(compareStrings(paises[i].nome, nomePais)) {
                return(paises[i].nome, paises[i].lider, paises[i].populacao);
            }
        }
        revert('pais nao encontrado');
    }
    
    function compareStrings(string memory a, string memory b) internal pure returns(bool memory) {
        return keccak256(a) == keccak256(b);
    }
    
    function getTotalPaises() public view returns(uint256 length) {
        return paises.length;
    }
}