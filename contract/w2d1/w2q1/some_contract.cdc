access(all) contract SomeContract {
    pub var testStruct: SomeStruct

    pub struct SomeStruct {
        // 4 Variables
        //this is available to read and write from all scopes. 
        pub(set) var a: String

        //this is available to read from all scopes.
        //but only writable for current & inner scope.
        pub var b: String

        //this is available to read current, inner, & contract scope.
        //but only writable for current & inner scope.
        access(contract) var c: String

        //this is available to read current, inner scope. 
        //but only writable for current & inner scope.
        access(self) var d: String

        // 3 Functions
        //this is available to call from all scopes.
        pub fun publicFunc() {}

        //this is available to call from current, inner scope.
        access(self) fun privateFunc() {}

        //this is available to call from current, inner, & contract scope.
        access(contract) fun contractFunc() {}


        pub fun structFunc() {
            // Area 1
            //you can read & write for variable a. 
            //you can read & write for variable b. 
            //you can read & write for variable c. 
            //you can read & write for variable d. 
            //you can call for function publicFunc().
            //you can call for function privateFunc().
            //you can call for function contractFunc().
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {
        pub var e: Int

        pub fun resourceFunc() {
            // Area 2
            //you can read & write for variable a. 
            //you can read for variable b, can't write to variable b. 
            //you can read for variable c, can't write to variable c. 
            //you can't read for variable d, can't write to variable d.
            //you can call for function publicFunc().
            //you can't call for function privateFunc().
            //you can call for function contractFunc().
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {
        return <- create SomeResource()
    }

    pub fun questsAreFun() {
        // Area 3
       
        //you can read & write for variable a. 
        //you can read for variable b, can't write to variable b. 
        //you can read for variable c, can't write to variable c. 
        //you can't read for variable d, can't write to variable d.
        //you can call for function publicFunc().
        //you can't call for function privateFunc().
        //you can call for function contractFunc().
    }

    init() {
        self.testStruct = SomeStruct()
    }
}
