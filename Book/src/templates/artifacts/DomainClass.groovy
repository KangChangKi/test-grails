@artifact.package@class @artifact.name@ {

  /* ref: hasMany: http://grails.org/doc/latest/ref/Domain%20Classes/hasMany.html
   * ref: belongsTo: http://grails.org/doc/latest/ref/Domain%20Classes/belongsTo.html
   * ref: hasOne: http://grails.org/doc/latest/ref/Domain%20Classes/hasOne.html
   * 
   * examples:
   * static hasMany = [books: Book]
   * static belongsTo = [author: Author]
   * static hasOne = [nose: Nose]
   */

   // ref: constraints: http://grails.org/doc/latest/ref/Constraints/Usage.html
  static constraints = {
    /*
      login size: 5..15, blank: false, unique: true
      password size: 5..15, blank: false
      email email: true, blank: false
      age min: 18
      address nullable: true

      // blank means empty string like ''
      // nullable means null
     */
  }

  // ref: mapping: http://grails.org/doc/latest/ref/Database%20Mapping/Usage.html
  static mapping = {
    batchSize 10
    /*
      table "md_device"

      id generator: 'org.hibernate.id.enhanced.TableGenerator', params:[table_name:"md_ids", segment_value:"md_device"]

      udid index:'Aaa_Idx'
      macAddress index:'Aaa_Idx, Bbb_Idx'
      phoneNumber index:'Bbb_Idx, Ccc_Idx'

      // Aaa_Idx: (macAddress, udid) // alphabetic order!!!
      // Bbb_Idx: (macAddress, phoneNumber)
      // Ccc_Idx: (phoneNumber)

      // ==> Or create indexes in DB directly!!!
     */
  }

  // Remove all rows in the table.
  static def removeAll() {
    @artifact.name@.executeUpdate('delete from @artifact.name@')
  }

  /* Return representative string of fields of this object.
  String toString() {
    "${title}(${name})"
  }
  */
}
