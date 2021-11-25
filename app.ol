type GreeterRequest { name:string }
type GreeterResponse { response:string }

interface GreeterAPI {
    RequestResponse: hello( GreeterRequest )( GreeterResponse )
}

service Greeter {
    execution: concurrent

    inputPort GreeterInput {
        location: "socket://localhost:8000/"
        protocol: http { format = "json" }
        interfaces: GreeterAPI
    }

    init {
        global.counter = 0
    }

    main {
        hello( request )( response ) {
            global.counter++
            response.response = "Hello " + request.name + " this page has been visited " + global.counter + " times!"
        }
    }
}