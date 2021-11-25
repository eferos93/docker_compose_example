type GreeterRequest { name:string }
type GreeterResponse { response:string }
type Params { port: int }

interface GreeterAPI {
    RequestResponse: hello( GreeterRequest )( GreeterResponse )
}

service Greeter( parameters:Params ) {
    execution: concurrent

    inputPort GreeterInput {
        location: "socker:localhost:" + parameters.port
        protocol: http { format = "html" }
        interface: GreeterAPI
    }

    init {
        global.counter = 0
    }

    main {
        hello( request )( response ) {
            global.counter++
            response.response = "Hello" + request.name + "this page has been visited " + global.counter + "times!"
        }
    }
}