package gov.spawar.icode

class CallSignPrefixController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [callSignPrefixInstanceList: CallSignPrefix.list(params), callSignPrefixInstanceTotal: CallSignPrefix.count()]
    }

    def create = {
        def callSignPrefixInstance = new CallSignPrefix()
        callSignPrefixInstance.properties = params
        return [callSignPrefixInstance: callSignPrefixInstance]
    }

    def save = {
        def callSignPrefixInstance = new CallSignPrefix(params)
        if (callSignPrefixInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), callSignPrefixInstance.id])}"
            redirect(action: "show", id: callSignPrefixInstance.id)
        }
        else {
            render(view: "create", model: [callSignPrefixInstance: callSignPrefixInstance])
        }
    }

    def show = {
        def callSignPrefixInstance = CallSignPrefix.get(params.id)
        if (!callSignPrefixInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), params.id])}"
            redirect(action: "list")
        }
        else {
            [callSignPrefixInstance: callSignPrefixInstance]
        }
    }

    def edit = {
        def callSignPrefixInstance = CallSignPrefix.get(params.id)
        if (!callSignPrefixInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [callSignPrefixInstance: callSignPrefixInstance]
        }
    }

    def update = {
        def callSignPrefixInstance = CallSignPrefix.get(params.id)
        if (callSignPrefixInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (callSignPrefixInstance.version > version) {
                    
                    callSignPrefixInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'callSignPrefix.label', default: 'CallSignPrefix')] as Object[], "Another user has updated this CallSignPrefix while you were editing")
                    render(view: "edit", model: [callSignPrefixInstance: callSignPrefixInstance])
                    return
                }
            }
            callSignPrefixInstance.properties = params
            if (!callSignPrefixInstance.hasErrors() && callSignPrefixInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), callSignPrefixInstance.id])}"
                redirect(action: "show", id: callSignPrefixInstance.id)
            }
            else {
                render(view: "edit", model: [callSignPrefixInstance: callSignPrefixInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def callSignPrefixInstance = CallSignPrefix.get(params.id)
        if (callSignPrefixInstance) {
            try {
                callSignPrefixInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'callSignPrefix.label', default: 'CallSignPrefix'), params.id])}"
            redirect(action: "list")
        }
    }
}
