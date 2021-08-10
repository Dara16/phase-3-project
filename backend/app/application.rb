class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # MEMBER ROUTES

    # Member Index

    if req.path == ('/members') && req.get?
      return [200, {'Content-Type' => 'application/json'}, [Member.all.to_json]]
    end

    # Member Create

    if req.path == ('/members') && req.post?
      body = JSON.parse(req.body.read)
      member = Member.create(body)
      return [201, {'Content-Type' => 'application/json'}, [member.to_json]]
    end

    #Member Show 

    if req.path.match('/members/') && req.get?
      id = req.path.split('/')[2]
      begin
        member = Member.find(id)
        return [200, {'Content-Type' => 'application/json'}, [member.to_json]]
      rescue
        return [404, {'Content-Type' => 'application/json'}, [{message: "Member not found"}.to_json]]
      end
    end

    # Member Update

    if req.path.match('/members/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        member = Member.find(id)
        member.update(body)
        return [202, {'Content-Type' => 'application/json'}, [member.to_json]]
      rescue ActiveRecord::RecordNotFound
        return [404, {'Content-Type' => 'application/json'}, [{message: "Something went wrong"}.to_json]]
      end

      # only one type of rescue required for this project if at all
      #below is an example  

      # rescue ActiveRecord::UnknownAttributeError
        # return [422, {'Content-Type' => 'application/json'}, [{message: "Could not process your update request"}.to_json]]
      # end
    end


    # Member Delete




   
   
    # static route to test rack
   
   
    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]


    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
