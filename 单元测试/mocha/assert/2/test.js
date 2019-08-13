const assert = require("assert");

const sum = require("./2.js");
const asyncSum = require("./asyncSum.js");
// describe 描述
describe("描述describe", () => {
  describe("#sum()", () => {
    it("sum() should return 0", () => {
      assert.strictEqual(sum(), 0);
    });

    it("sum(1) should return 1", () => {
      assert.strictEqual(sum(2), 2);
    });

    it("sum(1, 2) should return 3", () => {
      assert.strictEqual(sum(1, 2), 3);
    });

    it("sum(1, 2, 3) should return 6", () => {
      assert.strictEqual(sum(1, 2, 3), 6);
    });
  });
});

describe("钩子 each before after ...", () => {
  before(function() {
    console.log("before:");
  });

  after(function() {
    console.log("after.");
  });

  beforeEach(function() {
    console.log("  beforeEach:");
  });

  afterEach(function() {
    console.log(" afterEach.");
  });

  it("sum() should return 0", () => {
    assert.strictEqual(sum(), 0);
  });

  it("sum(1) should return 1", () => {
    assert.strictEqual(sum(1), 1);
  });
});

let num = 0;
describe("async await 异步", function() {
  this.timeout(0);
  it("sum() should return 0", async () => {
    num = await asyncSum(2);
    assert.strictEqual(num, 2);
  });

  it("sum(1) should return 1", () => {
    console.log(num);
    assert.strictEqual(num, 2);
  });
});
