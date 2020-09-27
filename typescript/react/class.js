class Component{
    constructor(props){
          this.props = props
          this.state = {}
    }
    setState(state){
          Object.assign(this.state,state)
          renderComponent(this)
          
    }
    forceUpdate(){   // 强制更新
          renderComponent(this)
    }
    
}