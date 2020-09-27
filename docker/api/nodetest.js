var Docker = require('dockerode');
var docker = new Docker({socketPath: '/var/run/docker.sock'});
// var docker1 = new Docker(); //defaults to above if env variables are not used
// var docker2 = new Docker({host: 'http://192.168.1.10', port: 3000});
// var docker3 = new Docker({protocol:'http', host: '127.0.0.1', port: 3000});
// var docker4 = new Docker({host: '127.0.0.1', port: 3000}); //defaul'


docker.listContainers(function (err, containers) {
     console.log(JSON.stringify(containers))
});