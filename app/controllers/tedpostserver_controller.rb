class TedpostserverController < ApplicationController

  before_filter :set_format

  $myExpectedToken = "TedPassw0rd22"
  skip_before_filter :verify_authenticity_token
  

  
  def set_format
    params[:format] = :xml
  end

  # PUT /tedpostserver.xml
  def init    
    raw = request.body.read
    logger.debug "raw-in=#{ raw }"
    doc = Nokogiri::XML( raw )
    uniques = doc.xpath("//Unique")
    if (uniques.length != 1) then
		raise "Can't find unique element"
	end

 	@unique = uniques[0].content
 	if (@unique != $myExpectedToken) then
		raise "Doesn't look like my token"
	end
	postdata_rawpath= url_for( :action => 'postdata', :controller => 'tedpostserver') 
	logger.debug "postadata_rawpath=#{postdata_rawpath}"
	postdata_uri= URI( postdata_rawpath )
	logger.debug "postadata_uri=#{postdata_uri}"
	@postdata_urlpath = postdata_uri.path
	@postdata_host= postdata_uri.host
	@postdata_port= "	3000";
	
	render :template => 'tedpostserver/init.xml.erb'
    logger.debug "raw-out=#{ response.body }"
    #respond_to do |format|
    #  format.xml # # erb init.xml.erb
	#end
  end
    
  # PUT /tedpostserver.xml
  def postdata       
    params[:format] = :xml 
    raw = request.body.read
    doc = Nokogiri::XML( raw )
 	tedElement = doc.xpath("/ted5000")[0];
 	logger.debug "tedElement= #{ tedElement }"
 	if (tedElement == nil || tedElement['auth'] != $myExpectedToken) then
		raise "Doesn't look like my token"
	end
    logger.debug "doc= #{ doc }"
    mtus = doc.xpath("//MTU")
    mtus.each do |mtu|
    	logger.debug "mtu= #{ mtu }"
    	mtuID = mtu['ID']
    	mtuType = mtu['type']
    	logger.debug "mtu= #{ mtuID }, type= #{ mtuType }"
      	cums=mtu.xpath("//cumulative")
      	cums.each do |cum|
      	    logger.debug "timestamp= #{ cum['timestamp'] }, watts= #{ cum['watts'] }"
			ted_datum = TedDatum.new do |t|
				t.cumtime = cum['timestamp']
				t.mtu = mtuID
				t.mtype = mtuType
				t.watts = cum['watts']
			end
  			ted_datum.save
      	end
    end
	render :nothing => true
  end
  
end
