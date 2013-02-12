package gov.spawar.icode

import java.text.SimpleDateFormat

class AisController
{

    //static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def aisMapService
    def timeLocationService
    def grailsApplication

    def index = {
        redirect( action: "list", params: params )
    }

    def list = {
        params.max = Math.min( params.max ? params.int( 'max' ) : 10, 100 )
        [aisInstanceList: Ais.list( params ), aisInstanceTotal: Ais.count()]
    }

    def create = {
        def aisInstance = new Ais()
        aisInstance.properties = params
        return [aisInstance: aisInstance]
    }

    def save = {
        def aisInstance = new Ais( params )
        if ( aisInstance.save( flush: true ) )
        {
            flash.message = "${message( code: 'default.created.message', args: [message( code: 'ais.label', default: 'Ais' ), aisInstance.id] )}"
            redirect( action: "show", id: aisInstance.id )
        }
        else
        {
            render( view: "create", model: [aisInstance: aisInstance] )
        }
    }

    def show = {
        def aisInstance = Ais.get( params.id )
        if ( !aisInstance )
        {
            flash.message = "${message( code: 'default.not.found.message', args: [message( code: 'ais.label', default: 'Ais' ), params.id] )}"
            redirect( action: "list" )
        }
        else
        {
            [aisInstance: aisInstance]
        }
    }

    def edit = {
        def aisInstance = Ais.get( params.id )
        if ( !aisInstance )
        {
            flash.message = "${message( code: 'default.not.found.message', args: [message( code: 'ais.label', default: 'Ais' ), params.id] )}"
            redirect( action: "list" )
        }
        else
        {
            return [aisInstance: aisInstance]
        }
    }

    def update = {
        def aisInstance = Ais.get( params.id )
        if ( aisInstance )
        {
            if ( params.version )
            {
                def version = params.version.toLong()
                if ( aisInstance.version > version )
                {

                    aisInstance.errors.rejectValue( "version", "default.optimistic.locking.failure", [message( code: 'ais.label', default: 'Ais' )] as Object[], "Another user has updated this Ais while you were editing" )
                    render( view: "edit", model: [aisInstance: aisInstance] )
                    return
                }
            }
            aisInstance.properties = params
            if ( !aisInstance.hasErrors() && aisInstance.save( flush: true ) )
            {
                flash.message = "${message( code: 'default.updated.message', args: [message( code: 'ais.label', default: 'Ais' ), aisInstance.id] )}"
                redirect( action: "show", id: aisInstance.id )
            }
            else
            {
                render( view: "edit", model: [aisInstance: aisInstance] )
            }
        }
        else
        {
            flash.message = "${message( code: 'default.not.found.message', args: [message( code: 'ais.label', default: 'Ais' ), params.id] )}"
            redirect( action: "list" )
        }
    }

    def delete = {
        def aisInstance = Ais.get( params.id )
        if ( aisInstance )
        {
            try
            {
                aisInstance.delete( flush: true )
                flash.message = "${message( code: 'default.deleted.message', args: [message( code: 'ais.label', default: 'Ais' ), params.id] )}"
                redirect( action: "list" )
            }
            catch ( org.springframework.dao.DataIntegrityViolationException e )
            {
                flash.message = "${message( code: 'default.not.deleted.message', args: [message( code: 'ais.label', default: 'Ais' ), params.id] )}"
                redirect( action: "show", id: params.id )
            }
        }
        else
        {
            flash.message = "${message( code: 'default.not.found.message', args: [message( code: 'ais.label', default: 'Ais' ), params.id] )}"
            redirect( action: "list" )
        }
    }


    def map = {
        def useTileCache = grailsApplication.config.wms.tilecache.enabled?.toBoolean()
        def hostAddress = InetAddress.localHost.hostAddress

        def viewModel = [:]

        if ( useTileCache )
        {
            //////////////////////////////////////
            //Base Layers with Tilecache
            /////////////////////////////////////
            def tileCacheURL = "http://${hostAddress}/tilecache/tilecache.py";

            viewModel['map1'] = [url: tileCacheURL, layers: 'vmapBasic']
            viewModel['map2'] = [url: tileCacheURL, layers: 'omar']
            viewModel['map3'] = [url: tileCacheURL, layers: 'vmapLabels']
            viewModel['map4'] = [url: tileCacheURL, layers: 'iCubed']
            viewModel['map5'] = [url: tileCacheURL, layers: 'onEarth']
        }
        else
        {
            //////////////////////////////////////
            //Base Layers without Tilecache
            /////////////////////////////////////
            def mapServerURL = "http://${hostAddress}/cgi-bin/mapserv?map=/data/omar/bmng.map&"
            def vmapServerURL = "http://vmap0.tiles.osgeo.org/wms/vmap0"

            viewModel['map1'] = [url: vmapServerURL, layers: 'basic']
            viewModel['map2'] = [url: mapServerURL, layers: 'Reference']
            viewModel['map3'] = [url: vmapServerURL, layers: 'clabel,ctylabel,statelabel']
            viewModel['map4'] = [url: 'http://hyperquad.ucsd.edu/cgi-bin/i-cubed', layers: 'icubed']
            viewModel['map5'] = [url: 'http://hyperquad.ucsd.edu/cgi-bin/onearth', layers: 'OnEarth']
        }


        render view: 'map3', model: viewModel
    }

    //CurrentLocation Action to display position of AIS
    def currentLocation = {
        timeLocationService.currentLocation( params, response )
    }

    //radarCurrentLocation Action to display position of Radar
    def radarCurrentLocation = {
        timeLocationService.radarCurrentLocation( params, response )
    }


    //radarCurrentLocation Action to display position of Radar
    def vmsCurrentLocation = {
        timeLocationService.vmsCurrentLocation( params, response )
    }

    //vesselTracks Action used to display AIS Track information
    def vesselTracks = {
        timeLocationService.vesselTracks( params, response )
    }

}
