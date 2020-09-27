
import { sayHello } from "./greet";
function hello(compiler: string) {
    console.log(`Hello from ${compiler}`);
}
console.log(sayHello("TypeScript"));
// hello("TypeScript");