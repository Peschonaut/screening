module.exports = {
  servers: {
    one: {
      host: '46.101.102.218',
      username: 'root',
    },
  },
  meteor: {
    name: 'Screening',
    path: './../',
    servers: {
      one: {},
    },
    env: {
      ROOT_URL: 'http://46.101.102.218',
      MONGO_URL: 'mongodb://localhost/meteor',
      PORT: "3000"
    },
    dockerImage: 'abernix/meteord:base'
  },
  mongo: {
    version: '3.4.1',
    servers: {
      one: {}
    }
  }
};
