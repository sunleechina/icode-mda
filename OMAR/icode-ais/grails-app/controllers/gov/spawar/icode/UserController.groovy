package gov.spawar.icode

import grails.plugins.springsecurity.Secured
import org.ossim.omar.security.SecUser
import org.ossim.omar.security.SecRole
import org.ossim.omar.security.SecUserSecRole


class UserController {

    def springSecurityService
    def logoutHandlers

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: SecUser.list(params), userInstanceTotal: SecUser.count()]
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params

        return [userInstance: userInstance]
    }

    def save = {
        def userInstance = new User(params)
        userInstance.password = springSecurityService.encodePassword(userInstance.password)

        Add standard Role
        def userRole = SecRole.findByAuthority("ROLE_USER") ?: new SecRole(authority: "ROLE_USER", description: "Standard User").save()

        if (userInstance.save(flush: true)) {
            SecUserSecRole.create(userInstance, userRole)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        def userInstance = SecUser.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userInstance: userInstance]
        }
    }

    def edit = {
        def userInstance = SecUser.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {

                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_USER'])
    def currentUser = {
        def userInstance = SecUser.get(springSecurityService.principal.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            redirect(action: "show", id: userInstance.id)
        }
    }

    @Secured(['ROLE_USER'])
    def countryOfInterestList = {
        def user = User.get(springSecurityService.principal.id)

        def cois = []
        if (user.countryOfInterest) {
            cois = Country.withCriteria {
                'in'("user", user.countryOfInterest)
                order("createdOn", "desc")
            }
        }
        [ cois: cois, coiCount: cois.size() ]
    }

    @Secured(['ROLE_USER'])
    def destinationOfInterestList = {
        def user = User.get(springSecurityService.principal.id)

        def dois = []
        if (user.countryOfInterest) {
            dois = Country.withCriteria {
                'in'("user", user.destinationOfInterest)
                order("createdOn", "desc")
            }
        }
        [ dois: dois, doiCount: dois.size() ]
    }

}
