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
    # todo: seems to be a bug w/ port, hardcode
    @postdata_port= "3000"
  
    # todo: better way of doing this
    render :template => 'tedpostserver/init.xml.erb'
    logger.debug "raw-out=#{ response.body }"

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
    # todo: find a better way of doing this. I ran into a problem with xpath in a result set
    mtu_idx = 1
    while (mtuSet = doc.xpath("//MTU[#{mtu_idx}]")) do
      break if mtuSet.length == 0
      mtu = mtuSet[0]
      logger.debug "mtu= #{ mtu }"
      mtuID = mtu['ID']
      mtuType = mtu['type']
      cum_idx = 1
      while (cumSet=doc.xpath("//MTU[#{mtu_idx}]/cumulative[#{cum_idx}]")) do
      break if cumSet.length == 0
        cum = cumSet[0]
        logger.debug "cum= #{ cum }"
        cumtime = Time.at( cum['timestamp'].to_i )
        ted_datum = TedDatum.new do |t|
          t.cumtime = cumtime;
          t.mtu = mtuID
          t.mtype = mtuType
          t.watts = cum['watts']
        end
        ted_datum.save
        cum_idx = cum_idx + 1
      end
      mtu_idx = mtu_idx + 1
    end
    
    # update yesterday 
    time = Time.now - 60*60*24
    day = time.strftime("%Y-%m-%d")
    update_day( day )
     
    render :nothing => true
  end
  
end
