import  * as  directives from "./directives";
function install(Vue){
    Object.keys(directives).forEach(name => {
        let directiveInstance=directives[name]
        Vue.directive(name,directiveInstance)
        directiveInstance.installed=true
    });
}
export default install
