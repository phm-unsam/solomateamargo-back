pragma solidity >=0.4.21 <0.7.0;

contract Wallet {

    mapping(address => int256) public wallet;

    modifier positive(int256 value) {
        require(value > 0, "Pero tio... el valor que ha ingresado debe de ser positivo...");
        _;
    }

    // poner pasta en la billetera
    function put(address owner, int256 cost) public positive(cost) {
        int256 money = wallet[owner];
        money = money + cost;
        wallet[owner] = money;
    }

    // sacar pasta de la billetera
    function withdraw(address owner, int256 cost) public positive(cost) {
        int256 money = wallet[owner];
        require(money >= cost, "No tiene suficiente pasta.");
        money = money - cost;
        wallet[owner] = money;
    }

    function balance(address owner) public view returns (int256) {
        return wallet[owner];
    }

}