package gov.spawar.icode

import org.springframework.dao.DataIntegrityViolationException

class RadarAirTrackController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [radarAirTrackInstanceList: RadarAirTrack.list(params), radarAirTrackInstanceTotal: RadarAirTrack.count()]
    }

    def create() {
        [radarAirTrackInstance: new RadarAirTrack(params)]
    }

    def save() {
        def radarAirTrackInstance = new RadarAirTrack(params)
        if (!radarAirTrackInstance.save(flush: true)) {
            render(view: "create", model: [radarAirTrackInstance: radarAirTrackInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), radarAirTrackInstance.id])
        redirect(action: "show", id: radarAirTrackInstance.id)
    }

    def show() {
        def radarAirTrackInstance = RadarAirTrack.get(params.id)
        if (!radarAirTrackInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), params.id])
            redirect(action: "list")
            return
        }

        [radarAirTrackInstance: radarAirTrackInstance]
    }

    def edit() {
        def radarAirTrackInstance = RadarAirTrack.get(params.id)
        if (!radarAirTrackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), params.id])
            redirect(action: "list")
            return
        }

        [radarAirTrackInstance: radarAirTrackInstance]
    }

    def update() {
        def radarAirTrackInstance = RadarAirTrack.get(params.id)
        if (!radarAirTrackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (radarAirTrackInstance.version > version) {
                radarAirTrackInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'radarAirTrack.label', default: 'RadarAirTrack')] as Object[],
                          "Another user has updated this RadarAirTrack while you were editing")
                render(view: "edit", model: [radarAirTrackInstance: radarAirTrackInstance])
                return
            }
        }

        radarAirTrackInstance.properties = params

        if (!radarAirTrackInstance.save(flush: true)) {
            render(view: "edit", model: [radarAirTrackInstance: radarAirTrackInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), radarAirTrackInstance.id])
        redirect(action: "show", id: radarAirTrackInstance.id)
    }

    def delete() {
        def radarAirTrackInstance = RadarAirTrack.get(params.id)
        if (!radarAirTrackInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), params.id])
            redirect(action: "list")
            return
        }

        try {
            radarAirTrackInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'radarAirTrack.label', default: 'RadarAirTrack'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
