package gov.spawar.icode

class MaritimeIdDigitController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [maritimeIdDigitInstanceList: MaritimeIdDigit.list(params), maritimeIdDigitInstanceTotal: MaritimeIdDigit.count()]
    }

    def create = {
        def maritimeIdDigitInstance = new MaritimeIdDigit()
        maritimeIdDigitInstance.properties = params
        return [maritimeIdDigitInstance: maritimeIdDigitInstance]
    }

    def save = {
        def maritimeIdDigitInstance = new MaritimeIdDigit(params)
        if (maritimeIdDigitInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), maritimeIdDigitInstance.id])}"
            redirect(action: "show", id: maritimeIdDigitInstance.id)
        }
        else {
            render(view: "create", model: [maritimeIdDigitInstance: maritimeIdDigitInstance])
        }
    }

    def show = {
        def maritimeIdDigitInstance = MaritimeIdDigit.get(params.id)
        if (!maritimeIdDigitInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), params.id])}"
            redirect(action: "list")
        }
        else {
            [maritimeIdDigitInstance: maritimeIdDigitInstance]
        }
    }

    def edit = {
        def maritimeIdDigitInstance = MaritimeIdDigit.get(params.id)
        if (!maritimeIdDigitInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [maritimeIdDigitInstance: maritimeIdDigitInstance]
        }
    }

    def update = {
        def maritimeIdDigitInstance = MaritimeIdDigit.get(params.id)
        if (maritimeIdDigitInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (maritimeIdDigitInstance.version > version) {
                    
                    maritimeIdDigitInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit')] as Object[], "Another user has updated this MaritimeIdDigit while you were editing")
                    render(view: "edit", model: [maritimeIdDigitInstance: maritimeIdDigitInstance])
                    return
                }
            }
            maritimeIdDigitInstance.properties = params
            if (!maritimeIdDigitInstance.hasErrors() && maritimeIdDigitInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), maritimeIdDigitInstance.id])}"
                redirect(action: "show", id: maritimeIdDigitInstance.id)
            }
            else {
                render(view: "edit", model: [maritimeIdDigitInstance: maritimeIdDigitInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def maritimeIdDigitInstance = MaritimeIdDigit.get(params.id)
        if (maritimeIdDigitInstance) {
            try {
                maritimeIdDigitInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'maritimeIdDigit.label', default: 'MaritimeIdDigit'), params.id])}"
            redirect(action: "list")
        }
    }
}
