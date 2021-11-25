type GreeterRequest { name:string }
type GreeterResponse { greeting:string }

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
            response.greeting = "Hello " + request.name + " the request 'hello' has been made " + global.counter + " times!"
            
        }
    }
}