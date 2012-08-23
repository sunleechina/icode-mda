package gov.spawar.icode



import org.junit.*
import grails.test.mixin.*

@TestFor(RadarSurfTrackController)
@Mock(RadarSurfTrack)
class RadarSurfTrackControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/radarSurfTrack/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.radarSurfTrackInstanceList.size() == 0
        assert model.radarSurfTrackInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.radarSurfTrackInstance != null
    }

    void testSave() {
        controller.save()

        assert model.radarSurfTrackInstance != null
        assert view == '/radarSurfTrack/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/radarSurfTrack/show/1'
        assert controller.flash.message != null
        assert RadarSurfTrack.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/radarSurfTrack/list'


        populateValidParams(params)
        def radarSurfTrack = new RadarSurfTrack(params)

        assert radarSurfTrack.save() != null

        params.id = radarSurfTrack.id

        def model = controller.show()

        assert model.radarSurfTrackInstance == radarSurfTrack
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/radarSurfTrack/list'


        populateValidParams(params)
        def radarSurfTrack = new RadarSurfTrack(params)

        assert radarSurfTrack.save() != null

        params.id = radarSurfTrack.id

        def model = controller.edit()

        assert model.radarSurfTrackInstance == radarSurfTrack
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/radarSurfTrack/list'

        response.reset()


        populateValidParams(params)
        def radarSurfTrack = new RadarSurfTrack(params)

        assert radarSurfTrack.save() != null

        // test invalid parameters in update
        params.id = radarSurfTrack.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/radarSurfTrack/edit"
        assert model.radarSurfTrackInstance != null

        radarSurfTrack.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/radarSurfTrack/show/$radarSurfTrack.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        radarSurfTrack.clearErrors()

        populateValidParams(params)
        params.id = radarSurfTrack.id
        params.version = -1
        controller.update()

        assert view == "/radarSurfTrack/edit"
        assert model.radarSurfTrackInstance != null
        assert model.radarSurfTrackInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/radarSurfTrack/list'

        response.reset()

        populateValidParams(params)
        def radarSurfTrack = new RadarSurfTrack(params)

        assert radarSurfTrack.save() != null
        assert RadarSurfTrack.count() == 1

        params.id = radarSurfTrack.id

        controller.delete()

        assert RadarSurfTrack.count() == 0
        assert RadarSurfTrack.get(radarSurfTrack.id) == null
        assert response.redirectedUrl == '/radarSurfTrack/list'
    }
}
