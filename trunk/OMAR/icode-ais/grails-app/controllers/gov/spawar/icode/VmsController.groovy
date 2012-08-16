package gov.spawar.icode

import org.springframework.dao.DataIntegrityViolationException

class VmsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [vmsInstanceList: Vms.list(params), vmsInstanceTotal: Vms.count()]
    }

    def create() {
        [vmsInstance: new Vms(params)]
    }

    def save() {
        def vmsInstance = new Vms(params)
        if (!vmsInstance.save(flush: true)) {
            render(view: "create", model: [vmsInstance: vmsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'vms.label', default: 'Vms'), vmsInstance.id])
        redirect(action: "show", id: vmsInstance.id)
    }

    def show() {
        def vmsInstance = Vms.get(params.id)
        if (!vmsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vms.label', default: 'Vms'), params.id])
            redirect(action: "list")
            return
        }

        [vmsInstance: vmsInstance]
    }

    def edit() {
        def vmsInstance = Vms.get(params.id)
        if (!vmsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vms.label', default: 'Vms'), params.id])
            redirect(action: "list")
            return
        }

        [vmsInstance: vmsInstance]
    }

    def update() {
        def vmsInstance = Vms.get(params.id)
        if (!vmsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vms.label', default: 'Vms'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (vmsInstance.version > version) {
                vmsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'vms.label', default: 'Vms')] as Object[],
                        "Another user has updated this Vms while you were editing")
                render(view: "edit", model: [vmsInstance: vmsInstance])
                return
            }
        }

        vmsInstance.properties = params

        if (!vmsInstance.save(flush: true)) {
            render(view: "edit", model: [vmsInstance: vmsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'vms.label', default: 'Vms'), vmsInstance.id])
        redirect(action: "show", id: vmsInstance.id)
    }

    def delete() {
        def vmsInstance = Vms.get(params.id)
        if (!vmsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vms.label', default: 'Vms'), params.id])
            redirect(action: "list")
            return
        }

        try {
            vmsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'vms.label', default: 'Vms'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'vms.label', default: 'Vms'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
