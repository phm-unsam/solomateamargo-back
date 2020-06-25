const Wallet = artifacts.require('./Wallet.sol')
const assert = require('assert')

let walletSmartContract

contract('La wallet arranca con 250.', async (accounts) => {
    const theAccount = accounts[1]
    beforeEach('Arrancando...', async () => {
        walletSmartContract = await Wallet.new()  // vs. deployed() que devuelve un singleton
        await walletSmartContract.put(theAccount, 250)
        const balance = await walletSmartContract.wallet.call(theAccount)
        assert.equal(250, balance)
    })
    it('Puedo comprar un pasaje si tengo la pasta suficiente..', async () => {
        await walletSmartContract.withdraw(theAccount, 100)
        const balance = await walletSmartContract.wallet.call(theAccount)
        assert.equal(balance, 150)
    })
    it('No te puedes gastar toda la pasta en ese pasaje tio..', async () => {
        await walletSmartContract.withdraw(theAccount, 250)
        const balance = await walletSmartContract.wallet.call(theAccount)
        assert.equal(balance, 0)
    })
    it('No existen los pasajes a 0 ETHs gilipollas..', () => {
        testRejection(async () => { await walletSmartContract.withdraw(theAccount, 0) }, 'Pero tio... el valor que ha ingresado debe de ser positivo...')
    })
    it('Estoy flipando tio.. quieres un pasaje con valor negativo?', () => {
        testRejection(async () => { await walletSmartContract.withdraw(theAccount, -10) }, 'Pero tio... el valor que ha ingresado debe de ser positivo...')
    })
    it('TIO? Que estais intentando? Vuelve a trabajar maldito plebello!', () => {
        testRejection(async () => { await walletSmartContract.withdraw(theAccount, 270) }, 'No tiene suficiente pasta.')
    })
    it('Podre poner plata? CLARO TIO.', async () => {
        await walletSmartContract.put(theAccount, 100)
        const balance = await walletSmartContract.wallet.call(theAccount)
        assert.equal(balance, 350)
    })
    it('Pero hombre, que estais intentando? No puedes ingresar 0 ETHs a tu billetera...', () => {
        testRejection(async () => { await walletSmartContract.put(theAccount, 0) }, 'Pero tio... el valor que ha ingresado debe de ser positivo...')
    })
    it('WHAT? No puedes poner algo negativo, tio.', () => {
        testRejection(async () => { await walletSmartContract.put(theAccount, -10) }, 'Pero tio... el valor que ha ingresado debe de ser positivo...')
    })
    it('Acaso quiere irse con su pareja de viaje, tio? Lo intentaremos', async () => {
        await walletSmartContract.withdraw(theAccount, 100)
        await walletSmartContract.withdraw(theAccount, 100)       
        const balance = await walletSmartContract.wallet.call(theAccount)
        assert.equal(balance, 50)
    })
})

async function testRejection(callback, errorMessage) {
    try {
        await callback()
        assert.fail('Deberia haber pinchado, tio.')
    } catch (e) {
        assert.equal(e.reason, errorMessage)
    }
}