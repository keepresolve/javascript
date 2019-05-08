

var assert = require('assert'); //断言库  就是最终的判断
// describe 只是一个描述当前是什么任务
// describe('Array', function () {
describe('#indexOf()', function () {
    it('当值不存在返回-1', function () {
        assert.equal([1, 2, 3].indexOf(4), -1);
    });
    it('当值存在返回 1', function () {
        assert.equal([1, 2, 4].indexOf(4), 2);
    });
    //done异步只能执行一次
    it('double done', function (done) {
        // Calling `done()` twice is an error
        setImmediate(done);
        // setImmediate(done);
    });

});
// });


// 异步处理——————————————————————————————————
// describe('User', function () {
//     describe('#save()', function () {
//         it('should save without error', function (done) {
//             var user = new User('Luna');
//             user.save(function (err) {
//                 if (err) done(err);
//                 else done();
//             });
//         });
//     });
// });
// 为了使事情变得更容易，done()回调也接受一个Error实例（即new Error()），所以我们可以直接使用它：
// describe('User2', function () {
//     describe('#save()', function () {
//         it('should save without error', function (done) {
//             var user = new User('Luna');
//             user.save(done);
//         });
//     });
// });


// Promise
// beforeEach(function () {
//     return db.clear()
//         .then(function () {
//             return db.save([tobi, loki, jane]);
//         });
// });

// describe('#find()', function () {
//     it('respond with matching records', function () {
//         return db.find({ type: 'User' }).should.eventually.have.length(3);
//     });
// });

// 钩子函数————————————————————————
describe('hooks', function () {

    before(function () {
        console.log(" before在此块中的所有测试之前运行")
        // 在此块中的所有测试之前运行
    });
    it('test1', function (done) {
        var number = Math.random() * 100;
        assert.equal(number > 50, true)
        done()
    });
    it('test2', function (done) {
        var user = 12321312;
        done()
    });
    after(function () {
        console.log("after在此块中的所有测试之后运行")

    });
    it('test3', function (done) {
        var user = 12321312;
        done()
    });

    beforeEach(function () {
        console.log("beforeEach在此块中的每个测试之前运行")

    });

    afterEach(function () {
        console.log("afterEach在此块中的每个测试之后运行")
        // 在此块中的每个测试之后运行
    });
    // test cases
});


// 等待编写的测试用例  
describe('Array', function () {
    describe('#indexOf()', function () {
        // pending test below
        it('should return -1 when the value is not present');
    });
});
//   其他的都不执行了 only skip是跳过执行其他的
//   describe('Array', function() {
//     describe.only('#indexOf()', function() {
//         it('其他的都不执行了',function(done){
//             done()
//         })
//     });
//   });


// describe('#indexOf()', function() {
//     it('1',function(done){
//         done()
//     })
//     it.only('2',function(done){
//         done()
//     })
// });
// var assert = require('chai').assert;

function add() {
    return Array.prototype.slice.call(arguments).reduce(function (prev, curr) {
        return prev + curr;
    }, 0);
}

describe('add()', function () {
    var tests = [
        { args: [1, 2], expected: 3 },
        { args: [1, 2, 3], expected: 6 },
        { args: [1, 2, 3, 4], expected: 10 }
    ];

    tests.forEach(function (test) {
        it('correctly adds ' + test.args.length + ' args', function () {
            var res = add.apply(null, test.args);
            assert.equal(res, test.expected);
        });
    });
});
// 测试持续时间
describe('something slow', function() {
    this.slow(60000);
  
    it('should take long enough for me to go make a sandwich', function() {
      // ...
    });
  });

 //超时
  describe('a suite of tests', function() {
    this.timeout(500);
  
    it('should take less than 500ms', function(done){
      setTimeout(done, 600);
    });
  
    it('should take less than 500ms as well', function(done){
      setTimeout(done, 250);
    });
  })


// 过滤运行
//   mocha --grep something