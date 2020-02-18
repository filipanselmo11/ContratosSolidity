pragma solidity >=0.4.21 <0.7.0;


import "./SafeMath.sol";

contract Leilao {
    
    using SafeMath for uint256;
    
    address payable private dono;
    string titulo;
    uint precoInicial;
    string descricao;
    
    enum Estado{Padrao, Correndo, Finalizado}
    Estado public estadoLeilao;
    
    uint public precoAlto;
    address payable public maiorApostador;
    mapping(address => uint) public apostas;
    /** @dev método construtor pra criar o leilao
     * @param _dono, responsavel por chamar a funcao createLeilao no contrato Leilaobox
     * @param _titulo, o titulo do leilao
     * @param _precoInicial, o preco inicial do leilao
     * @param _descricao, descricao do leilao
     */
     
     constructor(
         address payable _dono,
         string memory _titulo,
         uint _precoInicial,
         string memory _descricao
     ) public {
         dono = _dono;
         titulo = _titulo;
         precoInicial = _precoInicial;
         descricao = _descricao;
         estadoLeilao = Estado.Correndo;
     }
     
     modifier notDono() {
         require(msg.sender != dono);
         _;
     }
     
     /** @dev Função para fazer um lance
      * @return true
      */
      
      function fazerLance() public payable notDono returns(bool) {
          require(estadoLeilao == Estado.Correndo);
          require(msg.value > 0);
          uint lanceCorrente = lances[msg.sender].add(msg.value);
          require(lanceCorrente > precoAlto);
          lances[msg.sender] = lanceCorrente;
          precoAlto = lanceCorrente;
          maiorApostador = msg.sender;
          
          return true;
      }
      
      function finalizarLeilao() public {
          require(msg.sender == _dono || lances[msg.sender] > 0);
          
          address payable destinatario;
          uint valor;
          
          if(msg.sender == dono) {
              destinatario = dono;
              valor = precoAlto;
              valor = 0;
          }
          
          else if(msg.sender == maiorApostador) {
              destinatario = maiorApostador;
              valor = 0;
          }
          
          else {
              destinatario = msg.sender;
              valor = lances[msg.sender];
          }
          
          lances[msg.sender] = 0;
          destinatario.transfer(value);
      }
      
      /**@dev Função para devolver o conteudo do leilao
       * @return, retorna o titulo do leilao
       * @return, retorna o preco inicial do leilao
       * @return, retorna a descricao do leilao
       * @return, retorna o estado do leilao
       */
       function returnContents() public view returns(
            string memory,
            uint,
            string memory,
            Estado
           ) {
               return (
                   titulo,
                   precoInicial,
                   descricao,
                   estadoLeilao
               );
           }
}