package gov.spawar.icode

/*
    International call signs are formal, semi-permanent, and issued by a nation's telecommunications agency.
    They are used for amateur, broadcast, commercial, maritime and sometimes military radio use (including television in some countries).

    Each country has a set of alphabetic or numeric International Telecommunication Union-designated prefixes with which their call signs must begin. For example:
    Australia uses AX, VH–VN, and VZ.
    Canada uses CF–CK, CY–CZ, VA–VG, VO (Newfoundland and Labrador), VX–VY, and XJ–XO.
    China uses B, XS, 3H–3U.
    Indonesia uses JZ, PK-PO, YB-YH, 7A-7I, and 8A-8I
    Japan uses JA–JS, 7J–7N, and 8J–8N.
    Mexico uses XA–XI, 4A–4C, and 6D–6J.
    Russia uses R and UA–UI.
    Sweden uses SA–SM, 7S, and 8S
    The United Kingdom uses G, M, VS, ZB–ZJ, ZN–ZO, ZQ, and 2.
    The United States uses K, W, N, and AA–AL.

 */

class CallSignPrefix {

    static belongsTo = [country:Country]

    String prefix;


    String toString() { prefix }

    static constraints = {
    }
}
