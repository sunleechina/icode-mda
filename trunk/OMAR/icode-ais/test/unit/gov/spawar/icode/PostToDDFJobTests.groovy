package gov.spawar.icode



class PostToDDFJobTests {
    PostToDDFJob job

    void setUp() {
        job = new PostToDDFJob()
    }

    void testJobExecution() {
        // count # of keys in table
        job.execute()
        // assert no keys in table or x deleted
    }
}
