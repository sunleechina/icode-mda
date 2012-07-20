package gov.spawar.icode

import org.springframework.dao.DataIntegrityViolationException

class RadarSurfTrackController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [radarSurfTrackInstanceList: RadarSurfTrack.list(params), radarSurfTrackInstanceTotal: RadarSurfTrack.count()]
    }

    def create() {
        [radarSurfTrackInstance: new RadarSurfTrack(params)]
    }

    def save() {
        def radarSurfTrackInstance = new RadarSurfTrack(params)
        if (!radarSurfTrackInstance.save(flush: true)) {
            render(view: "create", model: [radarSurfTrackInstance: radarSurfTrackInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), radarSurfTrackInstance.id])
        redirect(action: "show", id: radarSurfTrackInstance.id)
    }

    def show() {
        def radarSurfTrackInstance = RadarSurfTrack.get(params.id)
        if (!radarSurfTrackInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), params.id])
            redirect(action: "list")
            return
        }

        [radarSurfTrackInstance: radarSurfTrackInstance]
    }

    def edit() {
        def radarSurfTrackInstance = RadarSurfTrack.get(params.id)
        if (!radarSurfTrackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), params.id])
            redirect(action: "list")
            return
        }

        [radarSurfTrackInstance: radarSurfTrackInstance]
    }

    def update() {
        def radarSurfTrackInstance = RadarSurfTrack.get(params.id)
        if (!radarSurfTrackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (radarSurfTrackInstance.version > version) {
                radarSurfTrackInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack')] as Object[],
                          "Another user has updated this RadarSurfTrack while you were editing")
                render(view: "edit", model: [radarSurfTrackInstance: radarSurfTrackInstance])
                return
            }
        }

        radarSurfTrackInstance.properties = params

        if (!radarSurfTrackInstance.save(flush: true)) {
            render(view: "edit", model: [radarSurfTrackInstance: radarSurfTrackInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), radarSurfTrackInstance.id])
        redirect(action: "show", id: radarSurfTrackInstance.id)
    }

    def delete() {
        def radarSurfTrackInstance = RadarSurfTrack.get(params.id)
        if (!radarSurfTrackInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), params.id])
            redirect(action: "list")
            return
        }

        try {
            radarSurfTrackInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
