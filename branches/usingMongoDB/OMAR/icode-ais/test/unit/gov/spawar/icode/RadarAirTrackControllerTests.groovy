package gov.spawar.icode



import org.junit.*
import grails.test.mixin.*

@TestFor(RadarAirTrackController)
@Mock(RadarAirTrack)
class RadarAirTrackControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/radarAirTrack/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.radarAirTrackInstanceList.size() == 0
        assert model.radarAirTrackInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.radarAirTrackInstance != null
    }

    void testSave() {
        controller.save()

        assert model.radarAirTrackInstance != null
        assert view == '/radarAirTrack/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/radarAirTrack/show/1'
        assert controller.flash.message != null
        assert RadarAirTrack.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/radarAirTrack/list'


        populateValidParams(params)
        def radarAirTrack = new RadarAirTrack(params)

        assert radarAirTrack.save() != null

        params.id = radarAirTrack.id

        def model = controller.show()

        assert model.radarAirTrackInstance == radarAirTrack
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/radarAirTrack/list'


        populateValidParams(params)
        def radarAirTrack = new RadarAirTrack(params)

        assert radarAirTrack.save() != null

        params.id = radarAirTrack.id

        def model = controller.edit()

        assert model.radarAirTrackInstance == radarAirTrack
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/radarAirTrack/list'

        response.reset()


        populateValidParams(params)
        def radarAirTrack = new RadarAirTrack(params)

        assert radarAirTrack.save() != null

        // test invalid parameters in update
        params.id = radarAirTrack.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/radarAirTrack/edit"
        assert model.radarAirTrackInstance != null

        radarAirTrack.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/radarAirTrack/show/$radarAirTrack.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        radarAirTrack.clearErrors()

        populateValidParams(params)
        params.id = radarAirTrack.id
        params.version = -1
        controller.update()

        assert view == "/radarAirTrack/edit"
        assert model.radarAirTrackInstance != null
        assert model.radarAirTrackInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/radarAirTrack/list'

        response.reset()

        populateValidParams(params)
        def radarAirTrack = new RadarAirTrack(params)

        assert radarAirTrack.save() != null
        assert RadarAirTrack.count() == 1

        params.id = radarAirTrack.id

        controller.delete()

        assert RadarAirTrack.count() == 0
        assert RadarAirTrack.get(radarAirTrack.id) == null
        assert response.redirectedUrl == '/radarAirTrack/list'
    }
}
