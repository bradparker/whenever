import jsrp from "jsrp";

const promisify = (func, thisArg = null) => (...args) => {
  return new Promise((resolve, reject) => {
    func.call(thisArg, ...args, (err, result) => {
      if (err != null) {
        return reject(err);
      }
      return resolve(result);
    });
  });
};

export const createClient = async ({ username, password }) => {
  const client = new jsrp.client({ length: 4096 });
  await promisify(client.init, client)({
    username,
    password
  });
  return {
    createVerifier: promisify(client.createVerifier, client),
    getPublicKey: client.getPublicKey.bind(client),
    setSalt: client.setSalt.bind(client),
    setServerPublicKey: client.setServerPublicKey.bind(client),
    getProof: client.getProof.bind(client),
    checkServerProof: client.checkServerProof.bind(client)
  }
};
